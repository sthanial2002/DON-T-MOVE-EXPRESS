import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fuodz/models/flash_sale.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/models/user.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/requests/flash_sale.request.dart';
import 'package:fuodz/requests/search.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/view_models/search_filter.vm.dart';
import 'package:fuodz/widgets/bottomsheets/search_filter.bottomsheet.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class VendorViewModel extends MyBaseViewModel {
  //
  SearchFilterViewModel searchFilterVM;
  String keyword = "";
  FlashSaleRequest _flashSaleRequest = FlashSaleRequest();
  List<FlashSale> flashSales = [];
  List<Product> flashSaleItems = [];
  List<dynamic> searchResults = [];
  SearchRequest _searchRequest = SearchRequest();
  Search search;
  VendorViewModel(BuildContext context, VendorType vendorType) {
    this.viewContext = context;
    this.vendorType = vendorType;
    this.search = Search(vendorType: vendorType);
  }
  //
  User currentUser;
  StreamSubscription currentLocationChangeStream;

  //
  int queryPage = 1;

  RefreshController refreshController = RefreshController();

  void initialise() async {
    await fetchFlashSaleItems();
    // await showFilterOptions();
    //
    if (AuthServices.authenticated()) {
      currentUser = await AuthServices.getCurrentUser(force: true);
      notifyListeners();
    }

    //listen to user location change
    currentLocationChangeStream =
        LocationService.currenctAddressSubject.stream.listen(
      (location) {
        //

        deliveryaddress.address = location.addressLine;
        deliveryaddress.latitude = location.coordinates.latitude;
        deliveryaddress.longitude = location.coordinates.longitude;
        log("aaaaaa ${deliveryaddress.latitude}");
        log("aaaaaa ${deliveryaddress.longitude}");
        notifyListeners();
      },
    );
  }

  //switch to use current location instead of selected delivery address
  void useUserLocation() {
    LocationService.geocodeCurrentLocation();
  }

  void showFilterOptions() async {
    if (searchFilterVM == null) {
      searchFilterVM = SearchFilterViewModel(viewContext, search);
    }

    showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SearchFilterBottomSheet(
          search: search,
          vm: searchFilterVM,
          onSubmitted: (mSearch) {
            search = mSearch;
            queryPage = 1;
            startSearch();
          },
        );
      },
    );
  }

  startSearch({bool initialLoaoding = true}) async {
    //
    if (initialLoaoding) {
      setBusy(true);
      queryPage = 1;
      refreshController.refreshCompleted();
    } else {
      queryPage = queryPage + 1;
    }

    //
    try {
      final searchResult = await _searchRequest.searchRequest(
        keyword: keyword ?? "",
        search: search,
        page: queryPage,
      );
      clearErrors();

      //
      if (initialLoaoding) {
        searchResults = searchResult;
      } else {
        searchResults.addAll(searchResult);
      }
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    if (!initialLoaoding) {
      refreshController.loadComplete();
    }
    //done loading data
    setBusy(false);
  }

  fetchFlashSaleItems() async {
    for (var i = 0; i < flashSales.length; i++) {
      final flashSale = flashSales[i];
      log("longitu====> $flashSales");
      setBusyForObject(flashSale.id, true);
      try {
        final flashSaleItems = await _flashSaleRequest.getProdcuts(
          queryParams: {
            "flash_sale_id": flashSale.id,
          },
        );

        //set data
        flashSales[i].items = flashSaleItems;
        clearErrors();
      } catch (error) {
        setError(error);
      }
      setBusyForObject(flashSale.id, false);
    }
  }

  //
  dispose() {
    super.dispose();
    currentLocationChangeStream.cancel();
  }
}

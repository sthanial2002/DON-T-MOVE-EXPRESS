import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/models/flash_sale.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/requests/flash_sale.request.dart';
import 'package:fuodz/requests/vendor_type.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';

import '../models/user.dart';

class WelcomeViewModel extends MyBaseViewModel {
  //
  WelcomeViewModel(BuildContext context) {
    this.viewContext = context;
  }

  Widget selectedPage;
  List<VendorType> vendorTypes = [];
  List<FlashSale> flashSale = [];

  VendorTypeRequest vendorTypeRequest = VendorTypeRequest();
  FlashSaleRequest flashSaleRequest = FlashSaleRequest();
  bool showGrid = true;
  StreamSubscription authStateSub;
  StreamSubscription proStateSub;
  User currenUser;

  //
  //
  initialise() async {
    await getVendorTypes();
    listenToAuth();
    listToProfile();
  }

  changeCurrentUser() async {
    log("auth state changes===========");
    currenUser = await AuthServices.getCurrentUser();
    notifyListeners();
  }

  listenToAuth() {
    authStateSub = AuthServices.listenToAuthState().listen((event) async {
      log("auth state changes===========");

      genKey = GlobalKey();
      currenUser = await AuthServices.getCurrentUser();
      log("auth state changes=========== $currenUser");
      notifyListeners();
    });
  }

  listToProfile() {
    proStateSub = AuthServices.listenToProfileState().listen((event) async {
      log("changing current User========>");
      currenUser = await AuthServices.getCurrentUser();
      genKey = GlobalKey();
      log("changing current User========> $currenUser");
      notifyListeners();
    });
  }

  getVendorTypes() async {
    setBusy(true);
    try {
      vendorTypes = await vendorTypeRequest.index();
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }
  //  getFlassTypes() async {
  //   setBusy(true);
  //   try {
  //     flashSale = await flashSaleRequest.index();
  //     clearErrors();
  //   } catch (error) {
  //     setError(error);
  //   }
  //   setBusy(false);
  // }
}

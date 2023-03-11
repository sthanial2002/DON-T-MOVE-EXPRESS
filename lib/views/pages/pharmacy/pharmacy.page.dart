import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/view_models/pharmacy.vm.dart';
import 'package:fuodz/views/pages/flash_sale/widgets/flash_sale.view.dart';
import 'package:fuodz/views/pages/pharmacy/widgets/pharmacy_categories.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/banners.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/best_selling_products.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/header.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/nearby_vendors.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/cards/view_all_vendors.view.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';


// Fait
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/inputs/search_bar.input.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/services/navigation.service.dart';
import 'package:fuodz/widgets/vendor_type_categories.view.dart';



class PharmacyPage extends StatefulWidget {
  const PharmacyPage(this.vendorType, {Key key}) : super(key: key);

  final VendorType vendorType;
  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage>
    with AutomaticKeepAliveClientMixin<PharmacyPage> {
  GlobalKey pageKey = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ViewModelBuilder<PharmacyViewModel>.reactive(
      viewModelBuilder: () => PharmacyViewModel(context, widget.vendorType),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return BasePage(
          showAppBar: true,
          showLeadingAction: !AppStrings.isSingleVendorMode,
          elevation: 0,
          title: "${widget.vendorType.name}",
          appBarColor: context.theme.backgroundColor,
          appBarItemColor: AppColor.primaryColor,
          showCart: true,
          key: pageKey,
          // Fait
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: new RefreshController(),
            onRefresh: () {
              setState(() {
                pageKey = GlobalKey<State>();
              });
            },
            child: VStack(
              [
                VStack(
                  [
                    //intro
                    "Discover".tr().text.xl4.semiBold.make(),
                    "Find anything that you want".tr().text.lg.thin.make(),
                    UiSpacer.verticalSpace(),

                    //search bar
                    SearchBarInput(
                      showFilter: false,
                      onTap: () => showSearchPage(context),
                    ),
                    UiSpacer.verticalSpace(),

                    //banners
                    Banners(widget.vendorType),
                    //categories
                    VendorTypeCategories(
                      widget.vendorType,
                      showTitle: false,
                      title: "Categories".tr(),
                      childAspectRatio: 1.4,
                      crossAxisCount: AppStrings.categoryPerRow,
                    ),
                  ],
                ).p20(),
                UiSpacer.verticalSpace(),
              
              VStack(
                [
                  //flash sales products
                    FlashSaleView(widget.vendorType),

                    //best selling
                    BestSellingProducts(widget.vendorType),

                    //nearby
                    NearByVendors(widget.vendorType),

                    //view cart and all vendors
                    ViewAllVendorsView(vendorType: widget.vendorType),
                  UiSpacer.verticalSpace(),
                ],
              ).p20(),
            ],
            // key: model.pageKey,
          ).scrollVertical(),
        ),
          /*body: VStack(
            [
              //
              VendorHeader(model: model),

              SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: model.refreshController,
                onRefresh: () {
                  model.refreshController.refreshCompleted();
                  setState(() {
                    pageKey = GlobalKey<State>();
                  });
                }, // model.reloadPage,
                child: VStack(
                  [
                    Banners(widget.vendorType),

                    //categories
                    PharmacyCategories(widget.vendorType),

                    //flash sales products
                    FlashSaleView(widget.vendorType),

                    //best selling
                    BestSellingProducts(widget.vendorType),

                    //nearby
                    NearByVendors(widget.vendorType),

                    //view cart and all vendors
                    ViewAllVendorsView(vendorType: widget.vendorType),
                  ],
                ).scrollVertical(),
              ).expand(),
            ],
          ),*/
        );
      },
    );
  }

  // Fait
  showSearchPage(BuildContext context) {
    final search = Search(
      showType: 4,
      vendorType: widget.vendorType,
    );
    //
    final page = NavigationService().searchPageWidget(search);
    context.nextPage(page);
  }

  @override
  bool get wantKeepAlive => true;
}

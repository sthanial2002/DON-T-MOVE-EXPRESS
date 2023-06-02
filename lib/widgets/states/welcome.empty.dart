// import 'dart:developer';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:fuodz/constants/app_colors.dart';
// import 'package:fuodz/constants/home_screen.config.dart';
// import 'package:fuodz/models/user.dart';
// import 'package:fuodz/services/auth.service.dart';
// import 'package:fuodz/services/navigation.service.dart';
// import 'package:fuodz/utils/ui_spacer.dart';
// import 'package:fuodz/utils/utils.dart';
// import 'package:fuodz/view_models/welcome.vm.dart';
// import 'package:fuodz/views/pages/vendor/widgets/banners.view.dart';
// import 'package:fuodz/widgets/cards/custom.visibility.dart';
// import 'package:fuodz/widgets/custom_list_view.dart';
// import 'package:fuodz/widgets/finance/wallet_management.view.dart';
// import 'package:fuodz/widgets/list_items/vendor_type.list_item.dart';
// import 'package:fuodz/widgets/list_items/vendor_type.vertical_list_item.dart';
// import 'package:fuodz/widgets/states/loading.shimmer.dart';
// import 'package:localize_and_translate/localize_and_translate.dart';
// import 'package:masonry_grid/masonry_grid.dart';
// import 'package:velocity_x/velocity_x.dart';

// class EmptyWelcome extends StatefulWidget {
//   const EmptyWelcome({this.vm, Key key}) : super(key: key);

//   final WelcomeViewModel vm;

//   @override
//   State<EmptyWelcome> createState() => _EmptyWelcomeState();
// }

// class _EmptyWelcomeState extends State<EmptyWelcome> {
//   bool isClicked = false;
//   bool isClicked2 = false;
//   var tndexxx = 6;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       key: widget.vm.genKey,
//       fit: StackFit.expand,
//        children: [
//          VxBox(
//           child: SafeArea(
//             child: FittedBox(
//               fit: BoxFit.scaleDown,
//               alignment: !Utils.isArabic
//                   ? Alignment.centerLeft
//                   : Alignment.centerRight,
// child: VStack(
//   [
//     //welcome intro and loggedin account name
//     StreamBuilder(
//       stream: AuthServices.listenToAuthState(),
//       builder: (ctx, snapshot) {
//         //
//         String introText = "Welcome".tr();
//         String fullIntroText = introText;
//         //
//         if (snapshot.hasData) {
//           return FutureBuilder<User>(
//               future: AuthServices.getCurrentUser(),
//               builder: (ctx, snapshot) {
//                 if (snapshot.hasData) {
//                   fullIntroText =
//                       "$introText ${snapshot.data.name}";
//                 }
//                 return fullIntroText.text.white.xl3.semiBold
//                     .make();
//               });
//         }
//         return fullIntroText.text.white.xl3.semiBold.make();
//       },
//     ),
//     //

//     "How can I help you today?".tr().text.white.xl.medium.make(),
//     UiSpacer.verticalSpace(),
//   ],
// ).py12(),
//             ),
//           ),
//         ).color(AppColor.primaryColor).p20.make().wFull(context).positioned(
//               height: (context.percentHeight * 22),
//               left: 0,
//               right: 0,
//               top: 0,
//             ),

//         //
//         VStack(
//           [
//             //finance section
//             CustomVisibilty(
//               visible: HomeScreenConfig.showWalletOnHomeScreen ?? true,
//               child: WalletManagementView().px20(),
//             ),
//             //
//             //top banner
//             CustomVisibilty(
//               visible: HomeScreenConfig.showBannerOnHomeScreen &&
//                   HomeScreenConfig.isBannerPositionTop,
//               child: VStack(
//                 [
//                   UiSpacer.verticalSpace(),
//                   Banners(
//                     null,
//                     featured: true,
//                   ).py12(),
//                 ],
//               ),
//             ),
//             //
//             VStack(
//               [
//                 HStack(
//                   [
//                     "I want to:".tr().text.xl.medium.make().expand(),
//                     CustomVisibilty(
//                       visible: HomeScreenConfig.isVendorTypeListingBoth,
//                       child: Icon(
//                         widget.vm.showGrid
//                             ? FlutterIcons.grid_fea
//                             : FlutterIcons.list_fea,
//                       ).p2().onInkTap(
//                         () {
//                           widget.vm.showGrid = !widget.vm.showGrid;
//                           widget.vm.notifyListeners();
//                         },
//                       ),
//                     ),
//                   ],
//                   crossAlignment: CrossAxisAlignment.center,
//                 ).py4(),
//                 //list view
//                 CustomVisibilty(
//                   visible: (HomeScreenConfig.isVendorTypeListingBoth &&
//                           !widget.vm.showGrid) ||
//                       (!HomeScreenConfig.isVendorTypeListingBoth &&
//                           HomeScreenConfig.isVendorTypeListingListView),
//                   child: CustomListView(
//                     noScrollPhysics: true,
//                     dataSet: widget.vm.vendorTypes,
//                     isLoading: widget.vm.isBusy,
//                     loadingWidget: LoadingShimmer().px20(),
//                     itemBuilder: (context, index) {
//                       final vendorType = widget.vm.vendorTypes[index];
//                       return VendorTypeListItem(
//                         vendorType,
//                         onPressed: () {
//                           NavigationService.pageSelected(vendorType,
//                               context: context);
//                         },
//                       );
//                     },
//                     separatorBuilder: (context, index) => UiSpacer.emptySpace(),
//                   ),
//                 ),
//                 //gridview
//                 CustomVisibilty(
//                   visible: HomeScreenConfig.isVendorTypeListingGridView &&
//                       widget.vm.showGrid &&
//                       widget.vm.isBusy,
//                   child: LoadingShimmer().px20().centered(),
//                 ),
//                 CustomVisibilty(
//                   visible: HomeScreenConfig.isVendorTypeListingGridView &&
//                       widget.vm.showGrid &&
//                       !widget.vm.isBusy,
//                   child: AnimationLimiter(
//                     child: Container(
//                       // color: Colors.red,
//                       height: isClicked == true
//                           ? MediaQuery.of(context).size.height
//                           : MediaQuery.of(context).size.height * .65,
//                       child: SingleChildScrollView(
//                         physics: const NeverScrollableScrollPhysics(),
//                         child: Column(
//                           children: [
//                             MasonryGrid(
//                               column: HomeScreenConfig.vendorTypePerRow ?? 2,
//                               crossAxisSpacing: 10,
//                               mainAxisSpacing: 10,
//                               children: List.generate(
//                                 widget.vm.vendorTypes.length,
//                                 (index) {
//                                   final vendorType =
//                                       widget.vm.vendorTypes[index];
//                                   // log('GridView');
//                                   return VendorTypeVerticalListItem(
//                                     vendorType,
//                                     index: index,
//                                     onPressed: () {
//                                       NavigationService.pageSelected(vendorType,
//                                           context: context);
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 isClicked == true
//                     ? Container()
//                     : Align(
//                         alignment: Alignment.bottomCenter,
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               isClicked = true;
//                             });
//                           },
//                           child: widget.vm.showGrid
//                               ? Container(
//                                   height: 25,
//                                   width: 45,
//                                   decoration: BoxDecoration(
//                                       color: Colors.red,
//                                       borderRadius: BorderRadius.only(
//                                           bottomLeft: Radius.circular(35),
//                                           bottomRight: Radius.circular(35))),
//                                 )
//                               : Container(),
//                         ),
//                       ),
//               ],
//             ).p20(),

//             //botton banner
//             CustomVisibilty(
//               visible: HomeScreenConfig.showBannerOnHomeScreen &&
//                   !HomeScreenConfig.isBannerPositionTop,
//               child: Banners(
//                 null,
//                 featured: true,
//               ).py12().pOnly(
//                     bottom: context.percentHeight * 10,
//                   ),
//             ),
//           ],
//         )
//             .scrollVertical()
//             .box
//             .color(context.backgroundColor)
//             .topRounded(value: 25)
//             .make()
//             .positioned(
//               top: (context.percentHeight * 22) - 30,
//               left: 0,
//               right: 0,
//               bottom: 0,
//             ),
//       ],
//     );
//   }
// }

import 'dart:async';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/models/onboard_model.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/requests/settings.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/app_strings.dart';
import '../../constants/home_screen.config.dart';
import '../../models/flash_sale.dart';
import '../../models/user.dart';
import '../../models/vendor_type.dart';
import '../../requests/flash_sale.request.dart';
import '../../services/navigation.service.dart';
import '../../utils/ui_spacer.dart';
import '../../view_models/search.vm.dart';
import '../../view_models/vendor.vm.dart';
import '../../view_models/welcome.vm.dart';
import '../../views/pages/flash_sale/flash_sale.page.dart';
import '../../views/pages/search/search.page.dart';
import '../../views/pages/vendor/widgets/banners.view.dart';
import '../cards/custom.visibility.dart';
import '../finance/wallet_management.view.dart';
import 'loading.shimmer.dart';
import 'package:dio/dio.dart';
import 'package:fuodz/models/flash_sale.dart';

class EmptyWelcome extends StatefulWidget {
  const EmptyWelcome({Key key, this.vm}) : super(key: key);
  final WelcomeViewModel vm;

  @override
  State<EmptyWelcome> createState() => _EmptyWelcomeState();
}

class _EmptyWelcomeState extends State<EmptyWelcome> {
  bool isScroll = false;
  bool isExpand = false;
  List<OnboardingModel> datalist = [];
  List<FlashSale> flashLsit = [];
  List<Product> flashProduct = [];
  // FlashSale flashShale;
  final FlashSale flashSale = FlashSale();
  SearchViewModel model1;
  final _controller = CarouselController();
  final _pageController = PageController();
  //
  //
  //
  @override
  void initState() {
    log("abcccc===>? ${flashProduct}");
    apicaalling();
    futherApi();
    log("DATAIN===> ${vendorType}");
    vendorType = VendorType.fromJson(AppStrings.enabledVendorType);
    // flashSale.forEach((flashsale) {
    //   //
    //   if (flashsale.items == null ||
    //       flashsale.items.isEmpty ||
    //       flashsale.isExpired) {
    //     list.add(UiSpacer.emptySpace());
    //     return;
    //   }
    // });
    // Timer(
    //     const Duration(milliseconds: 400),
    //     () => _pageController.nextPage(
    //         duration: Duration(milliseconds: 200), curve: Curves.easeInOut));
    // futherProductApi();
    // timeCalculat();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  Future<String> timeCalculat(String lt, lg) async {
    log("timeeeee1 ");
    String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=5.303612,-3.985395&destinations=${lt},${lg}&key=AIzaSyA4mbeMI-a-BgbrazRsDbsUHignyDlhTHM";
    Dio dio = new Dio();
    Response response = await dio.get(url);
    final data = response.data;
    final test = data['rows'][0]['elements'][0]['duration']['text'];
    log("timeeeee ${test}");
    return test;
  }

  VendorType vendorType;
  @override
  Widget build(BuildContext context) {
    if (flashProduct.isEmpty) {
      getProductApi();
    }
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print('startttedddd widegt${widget.vm.vendorType}');
    print('startttedddd widegt${widget.vm.vendorTypes}');
    return SafeArea(
      top: false,
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: ViewModelBuilder<VendorViewModel>.reactive(
              viewModelBuilder: () => VendorViewModel(
                    context,
                    vendorType,
                  ),
              onModelReady: (model) => model.initialise(),
              builder: (context, model, child) {
                // log("latitude ${model.deliveryaddress.latitude}");
                // log("longitu ${model.deliveryaddress.longitude}");
                log("longitu====> ${model.flashSaleItems}");
                return Padding(
                  padding: EdgeInsets.only(top: height * 0.04),
                  child: Column(
                    children: [
                      CustomVisibilty(
                        visible: HomeScreenConfig.isVendorTypeListingGridView &&
                            widget.vm.showGrid &&
                            widget.vm.isBusy,
                        child: LoadingShimmer().px20().centered(),
                      ),
                      Container(
                        height: isScroll ? height * 0.8 : height * 0.65,
                        decoration: BoxDecoration(color: Color(0xff081273)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/ASSETS/Logo_blanc_DM_Express 1.png',
                                    scale: 3.5,
                                  ),
                                  // Container(
                                  //   width: 210,
                                  //   height: 50,
                                  //   child: SearchBarInput(
                                  //     hintText:
                                  //         "Search for your desired foods or restaurants"
                                  //             .tr(),
                                  //     readOnly: true,
                                  //     search: Search(
                                  //       vendorType: vendorType,
                                  //       viewType: SearchType.vendorProducts,
                                  //     ),
                                  //   ).px12(),
                                  // ),
                                  // Container(
                                  // width: 210,
                                  // height: 50,
                                  //   child: SearchBarInput(
                                  //     readOnly: false,
                                  //     showFilter: true,
                                  //     onSubmitted: (keyword) {
                                  //       model.keyword = keyword;
                                  //       model.startSearch();
                                  //     },
                                  //     onFilterPressed: () =>
                                  //         model.showFilterOptions(),
                                  //   ),
                                  // ),
                                  Container(
                                    height: height * 0.04,
                                    width: width * 0.6,
                                    child: TextField(
                                      onTap: vendorType != null
                                          ? () {
                                              //pages
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) => SearchPage(
                                                    search: Search(
                                                      showType: 4,
                                                    ),
                                                    showCancel: false,
                                                  ),
                                                ),
                                              );
                                              // final page = NavigationService()
                                              //     .searchPageWidget(Search(
                                              //   vendorType: vendorType,
                                              //   viewType:
                                              //       SearchType.vendorProducts,
                                              // ));
                                              // context.nextPage(page);
                                            }
                                          : null,
                                      scrollPadding: EdgeInsets.zero,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(0),
                                        filled: true,
                                        fillColor:
                                            Color.fromRGBO(255, 255, 255, 1),
                                        prefixIcon: Image.asset(
                                          'assets/ASSETS/Vector-13.png',
                                          scale: 3.8,
                                        ),
                                        suffixIcon: Container(
                                          width: width * 0.01,
                                          //color: Colors.red,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Image.asset(
                                                'assets/ASSETS/Line 1.png',
                                                scale: 3.5,
                                              ),
                                              InkWell(
                                                onTap: () =>
                                                    model.showFilterOptions(),
                                                child: Image.asset(
                                                  'assets/ASSETS/Vector-12.png',
                                                  scale: 3.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        hintText: "Shoping, taxi,rects,ect",
                                      ),
                                    ),
                                  ),

                                  SizedBox(

                                      // width: height * 0.01,
                                      ),
                                  InkWell(
                                    onTap: model.openCart,
                                    child: Image.asset(
                                      'assets/ASSETS/Vector-14.png',
                                      scale: 3.9,
                                    ),
                                  ),
                                  SizedBox(
                                      // width: height * 0.01,
                                      ),
                                  InkWell(
                                    onTap: model.openNotification,
                                    child: Image.asset(
                                      'assets/ASSETS/Vector-15.png',
                                      scale: 3.9,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CustomVisibilty(
                              visible:
                                  HomeScreenConfig.showWalletOnHomeScreen ??
                                      true,
                              child: WalletManagementView(),
                            ),

                            CustomVisibilty(
                              visible:
                                  HomeScreenConfig.showBannerOnHomeScreen &&
                                      HomeScreenConfig.isBannerPositionTop,
                              child: VStack(
                                [
                                  UiSpacer.verticalSpace(),
                                  Banners(
                                    null,
                                    featured: true,
                                  ),
                                ],
                              ),
                            ),

                            // Container(
                            //   height: 150,
                            //   margin: EdgeInsets.only(
                            //     left: width * 0.025,
                            //     right: width * 0.025,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(15),
                            //   ),
                            //   width: double.infinity,
                            //   child: CarouselSlider(
                            //     options: CarouselOptions(
                            //       autoPlay: true,
                            //       viewportFraction: 1,
                            //     ),
                            //     items: [1, 2, 3, 4, 5].map((i) {
                            //       return Builder(
                            //         builder: (BuildContext context) {
                            //           return Container(
                            //               width: double.infinity,
                            //               margin: EdgeInsets.symmetric(horizontal: 5.0),
                            //               decoration: BoxDecoration(
                            //                   color: Colors.amber,
                            //                   borderRadius: BorderRadius.circular(15)),
                            //               child: Text(
                            //                 'text $i',
                            //                 style: TextStyle(fontSize: 16.0),ƒ√
                            //               ));
                            //         },
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Container(
                              height: isExpand ? height * 0.07 : height * 0.045,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFF3F65F6),
                              ),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 7),
                                    child: Image.asset(
                                      "assets/ASSETS/Iconsax/Bold/Vector.png",
                                      scale: 4,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  Expanded(
                                    child: flashLsit.isEmpty
                                        ? SizedBox()
                                        : CarouselSlider.builder(

                                            // controller: _pageController,
                                            // // shrinkWrap: true,
                                            // physics: BouncingScrollPhysics(),
                                            // scrollDirection: Axis.horizontal,
                                            options: CarouselOptions(
                                              initialPage: 0,
                                              autoPlay: true,
                                              pageSnapping: true,
                                              viewportFraction: 1,
                                            ),
                                            itemCount: flashLsit.length,
                                            itemBuilder: ((context, index, i) {
                                              return Container(
                                                width: width,

                                                // padding: EdgeInsets.only(
                                                //     left: 5, right: 30),

                                                height: isExpand
                                                    ? height * 0.08
                                                    : height * 0.03,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  flashLsit[index]
                                                      .name
                                                      .toString(),
                                                  maxLines: isExpand ? 2 : 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              );
                                            })),
                                  ),
                                  // Container(
                                  //   // height: 30,
                                  //   width: width * 0.85,
                                  //   child: ListView.builder(
                                  //     itemCount: flashLsit.length = 1,
                                  //     itemBuilder: ((context, index) {
                                  //       return Text(
                                  //         flashLsit[index].name ?? "",
                                  //       );
                                  //     }),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 7),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isExpand = !isExpand;
                                        });
                                      },
                                      child: Image.asset(
                                        "assets/ASSETS/Vector-17.png",
                                        scale: 3.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: height * 0.035,
                                    width: width * 0.18,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: width * 0.01,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Text(
                                          //   "Bienvenue",
                                          //   style: TextStyle(
                                          //       fontSize: height * 0.013),
                                          // ),
                                          // Text(
                                          //   "Maurel !",
                                          //   style: TextStyle(
                                          //     fontSize: height * 0.013,
                                          //     color: Color(0xff081173),
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),

                                          //welcome intro and loggedin account name
                                          StreamBuilder(
                                            stream: AuthServices
                                                .listenToAuthState(),
                                            builder: (ctx, snapshot) {
                                              //
                                              String introText = "Welcome".tr();
                                              String fullIntroText = introText;
                                              //
                                              if (snapshot.hasData) {
                                                return FutureBuilder<User>(
                                                    future: AuthServices
                                                        .getCurrentUser(),
                                                    builder: (ctx, snapshot) {
                                                      if (snapshot.hasData) {
                                                        log("data in future---");
                                                        fullIntroText =
                                                            "${snapshot.data.name.split(' ')[0]}";
                                                        return "Bienvenue\n$fullIntroText"
                                                            .text
                                                            .black
                                                            .xs
                                                            .xs
                                                            .heightRelaxed
                                                            .make();
                                                      } else {
                                                        return "Bienvenue\n ${introText}"
                                                            .text
                                                            .black
                                                            .xs
                                                            .heightTight
                                                            .make();
                                                      }
                                                    });
                                              }
                                              log("user banem ${fullIntroText.text.black.xs.semiBold.make()}");
                                              return "Bienvenue\n ${introText}"
                                                  .text
                                                  .black
                                                  .xs
                                                  .semiBold
                                                  .make();
                                            },
                                          ),
                                          //

                                          // "How can I help you today?"
                                          //     .tr()
                                          //     .text
                                          //     .white
                                          //     .xl
                                          //     .medium
                                          //     .make(),
                                          // UiSpacer.verticalSpace(),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                // Expanded(
                                //   child: Container(
                                //     height: height * 0.035,
                                //     decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         borderRadius: BorderRadius.circular(10)),
                                //     child: Padding(
                                //       padding: EdgeInsets.only(
                                //           left: width * 0.02,
                                //           right: width * 0.02),
                                //       child: Row(
                                //         children: [
                                //           Expanded(
                                //               child: Text(
                                //            model.pickDeliveryAddress(),
                                //             overflow: TextOverflow.ellipsis,
                                //           )),
                                //           Image.asset(
                                //             "assets/ASSETS/Vector-16.png",
                                //             scale: 3.3,
                                //           )
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  height: 30,
                                  width: width * 0.55,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: width * 0.43,
                                        child: model
                                            .deliveryaddress.address.text
                                            .maxLines(1)
                                            .ellipsis
                                            .base
                                            .black
                                            .make(),
                                      ),
                                      Image.asset(
                                        "assets/ASSETS/Vector-16.png",
                                        scale: 3.3,
                                      )
                                    ],
                                  )
                                      .onInkTap(
                                        model.pickDeliveryAddress,
                                      )
                                      .px12(),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Container(
                                  height: height * 0.035,
                                  width: width * 0.18,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      topLeft: Radius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: width * 0.01,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Arrivee dans",
                                          style: TextStyle(
                                            fontSize: height * 0.013,
                                          ),
                                        ),
                                        FutureBuilder<String>(
                                            future: timeCalculat(
                                                model.deliveryaddress.latitude
                                                    .toString(),
                                                model.deliveryaddress.longitude
                                                    .toString()),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              }
                                              return Text(
                                                snapshot.data,
                                                style: TextStyle(
                                                  fontSize: height * 0.012,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: height * 0.005,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Voir plus",
                                  style: TextStyle(
                                    fontSize: height * 0.012,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5, left: 5),
                                  child: Image.asset(
                                    "assets/ASSETS/Vector-11.png",
                                    scale: 2.9,
                                  ),
                                ),
                              ],
                            ),

                            // CustomVisibilty(
                            //   visible:
                            //       HomeScreenConfig.isVendorTypeListingGridView &&
                            //           widget.vm.showGrid &&
                            //           !widget.vm.isBusy,
                            //   child: AnimationLimiter(
                            //     child: Container(
                            //       // color: Colors.red,
                            //       height: 200,

                            //       child: SingleChildScrollView(
                            //         physics: const NeverScrollableScrollPhysics(),
                            //         child: Column(
                            //           children: [
                            //             MasonryGrid(
                            //               column: 4,
                            //               crossAxisSpacing: 10,
                            //               mainAxisSpacing: 10,
                            //               children: List.generate(
                            //                 widget.vm.vendorTypes.length,
                            //                 (index) {
                            //                   final vendorType =
                            //                       widget.vm.vendorTypes[index];
                            //                   // log('GridView');
                            //                   return VendorTypeVerticalListItem(
                            //                     vendorType,
                            //                     index: index,
                            //                     onPressed: () {
                            //                       NavigationService.pageSelected(
                            //                           vendorType,
                            //                           context: context);
                            //                     },
                            //                   );
                            //                 },
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            CustomVisibilty(
                              visible: HomeScreenConfig
                                      .isVendorTypeListingGridView &&
                                  widget.vm.showGrid &&
                                  widget.vm.isBusy,
                              child: LoadingShimmer().px20().centered(),
                            ),
                            GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 8,
                                mainAxisExtent: height * 0.097,
                              ),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.only(
                                left: width * 0.03,
                                right: width * 0.03,
                                top: height * 0.005,
                              ),
                              itemCount: widget.vm.vendorTypes.length,
                              itemBuilder: (context, index) {
                                final vendorType = widget.vm.vendorTypes[index];
                                log("aaaaaa==> ${vendorType.id}");
                                return SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          NavigationService.pageSelected(
                                              vendorType,
                                              context: context);
                                        },
                                        child: Container(
                                          height: height * 0.06,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: NetworkImage(widget
                                                  .vm.vendorTypes[index].logo),
                                              scale: 4,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.003,
                                      ),
                                      Center(
                                        child: Text(
                                          widget.vm.vendorTypes[index].name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: height * 0.014,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      CustomVisibilty(
                        visible: HomeScreenConfig.isVendorTypeListingGridView &&
                            widget.vm.showGrid &&
                            widget.vm.isBusy,
                        child: LoadingShimmer().px20().centered(),
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          CarouselSlider(
                            carouselController: _controller,
                            options: CarouselOptions(
                              height: height * 0.32,
                              reverse: false,
                              enableInfiniteScroll: false,
                              autoPlay: true,
                              viewportFraction: 1,
                            ),
                            items: datalist.map((e) {
                              return Container(
                                height: height * 0.32,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  image: DecorationImage(
                                    image: NetworkImage(e.photo ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                    child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height * 0.035,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: width * 0.04,
                                        right: width * 0.04,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: height * 0.12,
                                            width: width * 0.8,
                                            // color: Colors.red,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  e.title ?? '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: height * 0.02,
                                                  ),
                                                ),
                                                Text(
                                                  e.description ?? '',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: height * 0.02,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                              );
                            }).toList(),
                          ),
                          // FlashSaleItemsPage(
                          //   flashShale,
                          // ),
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.16),
                            child: Container(
                              height: height * .14,
                              width: double.infinity,
                              child: flashProduct.isEmpty
                                  ? SizedBox()
                                  : CarouselSlider.builder(

                                      // scrollDirection: Axis.horizontal,
                                      // physics: ScrollPhysics(),
                                      // shrinkWrap: true,
                                      options: CarouselOptions(
                                          initialPage: 0,
                                          autoPlay: true,
                                          viewportFraction: .3),
                                      itemCount: flashProduct.length,
                                      itemBuilder: (context, index, ind) {
                                        log("123456789 ${flashProduct[index].discountPrice.toString()}");
                                        return InkWell(
                                          onTap: () {
                                            context.nextPage(
                                              NavigationService()
                                                  .productDetailsPageWidget(
                                                      flashProduct[index]),
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: width * 0.04),
                                            height: height * 0.18,
                                            width: width * 0.25,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Stack(
                                                children: [
                                                  // Column(
                                                  //   // mainAxisAlignment:
                                                  //   //     MainAxisAlignment.spaceBetween,
                                                  //   children: [
                                                  //     // SizedBox(
                                                  //     //   height: height * 0.003,
                                                  //     // ),

                                                  //   ],
                                                  // ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          flashProduct[index]
                                                              .photo
                                                              .toString(),
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    // child: Image.network(
                                                    //   flashProduct[index]
                                                    //       .photo
                                                    //       .toString(),
                                                    //   fit: BoxFit.cover,
                                                    // ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 13,
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    color: Colors.white,
                                                    child: Text(
                                                      flashProduct[index].name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize:
                                                            height * 0.0125,
                                                        color: Color.fromARGB(
                                                            255, 7, 214, 255),
                                                      ),
                                                    ),
                                                  ),

                                                  Positioned(
                                                    bottom: 2,
                                                    right: 5,
                                                    child: Container(
                                                      // margin: EdgeInsets.only(
                                                      //   right: 2,
                                                      //   top: height * 0.097,
                                                      //   left: width * 0.16,
                                                      // ),
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      // height: height * 0.02,
                                                      // width: width * 0.08,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "- ${flashProduct[index].discountPrice.toString() ?? ""}",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                height * 0.013,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isScroll = !isScroll;
                              });
                            },
                            child: Container(
                              height: height * 0.03,
                              width: width * 0.14,
                              decoration: BoxDecoration(
                                color: Color(0xff081273),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                              padding: EdgeInsets.only(bottom: 10),
                              child: isScroll
                                  ? RotatedBox(
                                      quarterTurns: 6,
                                      child: Image.asset(
                                        "assets/ASSETS/Vector-20.png",
                                        scale: 2.7,
                                      ),
                                    )
                                  : Image.asset(
                                      "assets/ASSETS/Vector-20.png",
                                      scale: 2.7,
                                    ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.09,
                              left: width * 0.02,
                              right: width * 0.02,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _controller.previousPage();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    child: Image.asset(
                                      "assets/ASSETS/Vector-19.png",
                                      scale: 3,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print("going to next page");
                                    _controller.nextPage();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    child: Image.asset(
                                      "assets/ASSETS/Vector-18.png",
                                      scale: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future<void> apicaalling() async {
    log('response==== ');
    final Response = await SettingsRequest().onboardApi();
    log('response====123 ${Response}');
    setState(() {
      datalist = Response;
    });
  }

  Future<void> futherApi() async {
    log('response====005500 ');
    final Response = await FlashSaleRequest().getFlashSales();
    log('response====550055 ${Response.length}');
    setState(() {
      flashLsit = Response;
    });
  }

  // Future<void> futherProductApi() async {
  //   log('respons ');
  //   final Response = await FlashSaleRequest().productApi();
  //   log('response ${Response}');
  //   setState(() {
  //     flashProduct = Response;
  //   });
  // }

  Future<void> getProductApi() async {
    /*
     flashSales = await _flashSaleRequest.getFlashSales(
        queryParams: {
          "vendor_type_id": vendorType.id,
        },
      );
     */
    // if (widget.vm.vendorTypes.isEmpty || widget.vm.vendorTypes == null) {
    //   getProductApi();
    // }
    log("before calling ${widget.vm.vendorTypes}");
    List<FlashSale> flashSale = [];
    for (var vendorType in widget.vm.vendorTypes) {
      final flashSales = await FlashSaleRequest().getFlashSales(
        queryParams: {
          "vendor_type_id": vendorType.id,
        },
      );
      flashSale.addAll(flashSales);
    }
    List<Product> data = [];
    for (var flash in flashSale) {
      final prd = await FlashSaleRequest().getProdcuts(
        queryParams: {
          "flash_sale_id": "${flash.id}",
        },
      );
      data.addAll(prd);
    }
    log('responsesinion $data ');

    setState(() {
      flashProduct = data;
    });
  }

  openFlashSaleItems(BuildContext context, FlashSale flashsale) {
    context.nextPage(FlashSaleItemsPage(flashsale));
  }
}

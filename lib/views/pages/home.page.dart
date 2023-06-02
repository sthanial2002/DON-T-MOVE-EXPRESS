// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:double_back_to_close/double_back_to_close.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:fuodz/constants/app_colors.dart';
// import 'package:fuodz/constants/app_upgrade_settings.dart';
// import 'package:fuodz/models/search.dart';
// import 'package:fuodz/services/location.service.dart';
// import 'package:fuodz/utils/utils.dart';
// import 'package:fuodz/view_models/welcome.vm.dart';
// import 'package:fuodz/views/pages/profile/profile.page.dart';
// import 'package:fuodz/view_models/home.vm.dart';
// import 'package:fuodz/views/pages/search/search.page.dart';
// import 'package:fuodz/views/promos_page.dart';
// import 'package:fuodz/widgets/base.page.dart';
// import 'package:fuodz/widgets/states/welcome.empty.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:localize_and_translate/localize_and_translate.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
// import 'package:stacked/stacked.dart';
// import 'package:upgrader/upgrader.dart';
// import 'package:velocity_x/velocity_x.dart';

// import '../../constants/app_images.dart';
// import '../../widgets/busy_indicator.dart';
// import 'order/orders.page.dart';

// class HomePage extends StatefulWidget {
//   HomePage({
//     Key key,
//   }) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   HomeViewModel vm;
//   @override
//   void initState() {
//     super.initState();
//     vm = HomeViewModel(context);
//     WidgetsBinding.instance?.addPostFrameCallback(
//       (_) {
//         LocationService.prepareLocationListener();
//         vm?.initialise();
//       },
//     );
//   }

//   final controller = PersistentTabController(initialIndex: 0);
//   @override
//   Widget build(BuildContext context) {
//     return DoubleBack(
//       message: "Press back again to close".tr(),
//       child: ViewModelBuilder<HomeViewModel>.reactive(
//         viewModelBuilder: () => vm,
//         builder: (context, model, child) {
//           // vm.authStateSub;
//           // vm.vendorType;

//           return BasePage(
//               body: UpgradeAlert(
//             upgrader: Upgrader(
//               showIgnore: !AppUpgradeSettings.forceUpgrade(),
//               shouldPopScope: () => !AppUpgradeSettings.forceUpgrade(),
//               dialogStyle: Platform.isIOS
//                   ? UpgradeDialogStyle.cupertino
//                   : UpgradeDialogStyle.material,
//             ),
//             // child: PageView(
//             //   controller: model.pageViewController,
//             //   onPageChanged: model.onPageChanged,
//             //   children: [
//             //     model.homeView,
//             //     OrdersPage(),
//             //     SearchPage(
//             //       search: Search(
//             //         showType: 4,
//             //       ),
//             //       showCancel: false,
//             //     ),
//             //     ProfilePage(),
//             //     ProfilePage(),
//             //   ],
//             // ),
//             // ),
//             // fab: SizedBox(
//             //   height: 40,
//             //   child: FloatingActionButton.extended(
//             //     backgroundColor: AppColor.primaryColorDark,
//             //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             //     onPressed: model.openCart,
//             //     icon: Icon(
//             //       FlutterIcons.shopping_cart_faw,
//             //       color: Colors.white,
//             //     ).badge(
//             //       position: Utils.isArabic
//             //           ? VxBadgePosition.leftTop
//             //           : VxBadgePosition.rightTop,
//             //       count: model.totalCartItems,
//             //       color: Colors.white,
//             //       textStyle: context.textTheme.bodyText1?.copyWith(
//             //         color: AppColor.primaryColor,
//             //         fontSize: 10,
//             //       ),
//             //     ),
//             //     label: "Cart".tr().text.white.make(),
//             //   ),
//             // ),
// child: ViewModelBuilder<WelcomeViewModel>.reactive(
//     viewModelBuilder: () => WelcomeViewModel(context),
//     onModelReady: (vm) => vm.initialise(),
//     builder: (context, vm, child) {
//                   return PersistentTabView(
//                     context,
//                     onItemSelected: model.onPageChanged,

//                     navBarHeight: 65,
//                     backgroundColor: Color(0xff081273),
//                     decoration: NavBarDecoration(
//                         borderRadius: BorderRadius.circular(1)),
//                     items: [
//                       PersistentBottomNavBarItem(
//                         icon: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Image.asset(
//                               "assets/ASSETS/Home Page.png",
//                               color: Colors.white,
//                               scale: 5,
//                             ),
//                             Text(
//                               "Accuell",
//                               style:
//                                   TextStyle(fontSize: 10, color: Colors.white),
//                             ),
//                           ],
//                         ),
//                         inactiveIcon: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
// Image.asset(
//   "assets/ASSETS/Home Page.png",
//   color: Colors.white,
//   scale: 5,
// ),
//                             Text(
//                               "Accuell",
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
// PersistentBottomNavBarItem(
//   icon: Column(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       Image.asset(
//         "assets/ASSETS/Vector-2.png",
//         color: Colors.white,
//         scale: 5,
//       ),
//       SizedBox(
//         height: 2,
//       ),
//       Text(
//         "Commandes",
//         style: TextStyle(
//           fontSize: 10,
//           color: Colors.white,
//         ),
//       ),
//     ],
//   ),
//   inactiveIcon: Column(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       Image.asset(
//         "assets/ASSETS/Vector-2.png",
//         color: Colors.white,
//         scale: 5,
//       ),
//       SizedBox(
//         height: 2,
//       ),
//       Text(
//         "Commandes",
//         style: TextStyle(
//           fontSize: 10,
//           color: Colors.white,
//         ),
//       ),
//     ],
//   ),
// ),
// PersistentBottomNavBarItem(
//   textStyle: TextStyle(
//     fontSize: 10,
//     color: Colors.white,
//   ),
//   title: 'Compte',
//   activeColorPrimary: Color(0xff081273),
//   icon: vm.currenUser != null
//       ? CachedNetworkImage(
//           imageUrl: vm.currenUser.photo,
//           progressIndicatorBuilder:
//               (context, imageUrl, progress) {
//             return BusyIndicator();
//           },
//           errorWidget: (context, imageUrl, progress) {
//             return Image.asset(
//               AppImages.user,
//             );
//           },
//         )
//           .wh(Vx.dp64, Vx.dp64)
//           .box
//           .roundedFull
//           .clip(Clip.antiAlias)
//           .make()
//       : Image.asset(
//           "assets/images/splash_icon.png",
//         ),
//   inactiveIcon: vm.currenUser != null
//       ? CachedNetworkImage(
//           imageUrl: vm.currenUser.photo,
//           progressIndicatorBuilder:
//               (context, imageUrl, progress) {
//             return BusyIndicator();
//           },
//           errorWidget: (context, imageUrl, progress) {
//             return Image.asset(
//               AppImages.user,
//             );
//           },
//         )
//           .wh(Vx.dp64, Vx.dp64)
//           .box
//           .roundedFull
//           .clip(Clip.antiAlias)
//           .make()
//       : Image.asset(
//           "assets/images/splash_icon.png",
//         ),
// ),
// PersistentBottomNavBarItem(
//   icon: Column(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       Image.asset(
//         "assets/ASSETS/Vector.png",
//         color: Colors.white,
//         scale: 5,
//       ),
//       SizedBox(
//         height: 2,
//       ),
//       Text(
//         "Business",
//         style: TextStyle(
//           fontSize: 10,
//           color: Colors.white,
//         ),
//       ),
//     ],
//   ),
//   inactiveIcon: Column(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       Image.asset(
//         "assets/ASSETS/Vector.png",
//         color: Colors.white,
//         scale: 5,
//       ),
//       SizedBox(
//         height: 2,
//       ),
//       Text(
//         "Business",
//         style: TextStyle(
//           fontSize: 10,
//           color: Colors.white,
//         ),
//       ),
//     ],
//   ),
// ),
// PersistentBottomNavBarItem(
//   icon: Column(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       Image.asset(
//         "assets/ASSETS/Vector-1.png",
//         color: Colors.white,
//         scale: 5,
//       ),
//       Text(
//         "Promos",
//         style: TextStyle(
//           fontSize: 10,
//           color: Colors.white,
//         ),
//       ),
//     ],
//   ),
//   inactiveIcon: Column(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       Image.asset(
//         "assets/ASSETS/Vector-1.png",
//         color: Colors.white,
//         scale: 5,
//       ),
//       Text(
//         "Promos",
//         style: TextStyle(
//           fontSize: 10,
//           color: Colors.white,
//         ),
//       ),
//     ],
//   ),
// ),
//                     ],
//                     screens: [
//                       model.homeView,
//                       OrdersPage(),
//                       ProfilePage(),
//                       SearchPage(
//                         search: Search(
//                           showType: 4,
//                         ),
//                         showCancel: false,
//                       ),
//                       PromosPage(),
//                     ],
//                     // backgroundColor: Colors.blue,
//                     navBarStyle: NavBarStyle.style15,
//                     controller: PersistentTabController(
//                         initialIndex: model.currentIndex),
//                   );
//                 }),
//           ) // bottomNavigationBar: VxBox(
//               //   child: SafeArea(
//               //     child: GNav(
//               //       gap: 8,
//               //       backgroundColor: Color(0xff081273),
//               //       activeColor: Colors.white,
//               //       color: Theme.of(context).textTheme.bodyText1?.color,
//               //       iconSize: 20,
//               //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               //       duration: Duration(milliseconds: 250),
//               //       tabBackgroundColor: Theme.of(context).colorScheme.secondary,
//               //       tabs: [
//               // GButton(
//               //   icon: FlutterIcons.home_ant,
//               //   text: 'Home'.tr(),
//               // ),
//               // GButton(
//               //   icon: FlutterIcons.inbox_ant,
//               //   text: 'Orders'.tr(),
//               // ),
//               // GButton(
//               //   icon: FlutterIcons.search_fea,
//               //   text: 'Search'.tr(),
//               // ),
//               // GButton(
//               //   icon: FlutterIcons.menu_fea,
//               //   text: 'More'.tr(),
//               // ),
//               //       ],
//               // selectedIndex: model.currentIndex,
//               // onTabChange: model.onTabChange,
//               //     ),
//               //   ),
//               // )
//               //     .p16
//               //     .shadow
//               //     .color(Theme.of(context).bottomSheetTheme.backgroundColor)
//               //     .make(),
//               );
//         },
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_upgrade_settings.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/views/pages/profile/profile.page.dart';
import 'package:fuodz/view_models/home.vm.dart';
import 'package:fuodz/views/pages/search/search.page.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:upgrader/upgrader.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/app_images.dart';
import '../../view_models/welcome.vm.dart';
import '../../widgets/busy_indicator.dart';
import '../promos_page.dart';
import 'order/orders.page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel vm;
  @override
  void initState() {
    super.initState();
    vm = HomeViewModel(context);
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        LocationService.prepareLocationListener();
        vm?.initialise();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      message: "Press back again to close".tr(),
      child: ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => vm,
        builder: (context, model, child) {
          return BasePage(
            body: UpgradeAlert(
              upgrader: Upgrader(
                showIgnore: !AppUpgradeSettings.forceUpgrade(),
                shouldPopScope: () => !AppUpgradeSettings.forceUpgrade(),
                dialogStyle: Platform.isIOS
                    ? UpgradeDialogStyle.cupertino
                    : UpgradeDialogStyle.material,
              ),
              child: ViewModelBuilder<WelcomeViewModel>.reactive(
                  viewModelBuilder: () => WelcomeViewModel(context),
                  onModelReady: (vm) => vm.initialise(),
                  builder: (context, vm, child) {
                    return CurvedNavBar(
                      actionButton: CurvedActionBar(
                          onTab: (value) {
                            /// perform action here
                            print(value);
                          },
                          activeIcon: Container(
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: Color(0xff081273),
                                shape: BoxShape.circle),
                            child: vm.currenUser != null
                                ? CachedNetworkImage(
                                    imageUrl: vm.currenUser.photo,
                                    progressIndicatorBuilder:
                                        (context, imageUrl, progress) {
                                      return BusyIndicator();
                                    },
                                    errorWidget: (context, imageUrl, progress) {
                                      return Image.asset(
                                        AppImages.user,
                                      );
                                    },
                                  )
                                    .wh(Vx.dp64, Vx.dp64)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make()
                                : Image.asset(
                                    "assets/images/splash_icon.png",
                                    scale: 2.5,
                                  ),
                          ),
                          inActiveIcon: Container(
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: Color(0xff081273),
                                shape: BoxShape.circle),
                            child: vm.currenUser != null
                                ? CachedNetworkImage(
                                    imageUrl: vm.currenUser.photo,
                                    progressIndicatorBuilder:
                                        (context, imageUrl, progress) {
                                      return BusyIndicator();
                                    },
                                    errorWidget: (context, imageUrl, progress) {
                                      return Image.asset(
                                        AppImages.user,
                                      );
                                    },
                                  )
                                    .wh(Vx.dp64, Vx.dp64)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make()
                                : Image.asset(
                                    "assets/images/splash_icon.png",
                                    scale: 2.5,
                                  ),
                          ),
                          text: "Compte"),
                      activeColor: Colors.white,
                      navBarBackgroundColor: Color(0xff081273),
                      inActiveColor: Colors.white,
                      appBarItems: [
                        FABBottomAppBarItem(
                            activeIcon: Image.asset(
                              "assets/ASSETS/Home Page.png",
                              color: Colors.white,
                              scale: 5.5,
                            ),
                            inActiveIcon: Image.asset(
                              "assets/ASSETS/Home Page.png",
                              color: Colors.white,
                              scale: 5.5,
                            ),
                            text: 'Accuell'),
                        FABBottomAppBarItem(
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: Image.asset(
                              "assets/ASSETS/Vector-2.png",
                              color: Colors.white,
                              scale: 5,
                            ),
                          ),
                          inActiveIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: Image.asset(
                              "assets/ASSETS/Vector-2.png",
                              color: Colors.white,
                              scale: 5,
                            ),
                          ),
                          text: 'Commandes',
                        ),
                        FABBottomAppBarItem(
                            activeIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Image.asset(
                                "assets/ASSETS/Vector.png",
                                color: Colors.white,
                                scale: 5,
                              ),
                            ),
                            inActiveIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Image.asset(
                                "assets/ASSETS/Vector.png",
                                color: Colors.white,
                                scale: 5,
                              ),
                            ),
                            text: 'Business'),
                        FABBottomAppBarItem(
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Image.asset(
                              "assets/ASSETS/Vector-1.png",
                              color: Colors.white,
                              scale: 5,
                            ),
                          ),
                          inActiveIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Image.asset(
                              "assets/ASSETS/Vector-1.png",
                              color: Colors.white,
                              scale: 5,
                            ),
                          ),
                          text: 'Promos',
                        ),
                      ],
                      bodyItems: [
                        model.homeView,
                        OrdersPage(),
                        SearchPage(
                          search: Search(
                            showType: 4,
                          ),
                          showCancel: false,
                        ),
                        PromosPage(),
                      ],
                      actionBarView: ProfilePage(),
                    );
                  }),
            ),
            // fab: SizedBox(
            //   height: 40,
            //   child: FloatingActionButton.extended(
            //     backgroundColor: AppColor.primaryColorDark,
            //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //     onPressed: model.openCart,
            //     icon: Icon(
            //       FlutterIcons.shopping_cart_faw,
            //       color: Colors.white,
            //     ).badge(
            //       position: Utils.isArabic
            //           ? VxBadgePosition.leftTop
            //           : VxBadgePosition.rightTop,
            //       count: model.totalCartItems,
            //       color: Colors.white,
            //       textStyle: context.textTheme.bodyText1?.copyWith(
            //         color: AppColor.primaryColor,
            //         fontSize: 10,
            //       ),
            //     ),
            //     label: "Cart".tr().text.white.make(),
            //   ),
            // ),

            //  BottomNavigationBar(

            //   backgroundColor: Colors.red,
            //   items: [
            //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            //   ],
            //   currentIndex: model.currentIndex,
            //   onTap: model.onTabChange,
            // ),

            // .p16
            // .shadow
            // .color(Theme.of(context).bottomSheetTheme.backgroundColor)
            // .make(),
          );
        },
      ),
    );
  }
}

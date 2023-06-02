import 'package:flutter/material.dart';
import 'package:fuodz/view_models/splash.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';

class SplashPage2 extends StatelessWidget {
  const SplashPage2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: ViewModelBuilder<SplashViewModel>.reactive(
        viewModelBuilder: () => SplashViewModel(context),
        onModelReady: (vm) => vm.navigateToSecondSplash(context),
        builder: (context, model, child) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/94116dda-8e71-4dd8-9b35-7314f4e83e81.jpeg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: VStack(
              [
                Spacer(
                  flex: 2,
                ),

                Center(
                  child: Image.asset(
                    'assets/images/21.png',
                    scale: 1.2,
                  ),
                ),
                // Image.asset(AppImages.appLogo)
                //     .wh(context.percentWidth * 45, context.percentWidth * 45)
                //     .box
                //     .clip(Clip.antiAlias)
                //     .roundedSM
                //     .makeCentered()
                //     .py12(),
                // "Loading Please wait...".tr().text.makeCentered(),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Lottie.asset(
                    'assets/images/loading 12.json',
                    width: 40,
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ).centered(),
          );
        },
      ),
    );
  }
}

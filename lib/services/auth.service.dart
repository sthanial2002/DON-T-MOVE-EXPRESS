import 'dart:convert';
import 'dart:developer';

import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/user.dart';
import 'package:fuodz/services/firebase.service.dart';
import 'package:fuodz/services/http.service.dart';
import 'package:fuodz/view_models/splash.vm.dart';

import 'local_storage.service.dart';

class AuthServices {
  //
  static bool firstTimeOnApp() {
    return LocalStorageService.prefs.getBool(AppStrings.firstTimeOnApp) ?? true;
  }

  static firstTimeCompleted() async {
    await LocalStorageService.prefs.setBool(AppStrings.firstTimeOnApp, false);
  }

  //
  static bool authenticated() {
    return LocalStorageService.prefs.getBool(AppStrings.authenticated) ?? false;
  }

  static Future<bool> isAuthenticated() async {
    await LocalStorageService.rxPrefs.write(
      AppStrings.authenticated,
      true,
      (value) {
        return value;
      },
    );
    return LocalStorageService.prefs.setBool(AppStrings.authenticated, true);
  }

  // Token
  static Future<String> getAuthBearerToken() async {
    return LocalStorageService.prefs.getString(AppStrings.userAuthToken) ?? "";
  }

  static Future<bool> setAuthBearerToken(token) async {
    return LocalStorageService.prefs.setString(AppStrings.userAuthToken, token);
  }

  //Locale
  static String getLocale() {
    return LocalStorageService.prefs.getString(AppStrings.appLocale) ?? "fr";
  }

  static Future<bool> setLocale(language) async {
    return LocalStorageService.prefs.setString(AppStrings.appLocale, language);
  }

  static Stream<bool> listenToAuthState() {
    return LocalStorageService.rxPrefs.observe(
      AppStrings.authenticated,
      (p0) => p0,
    );
  }

  static Stream<bool> listenToProfileState() {
    return LocalStorageService.rxPrefs.observe(
      'editPR',
      (p0) => p0,
    );
  }
  //
  //
  static User currentUser;
  static Future<User> getCurrentUser({bool force = false}) async {
    if (currentUser == null || force) {
      final userStringObject =
          await LocalStorageService.prefs.getString(AppStrings.userKey);
      final userObject = json.decode(userStringObject);
      currentUser = User.fromJson(userObject);
      log("timmmmmm ${currentUser.walletAddress}");
    }
    return currentUser;
    
  }

  ///
  ///
  ///
  static Future<User> saveUser(dynamic jsonObject) async {
    final currentUser1 = User.fromJson(jsonObject);

    try {
      await LocalStorageService.prefs.setString(
        AppStrings.userKey,
        json.encode(
          currentUser1.toJson(),
        ),
      );
      currentUser = currentUser1;
      //subscribe to firebase topic
      FirebaseService().firebaseMessaging.subscribeToTopic("all");
      FirebaseService()
          .firebaseMessaging
          .subscribeToTopic("${currentUser1.id}");
      FirebaseService()
          .firebaseMessaging
          .subscribeToTopic("${currentUser1.role}");

      //log the new
      await SplashViewModel(null).loadAppSettings();

      return currentUser1;
    } catch (error) {
      return null;
    }
  }

  ///
  ///
  //
  static void logout() async {
    await HttpService().getCacheManager().clearAll();
    await LocalStorageService.prefs.clear();
    await LocalStorageService.rxPrefs.clear();
    await LocalStorageService.prefs.setBool(AppStrings.firstTimeOnApp, false);
    FirebaseService().firebaseMessaging.unsubscribeFromTopic("all");
    FirebaseService()
        .firebaseMessaging
        .unsubscribeFromTopic("${currentUser.id}");
    FirebaseService()
        .firebaseMessaging
        .unsubscribeFromTopic("${currentUser.role}");
  }
}

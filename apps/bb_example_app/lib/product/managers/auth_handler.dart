import 'dart:async';
import 'package:bb_example_app/product/utility/enums/cache_enums.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

class SessionHandler extends ChangeNotifier {
  SessionHandler._init();

  static final SessionHandler _instance = SessionHandler._init();

  ///Returns instace for AuthHandler
  static SessionHandler get instance => _instance;


  UserAuthStatus _userAuthStatus = UserAuthStatus.notInitialized;
  UserAuthStatus get userAuthStatus => _userAuthStatus;
  set userAuthStatus(UserAuthStatus value) {
    _userAuthStatus = value;
    onAuthStatusChanged();
    notifyListeners();
  }

  Future<void> init() async {
    await _initializeAuthStatus();
  }

  Future<void> _initializeAuthStatus() async {
    final isUserLoggedIn =
        LocaleManager.instance.getBoolValue(key: CacheKey.loggedIn.name) ??
            false;
    if (isUserLoggedIn) {
      userAuthStatus = UserAuthStatus.authorized;
    } else {
      userAuthStatus = UserAuthStatus.unAuthorized;
    }
  }

  

  


  void onAuthStatusChanged() {
    if (userAuthStatus == UserAuthStatus.authorized) {
      
    } else if (userAuthStatus == UserAuthStatus.unAuthorized) {
      
    }
  }

  ///Logs out the current user.
  ///Sets logged in to false and removes the token from cache.
  Future<void> logOut() async {
    await Future.wait([
      LocaleManager.instance.removeAt(CacheKey.token.name),
      setLoggedIn(value: false),
    ]);
    // currentUser = UserData();
    userAuthStatus = UserAuthStatus.unAuthorized;
  }

  ///Logs in the current user.
  ///Sets logged in to true and removes the token from cache.
  Future<void> logIn({required String token}) async {
    // currentUser = user;
    await Future.wait([
      setLoggedIn(value: true),
      setUserToken(token),
    ]);
    userAuthStatus = UserAuthStatus.authorized;
  }


  Future<void> setLoggedIn({required bool value}) async {
    await LocaleManager.instance.setBoolValue(
      key: CacheKey.loggedIn.name,
      value: value,
    );
  }

  ///Gets the current user token if it's saved.
  String? getUserToken() => LocaleManager.instance.getStringValue(
        key: CacheKey.token.name,
      );

  ///Sets the current user token if it's saved.
  Future<void> setUserToken(String value) async =>
      LocaleManager.instance.setStringValue(
        key: CacheKey.token.name,
        value: value,
      );
}

enum UserAuthStatus {
  notInitialized,
  unAuthorized,
  authorized,
}


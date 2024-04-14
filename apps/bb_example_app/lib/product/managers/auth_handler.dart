import 'dart:async';
import 'dart:convert';
import 'package:api/api.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/service/product_client.dart';
import 'package:bb_example_app/product/utility/enums/cache_enums.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionHandler extends ChangeNotifier {
  SessionHandler._init();

  static final SessionHandler _instance = SessionHandler._init();

  ///Returns instace for AuthHandler
  static SessionHandler get instance => _instance;

  final Rx<MaticPriceResponseModel> _matic = Rx(MaticPriceResponseModel());

  MaticPriceResponseModel get matic => _matic.value;
  set matic(MaticPriceResponseModel value) => _matic
    ..firstRebuild = true
    ..value = value;


  UserAuthStatus _userAuthStatus = UserAuthStatus.notInitialized;
  UserAuthStatus get userAuthStatus => _userAuthStatus;
  set userAuthStatus(UserAuthStatus value) {
    _userAuthStatus = value;
    onAuthStatusChanged();
    notifyListeners();
  }

  Future<void> init() async {
    try{await _initializeAuthStatus();
    await loadPrice();
    Timer.periodic(const Duration(minutes: 1), (timer) async {
      await loadPrice();
    });}
    catch(e){
      rethrow;
    }
  }

  Future<void> _initializeAuthStatus() async {
    final isUserLoggedIn = userCards().isNotEmpty;
    if (isUserLoggedIn) {
      userAuthStatus = UserAuthStatus.authorized;
    } else {
      userAuthStatus = UserAuthStatus.unAuthorized;
    }
  }

  Future<void> loadPrice() async {
    matic = await ProductClient.instance.characterService
        .getPrice()
        .handleRequest();
  }

  

  


  void onAuthStatusChanged() {
    if (userAuthStatus == UserAuthStatus.authorized) {
      
    } else if (userAuthStatus == UserAuthStatus.unAuthorized) {
      setUserCards([]);
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

  List<CardInfoModel> userCards() {
    final cachedCards =
        LocaleManager.instance.getStringListValue(key: CacheKey.cards.name);
    if (cachedCards == null || cachedCards.isEmpty) {
      return [];
    }
    return cachedCards
        .map(
            (e) => CardInfoModel.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  Future<void> setUserCards(List<CardInfoModel> value)async{
    await LocaleManager.instance.setStringListValue(
      key: CacheKey.cards.name,
      value: value.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  Future<void> changeCardInfo(CardInfoModel oldCard,CardInfoModel newCard)async{
      final cardList = userCards();
    int cardIndex;
    cardIndex = cardList.indexWhere(
        (element) => element.cardIdToDisplay == oldCard.cardIdToDisplay);
    if (cardIndex == -1) {
      throw AppException('Card is not added to your wallet.');
    }
    cardList..removeAt(cardIndex)
    ..insert(cardIndex, newCard);
    await setUserCards(cardList);
  }

  Future<void> removeUserCard(CardInfoModel value) async {
    final cardList = userCards();
    var shouldInitializeAuth = false;
    if(cardList.length==1){
      shouldInitializeAuth=true;
    }
    final cardIndex = cardList.indexWhere(
        (element) => element.cardIdToDisplay == value.cardIdToDisplay);
    if (cardIndex == -1) {
      throw AppException('Card not found.');
    }
    cardList.removeAt(cardIndex);
    await setUserCards(cardList);
    if(shouldInitializeAuth){
      await _initializeAuthStatus();
    }
  }

  Future<void> addUserCard(CardInfoModel value) async {
    final cardList = userCards();
    var shouldInitializeAuth = false;
    if(cardList.isEmpty){
      shouldInitializeAuth=true;
    }
    int cardIndex;
    cardIndex = cardList.indexWhere(
        (element) => element.cardIdToDisplay == value.cardIdToDisplay);
    if (cardIndex != -1) {
      throw AppException('Card already added.');
    }
    cardList.insert(0, value);
    await setUserCards(cardList);
    if(shouldInitializeAuth){
      await _initializeAuthStatus();
    }
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


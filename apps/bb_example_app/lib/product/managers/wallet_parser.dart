// ignore_for_file: use_string_buffers, parameter_assignments

import 'dart:convert';

import 'package:api/api.dart';
import 'package:bb_example_app/product/managers/encryption_service.dart';
import 'package:bb_example_app/product/managers/eth_client.dart';
import 'package:bb_example_app/product/service/product_client.dart';
import 'package:flutter/material.dart';
import 'package:values/values.dart';
import 'package:web3dart/web3dart.dart';

class CardInfoModel {
  CardInfoModel({
    required this.url,
  });

  factory CardInfoModel.fromJson(Map<String, dynamic> json) {
    return CardInfoModel(
      url: json['url'] as String,
    );
  }

  CardInfoModel copyWith({
    String? url,
  }) {
    return CardInfoModel(
      url: url ?? this.url,
    );
  }

  final String url;

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }

  Web3Client ethClient = EthClient.instance.ethClient;

  List<String> getParams() {
    if (!url.contains('#')) {
      throw AppException('Invalid card.');
    }
    final seperatedUrl = url.split('#');
    if (seperatedUrl.length != 2) {
      throw AppException('Invalid card.');
    }
    final allDatas = seperatedUrl[1];
    final seperatedDatas = allDatas.split(':');
    if (seperatedDatas.length != 3) {
      throw AppException('Invalid card.');
    }
    return seperatedDatas;
  }

  // Uint8List get privateKey => base64Decode(getParams()[1]);
  String get privateKey => getParams()[1];
  // EncryptionService().base64ToHex(getParams()[1]);

  String deCryptedPrivateKey(String password) {

    List<int> decodedBytes = base64.decode(privateKey);
    String decodedString = utf8.decode(decodedBytes);
    String encodedString = base64.encode(utf8.encode(decodedString));

  
    final decrypted = EncryptionService().decryptAESCryptoJS(
      encodedString,
      password,
    );
    if (encodedString.length != 64) {
      throw AppException('Decryption failed.');
    }
    return decrypted;
  }

  void changeCardPassword(
      {required String newPassword, required String oldPassword}) {
    final decryptedPrivateKey =  deCryptedPrivateKey(oldPassword);

    final encrypted = EncryptionService().encryptAESCryptoJS(
      decryptedPrivateKey,
      newPassword,
    );

  }

  String generateNewUrl(String encryptedPrivateKey) {
    final baseString = url;
    final newCardUrl= baseString.replaceFirst(getParams()[1],encryptedPrivateKey);

    privateKey;
        'https://tap3.me/#CtEk2Gfx0w91la8i4u7TWbcD5Ro=:U2FsdGVkX1/jMsMjHJNufAfXSP15LD0y+TsuWRUepl84SkCUNhUvYDoRb+A0vb0qWVh12B4A2WFR2qvxv8SXhQ==:1l';
    return '';
  }

  String get adress => EncryptionService().base64ToHex(getParams()[0]);

  String get adressToDisplay =>
      '0x${EncryptionService().base64ToHex(getParams()[0])}';

  int get cardId =>
      int.parse(EncryptionService().base64ToBase10(getParams()[2]));

  String get cardIdToDisplay =>
      '#${EncryptionService().base64ToBase10(getParams()[2]).padLeft(4, '0')}';

  Future<EtherAmount> etherBalance() async {
    final etherAmount = await ethClient.getBalance(
      EthereumAddress.fromHex(
        adressToDisplay,
      ),
    );
    return etherAmount;
  }

  Future<void> openPolygonExplorer() async {
    try {
      await 'https://polygonscan.com/address/$adressToDisplay'.launchLink();
    } catch (e) {
      rethrow;
    }
  }

  Future<CardUIModel> cardUiModel() async {
    final balance = await etherBalance();
    final catalogue = await ProductClient.instance.characterService
        .getCatalogue(cardId)
        .handleRequest();

    return CardUIModel(
      adress: adressToDisplay,
      cardId: cardIdToDisplay,
      weiBalance: balance.getValueInUnit(EtherUnit.wei),
      etherBalance: balance.getValueInUnit(EtherUnit.ether),
      cardInfo: this,
      catalogue: catalogue[0],
    );
  }
}


class CardUIModel {

  CardUIModel({
    required this.adress,
    required this.cardId,
    required this.etherBalance,
    required this.weiBalance,
    required this.cardInfo,
    required this.catalogue,
  });

  final String adress;
  final String cardId;
  final double etherBalance;
  final double weiBalance;
  final CatalogueResponseModel catalogue;
  final CardInfoModel cardInfo;


  String get imageUrl => 'https://tap3.me/${getUrlPattern()}';

  Color bgColor (){
    switch (catalogue.idModel) {
      case 4:
        return Colors.black;
      case 5:
        return const Color(0xFFc7252b);
      case 6:
        return const Color(0xFF006faf);
      default:
        return Colors.black;
    }
  }

  String getUrlPattern() {
    
  final regex = RegExp(r"url\('([^']*)'\)");
  final Match? match = regex.firstMatch(catalogue.css!);
  if (match != null) {
    return match.group(1)!;
  } else {
    return '';
  }
}


}
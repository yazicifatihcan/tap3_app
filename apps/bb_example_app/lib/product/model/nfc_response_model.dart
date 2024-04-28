// ignore_for_file: public_member_api_docs
// ignore_for_file: argument_type_not_assignable
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: avoid_dynamic_calls
// ignore_for_file: inference_failure_on_untyped_parameter
// ignore_for_file: invalid_assignment

import 'dart:convert';

class NfcResponseModel {
  NfcResponseModel({
    this.ndef,
    this.mifare,
  });

  factory NfcResponseModel.fromJson(Map<String, dynamic> json) 
      {
        final a = json;
      return NfcResponseModel(
        ndef: json['ndef'] == null ? null : NdefRes.fromJson(json['ndef']),
        mifare: json['mifare'] == null ? null : Mifare.fromJson(json['mifare']),
      );}


  String? parsedPayload() {
    final records = ndef?.cachedMessage?.records;
    if (records?.isNotEmpty ?? false) {
      final payloadBytes = List<int>.from(records!.first.payload!);
      final payload = utf8.decode(payloadBytes);
      return payload;
    }
    return null;
  }

  List<int>? mifareIdentifier() {
    // if(mifare?.identifier==null){
    //   return null;
    // }
    // var mifareIdentifier = List<int>.from(mifare?.identifier);
    // return mifareIdentifier;
  }

  NdefRes? ndef;
  Mifare? mifare;

  Map<String, dynamic> toJson() => {
        'ndef': ndef?.toJson(),
        'mifare': mifare?.toJson(),
      };
}

class Mifare {
  Mifare({
    this.mifareFamily,
    this.historicalBytes,
    this.identifier,
  });

  factory Mifare.fromJson(Map<String, dynamic> json) => Mifare(
        mifareFamily: json['mifareFamily'],
        historicalBytes: json['historicalBytes'] == null
            ? []
            : List<dynamic>.from(json['historicalBytes']!.map((x) => x)),
        identifier: json['identifier'] == null
            ? []
            : List<int>.from(json['identifier']!.map((x) => x)),
      );
  int? mifareFamily;
  List<dynamic>? historicalBytes;
  List<int>? identifier;

  Map<String, dynamic> toJson() => {
        'mifareFamily': mifareFamily,
        'historicalBytes': historicalBytes == null
            ? <dynamic>[]
            : List<dynamic>.from(historicalBytes!.map((x) => x)),
        'identifier': identifier == null
            ? <dynamic>[]
            : List<dynamic>.from(identifier!.map((x) => x)),
      };
}

class NdefRes {
  NdefRes({
    this.maxSize,
    this.cachedMessage,
    this.isWritable,
  });

  factory NdefRes.fromJson(Map<String, dynamic> json) => NdefRes(
        maxSize: json['maxSize'],
        cachedMessage: json['cachedMessage'] == null
            ? null
            : CachedMessage.fromJson(json['cachedMessage']),
        isWritable: json['isWritable'],
      );
  int? maxSize;
  CachedMessage? cachedMessage;
  bool? isWritable;

  Map<String, dynamic> toJson() => {
        'maxSize': maxSize,
        'cachedMessage': cachedMessage?.toJson(),
        'isWritable': isWritable,
      };
}

class CachedMessage {
  CachedMessage({
    this.records,
  });

  factory CachedMessage.fromJson(Map<String, dynamic> json) => CachedMessage(
        records: json['records'] == null
            ? []
            : List<Record>.from(
                json['records']!.map((x) => Record.fromJson(x))),
      );
  List<Record>? records;

  Map<String, dynamic> toJson() => {
        'records': records == null
            ? <dynamic>[]
            : List<dynamic>.from(records!.map((x) => x.toJson())),
      };
}

class Record {
  Record({
    this.identifier,
    this.typeNameFormat,
    this.type,
    this.payload,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        identifier: json['identifier'] == null
            ? []
            : List<dynamic>.from(json['identifier']!.map((x) => x)),
        typeNameFormat: json['typeNameFormat'],
        type: json['type'] == null
            ? []
            : List<int>.from(json['type']!.map((x) => x)),
        payload: json['payload'] == null
            ? []
            : List<int>.from(json['payload']!.map((x) => x)),
      );
  List<dynamic>? identifier;
  int? typeNameFormat;
  List<int>? type;
  List<int>? payload;

  Map<String, dynamic> toJson() => {
        'identifier': identifier == null
            ? <dynamic>[]
            : List<dynamic>.from(identifier!.map((x) => x)),
        'typeNameFormat': typeNameFormat,
        'type': type == null ? <dynamic>[] : List<dynamic>.from(type!.map((x) => x)),
        'payload':
            payload == null ? <dynamic>[] : List<dynamic>.from(payload!.map((x) => x)),
      };
}

// ignore_for_file: public_member_api_docs
// ignore_for_file: argument_type_not_assignable
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: avoid_dynamic_calls
// ignore_for_file: inference_failure_on_untyped_parameter
// ignore_for_file: invalid_assignment

import 'package:api/api.dart';

class MaticPriceResponseModel extends IBaseModel<MaticPriceResponseModel> {

    MaticPriceResponseModel({
        this.id,
        this.name,
        this.symbol,
        this.rank,
        this.totalSupply,
        this.maxSupply,
        this.betaValue,
        this.firstDataAt,
        this.lastUpdated,
        this.quotes,
    });
    String? id;
    String? name;
    String? symbol;
    int? rank;
    int? totalSupply;
    int? maxSupply;
    double? betaValue;
    DateTime? firstDataAt;
    DateTime? lastUpdated;
    Quotes? quotes;

    @override
  MaticPriceResponseModel fromJson(Map<String, dynamic> json) => MaticPriceResponseModel(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        rank: json['rank'],
        totalSupply: json['total_supply'],
        maxSupply: json['max_supply'],
        betaValue: json['beta_value']?.toDouble(),
        firstDataAt: json['first_data_at'] == null ? null : DateTime.parse(json['first_data_at']),
        lastUpdated: json['last_updated'] == null ? null : DateTime.parse(json['last_updated']),
        quotes: json['quotes'] == null ? null : Quotes().fromJson(json['quotes']),
    );

    @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'symbol': symbol,
        'rank': rank,
        'total_supply': totalSupply,
        'max_supply': maxSupply,
        'beta_value': betaValue,
        'first_data_at': firstDataAt?.toIso8601String(),
        'last_updated': lastUpdated?.toIso8601String(),
        'quotes': quotes?.toJson(),
    };
}

class Quotes {

    Quotes({
        this.usd,
    });
    Usd? usd;

    Quotes fromJson(Map<String, dynamic> json) => Quotes(
        usd: json['USD'] == null ? null : Usd.fromJson(json['USD']),
    );

    Map<String, dynamic> toJson() => {
        'USD': usd?.toJson(),
    };
}

class Usd {
    double? price;
    double? volume24H;
    double? volume24HChange24H;
    int? marketCap;
    double? marketCapChange24H;
    double? percentChange15M;
    double? percentChange30M;
    double? percentChange1H;
    double? percentChange6H;
    double? percentChange12H;
    double? percentChange24H;
    double? percentChange7D;
    double? percentChange30D;
    double? percentChange1Y;
    double? athPrice;
    DateTime? athDate;
    double? percentFromPriceAth;

    Usd({
        this.price,
        this.volume24H,
        this.volume24HChange24H,
        this.marketCap,
        this.marketCapChange24H,
        this.percentChange15M,
        this.percentChange30M,
        this.percentChange1H,
        this.percentChange6H,
        this.percentChange12H,
        this.percentChange24H,
        this.percentChange7D,
        this.percentChange30D,
        this.percentChange1Y,
        this.athPrice,
        this.athDate,
        this.percentFromPriceAth,
    });

    factory Usd.fromJson(Map<String, dynamic> json) => Usd(
        price: json['price']?.toDouble(),
        volume24H: json['volume_24h']?.toDouble(),
        volume24HChange24H: json['volume_24h_change_24h']?.toDouble(),
        marketCap: json['market_cap'],
        marketCapChange24H: json['market_cap_change_24h']?.toDouble(),
        percentChange15M: json['percent_change_15m']?.toDouble(),
        percentChange30M: json['percent_change_30m']?.toDouble(),
        percentChange1H: json['percent_change_1h']?.toDouble(),
        percentChange6H: json['percent_change_6h']?.toDouble(),
        percentChange12H: json['percent_change_12h']?.toDouble(),
        percentChange24H: json['percent_change_24h']?.toDouble(),
        percentChange7D: json['percent_change_7d']?.toDouble(),
        percentChange30D: json['percent_change_30d']?.toDouble(),
        percentChange1Y: json['percent_change_1y']?.toDouble(),
        athPrice: json['ath_price']?.toDouble(),
        athDate: json['ath_date'] == null ? null : DateTime.parse(json['ath_date']),
        percentFromPriceAth: json['percent_from_price_ath']?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        'price': price,
        'volume_24h': volume24H,
        'volume_24h_change_24h': volume24HChange24H,
        'market_cap': marketCap,
        'market_cap_change_24h': marketCapChange24H,
        'percent_change_15m': percentChange15M,
        'percent_change_30m': percentChange30M,
        'percent_change_1h': percentChange1H,
        'percent_change_6h': percentChange6H,
        'percent_change_12h': percentChange12H,
        'percent_change_24h': percentChange24H,
        'percent_change_7d': percentChange7D,
        'percent_change_30d': percentChange30D,
        'percent_change_1y': percentChange1Y,
        'ath_price': athPrice,
        'ath_date': athDate?.toIso8601String(),
        'percent_from_price_ath': percentFromPriceAth,
    };
}

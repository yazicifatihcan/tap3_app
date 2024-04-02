// ignore_for_file: public_member_api_docs
// ignore_for_file: argument_type_not_assignable
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: avoid_dynamic_calls
// ignore_for_file: inference_failure_on_untyped_parameter
// ignore_for_file: invalid_assignment

import 'package:api/src/index.dart';
import 'package:api/src/repositories/character_module/endpoint/characters_path.dart';

///Response to [DioHttpMethod.get]-[CharacterServicePath.characters]
class AllCharactersResponseModel
    extends IBaseModel<AllCharactersResponseModel> {
  ///Response to [DioHttpMethod.get]-[CharacterServicePath.characters]
  AllCharactersResponseModel({
    this.info,
    this.results,
  });

  Info? info;
  List<Result>? results;

  @override
  Map<String, dynamic> toJson() => {
        'info': info?.toJson(),
        'results': results == null
            ? <dynamic>[]
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };

  @override
  AllCharactersResponseModel fromJson(Map<String, dynamic> json) =>
      AllCharactersResponseModel(
        info: json['info'] == null
            ? null
            : Info.fromJson(json['info'] as Map<String, dynamic>),
        results: json['results'] == null
            ? []
            : List<Result>.from(
                json['results']!
                    .map((e)=>Result().fromJson(e)),
              ),
      );
}

class Info {
  Info({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json['count'] as int?,
        pages: json['pages'] as int?,
        next: json['next'] as String?,
        prev: json['prev'] as dynamic,
      );
  int? count;
  int? pages;
  String? next;
  dynamic prev;

  Map<String, dynamic> toJson() => {
        'count': count,
        'pages': pages,
        'next': next,
        'prev': prev,
      };
}

class Result extends IBaseModel<Result>{
  Result({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  @override
  Result fromJson(Map<String, dynamic> json) => Result(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin:
            json['origin'] == null ? null : Location.fromJson(json['origin']),
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location']),
        image: json['image'],
        episode: json['episode'] == null
            ? []
            : List<String>.from(json['episode']!.map((x) => x)),
        url: json['url'],
        created:
            json['created'] == null ? null : DateTime.parse(json['created']),
      );
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Location? origin;
  Location? location;
  String? image;
  List<String>? episode;
  String? url;
  DateTime? created;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'origin': origin?.toJson(),
        'location': location?.toJson(),
        'image': image,
        'episode': episode == null
            ? <dynamic>[]
            : List<dynamic>.from(
                episode!.map((x) => x),
              ),
        'url': url,
        'created': created?.toIso8601String(),
      };
}

class Location {
  Location({
    this.name,
    this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name'],
        url: json['url'],
      );
  String? name;
  String? url;

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}

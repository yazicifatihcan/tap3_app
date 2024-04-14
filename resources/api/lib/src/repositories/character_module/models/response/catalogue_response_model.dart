// ignore_for_file: public_member_api_docs
// ignore_for_file: argument_type_not_assignable
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: avoid_dynamic_calls
// ignore_for_file: inference_failure_on_untyped_parameter
// ignore_for_file: invalid_assignment

import 'package:api/api.dart';

class CatalogueResponseModel extends IBaseModel<CatalogueResponseModel>{
    int? idModel;
    String? css;
    dynamic svg;

    CatalogueResponseModel({
        this.idModel,
        this.css,
        this.svg,
    });

    @override
  CatalogueResponseModel fromJson(Map<String, dynamic> json) => CatalogueResponseModel(
        idModel: json['id_model'],
        css: json['css'],
        svg: json['svg'],
    );

    @override
  Map<String, dynamic> toJson() => {
        'id_model': idModel,
        'css': css,
        'svg': svg,
    };
}

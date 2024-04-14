import 'package:api/src/index.dart';
import 'package:api/src/repositories/character_module/endpoint/characters_path.dart';
import 'package:api/src/repositories/character_module/models/response/catalogue_response_model.dart';
import 'package:api/src/repositories/character_module/models/response/price_response_model.dart';

///Class that handles all Auth Module requests.
class CharacterService extends BaseClient {
  ///Class that handles all Auth Module requests.
  CharacterService({
    required this.dioClient,
  }) : super(dio: dioClient);

  ///Client to use in requests
  final DioClient dioClient;


  ///Request that returns all characters
  Future<BaseHttpModel<List<CatalogueResponseModel>>> getCatalogue(int id) async {
    return baseRequest<CatalogueResponseModel,List<CatalogueResponseModel>>(
      responseModel: CatalogueResponseModel(),
      httpUrl: CharacterServicePath.catalogue.withPath(id.toString()),
      method: DioHttpMethod.get,
    );
  }

  ///Request that returns all characters
  Future<BaseHttpModel<MaticPriceResponseModel>> getPrice() async {
    return baseRequest<MaticPriceResponseModel,MaticPriceResponseModel>(
      responseModel: MaticPriceResponseModel(),
      httpUrl: CharacterServicePath.price.value,
      method: DioHttpMethod.get,
      otherBaseUrl: 'api.coinpaprika.com',
    );
  }
}

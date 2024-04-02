import 'package:api/src/index.dart';
import 'package:api/src/repositories/character_module/endpoint/characters_path.dart';

///Class that handles all Auth Module requests.
class CharacterService extends BaseClient {
  ///Class that handles all Auth Module requests.
  CharacterService({
    required this.dioClient,
  }) : super(dio: dioClient);

  ///Client to use in requests
  final DioClient dioClient;

  ///Request that returns all characters
  Future<BaseHttpModel<AllCharactersResponseModel>> getAllCharacters() async {
    return baseRequest<AllCharactersResponseModel,AllCharactersResponseModel>(
      responseModel: AllCharactersResponseModel(),
      httpUrl: CharacterServicePath.characters.value,
      method: DioHttpMethod.get,
    );
  }
}

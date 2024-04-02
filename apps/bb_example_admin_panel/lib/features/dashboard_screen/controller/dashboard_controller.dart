import 'package:api/api.dart';
import 'package:bb_example_admin_panel/product/base/controller/base_controller.dart';
import 'package:get/get.dart';

///Controller for Example Screen
class DashboardController extends BaseControllerInterface {

  final Rx<AllCharactersResponseModel> _characters = Rx(
    AllCharactersResponseModel(),
  );

  set characters (AllCharactersResponseModel value) => _characters.value=value;
  AllCharactersResponseModel get characters => _characters.value;
  
  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {
      await _getAllCharacters();
    });
  }

  Future<void> _getAllCharacters() async {
    characters = await client.authRepository.getAllCharacters().handleRequest(
      skipExceptionCode: BaseModelStatus.notFound,
      defaultResponse: AllCharactersResponseModel(),
    );
  }

  
}

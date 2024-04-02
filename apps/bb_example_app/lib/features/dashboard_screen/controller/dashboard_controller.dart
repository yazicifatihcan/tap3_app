import 'package:api/api.dart';
import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/managers/auth_handler.dart';
import 'package:common/common.dart';
import 'package:get/get.dart';
import 'package:values/values.dart';
import 'package:widgets/widget.dart';

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
    characters = await client.characterService.getAllCharacters().handleRequest(
      skipExceptionCode: BaseModelStatus.notFound,
      defaultResponse: AllCharactersResponseModel(),
    );
  }

  void onChangeThemeSwitch() => AppStateController.instance.setTheme(
        colorPalette: AppStateController.instance.getCurrentThemeCode ==
                DarkColors().themeCode
            ? LightColors()
            : DarkColors(),
      );

  void onTapLogout() {
    sessionManager.logOut();
    SessionHandler.instance.userAuthStatus = UserAuthStatus.unAuthorized;
    ToastMessage.showToastMessage(
      message: context.i10n.succesfullyLoggedOut,
      type: ToastMessageType.success,
    );
  }

}

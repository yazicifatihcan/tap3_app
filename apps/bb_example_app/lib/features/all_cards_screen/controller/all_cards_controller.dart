import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/managers/card_handler.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/option_selection_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:values/values.dart';

class AllCardsController extends BaseControllerInterface with CardHandler {
  final Rx<List<CardUIModel>> _activeCards = Rx([]);

  List<CardUIModel> get activeCards => _activeCards.value;
  set activeCards(List<CardUIModel> value) => _activeCards
    ..firstRebuild = true
    ..value = value;

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {
      await setCards();
    });
  }

  Future<void> setCards() async {
    await Future.forEach(sessionManager.userCards(), (elem) async {
      if (activeCards.indexWhere(
              (element) => element.cardInfo.cardId == elem.cardId) ==
          -1) {
        activeCards.add(await elem.cardUiModel());
      }
    });
    activeCards = activeCards;
  }

  void onTapMoreOptions(CardUIModel item) {
    OptionSelectionBottomSheet(
      options: [
        if (sessionManager.selectedCardAdress != item.cardInfo.adressToDisplay)
          OptionItemModel(
              title: 'Set as default card',
              icon: const IconAssets().copyIcon,
              onTap: () async {
                await sessionManager.setSelectedCard(item.cardInfo);
              }),
        OptionItemModel(
            title: 'Buy Crypto',
            icon: const IconAssets().copyIcon,
            onTap: () async {
              await buyCrypto(context: context, card: item);
            }),
        OptionItemModel(
            title: 'Sell Crypto',
            icon: const IconAssets().copyIcon,
            onTap: () async {
              await sellCrypto(context: context, card: item);
            }),
        OptionItemModel(
            title: 'Show private key',
            icon: const IconAssets().copyIcon,
            onTap: () async {
              await showPrivateKey(card: item, context: context);
            }),
        OptionItemModel(
            title: 'Change password',
            icon: const IconAssets().copyIcon,
            onTap: () async {
              await changePasswordProcess(
                context: context,
                card: item.cardInfo,
              );
            }),
        OptionItemModel(
            title: 'Wipe the card',
            color: context.error,
            icon: const IconAssets().copyIcon,
            onTap: () async {
              await wipeCard(card: item.cardInfo, context: context);
            }),
      ],
    ).showBottomSheet(context: context);
  }
}

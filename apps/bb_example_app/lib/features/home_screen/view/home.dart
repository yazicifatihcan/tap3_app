import 'package:bb_example_app/features/home_screen/controller/home_controller.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:bb_example_app/product/utility/enums/module_radius_enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:values/values.dart';
import 'package:widgets/widget.dart';

class Home extends StatelessWidget {
  const Home({required this.controller, super.key});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed: controller.onTapAddCard,
          child: const Icon(Icons.wifi),
        ).isVisible(value: controller.loadingStatus.isLoaded),
      ),
      appBar: AppBar(
        title: const Text('My Wallet'),
        actions: [
          InkWell(
            onTap: controller.onTapScanQr,
            child: Icon(
              Icons.qr_code_scanner_outlined,
              color: context.onSurface,
            ),
          ),
          SizedBox(
            width: ModulePadding.l.value,
          ),
        ],
      ),
      body: BaseView<HomeController>(
        controller: controller,
        child: Padding(
          padding: EdgeInsets.all(ModulePadding.l.value),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => AnimatedStackedCards(
                    maticPrice:controller.sessionManager.matic.quotes!.usd!.price!,
                    cards: controller.activeCards,
                    selectedIndex: controller.selectedCardIndex,
                    onTapChangeCard: controller.onTapChangeCard,
                    onTapMoreOptions: controller.onTapMoreOptions,
                    onTapShowQr: controller.onTapShowQr,
                    onTapDiscover: controller.onTapDiscover,
                    onTapPay: controller.onTapPayment,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final SvgGeneralImage icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(color: context.outlineVariant.withOpacity(.4)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(color: context.outlineVariant..withOpacity(.6)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(color: context.outlineVariant),
                child: Padding(
                  padding: EdgeInsets.all(ModulePadding.xs.value),
                  child: Column(
                    children: [
                      icon.svg(),
                      const NeonPoint(
                        lightSpreadRadius: 22,
                      ),
                      FlickerNeonText(
                        text: label,
                        flickerTimeInMilliSeconds: 1000,
                        spreadColor: context.primary,
                        randomFlicker: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  const CreditCard({
    Key? key,
    required this.cardItem,
    this.onTapQr,
    this.onTapMoreOptions,
    required this.isSelected,
    required this.maticPrice,
    this.aspectRatio,
  }) : super(key: key);

  final CardUIModel cardItem;
  final double? aspectRatio;
  final VoidCallback? onTapQr;
  final bool isSelected;
  final double maticPrice;
  final VoidCallback? onTapMoreOptions;

  @override
  Widget build(BuildContext context) {
    return NeonContainer(
      lightBlurRadius: 20,
      borderRadius: BorderRadius.circular(ModuleRadius.m.value),
      spreadColor: cardItem.bgColor(),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: aspectRatio ?? 1016 / 638,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(ModuleRadius.m.value),
              child: GeneralCachedImage(
                imageUrl: cardItem.imageUrl,
                externalImageWidget:(context,provider)=> DecoratedBox(
                  decoration: BoxDecoration(
                    color: cardItem.bgColor(),
                    image: DecorationImage(
                      image:provider,
                      fit: BoxFit.cover
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: ModulePadding.s.value,
            right: ModulePadding.s.value,
            child: Row(
              children: [
                _CircleOptionIcon(
                  onTap: ()=>onTapQr?.call(),
                  svg: const IconAssets().qrIcon.svg(),
                ).isVisible(value: onTapQr!=null),
                SizedBox(
                  width: ModulePadding.xxs.value,
                ),
                _CircleOptionIcon(
                  onTap: ()=>onTapMoreOptions?.call(),
                  svg: const IconAssets().moreIcon.svg(),
                ).isVisible(value: onTapMoreOptions!=null),
              ],
            ),
          ).isVisible(value: isSelected),
          Positioned(
            top: ModulePadding.s.value,
            left: ModulePadding.s.value,
            child: _HighlightWidget(
              child: Text(
                cardItem.adress.trimString(),
                style: context.titleLarge.copyWith(color: Colors.black),
              ),
            ),
          ).isVisible(value: isSelected),
          Positioned(
            bottom: ModulePadding.s.value,
            left: ModulePadding.s.value,
            child: _HighlightWidget(
              child: Text(
                cardItem.cardId,
                style: context.titleLarge.copyWith(color: Colors.black),
              ),
            ),
          ).isVisible(value: isSelected),
          Positioned(
            bottom: ModulePadding.s.value,
            right: ModulePadding.s.value,
            child: _HighlightWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '~${(cardItem.etherBalance*maticPrice).toStringAsFixed(2)} USD',
                    style: context.titleLarge.copyWith(color: Colors.black),
                  ),
                  Text(
                    '${cardItem.etherBalance} MATIC',
                    style: context.titleLarge.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ).isVisible(value: isSelected),
        ],
      ),
    );
  }
}

class _HighlightWidget extends StatelessWidget {
  const _HighlightWidget({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(.5),
      child: Padding(
        padding: EdgeInsets.all(ModulePadding.xs.value),
        child: child,
      ),
    );
  }
}

class _CircleOptionIcon extends StatelessWidget {
  const _CircleOptionIcon({
    required this.svg,
    required this.onTap,
  });

  final Widget svg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: context.scrim.withOpacity(.2),
        child: svg,
      ),
    );
  }
}

class AnimatedStackedCards extends StatelessWidget {
  const AnimatedStackedCards({
    Key? key,
    required this.cards,
    required this.selectedIndex,
    required this.onTapChangeCard,
    required this.onTapMoreOptions,
    required this.onTapShowQr,
    required this.onTapPay,
    required this.onTapDiscover,
    required this.maticPrice,
  }) : super(key: key);

  final List<CardUIModel> cards;
  final int selectedIndex;
  final void Function(int) onTapChangeCard;
  final void Function(CardUIModel) onTapMoreOptions;
  final void Function(CardUIModel) onTapShowQr;
  final void Function(CardUIModel) onTapPay;
  final void Function(CardUIModel) onTapDiscover;
  final double maticPrice;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Display unselected cards
        for (int i = 0; i < cards.length; i++)
          if (i != selectedIndex)
            Positioned(
              left: 0,
              right: 0,
              bottom: 30 * (i + 1),
              child: GestureDetector(
                onTap: () => onTapChangeCard(i),
                child: CreditCard(
                    isSelected: false,
                    maticPrice: maticPrice,
                    aspectRatio: 3,
                    cardItem: cards[i],
                    onTapMoreOptions: () => onTapMoreOptions(cards[i]),
                    onTapQr: () => onTapShowQr(cards[i]),
                  ),
              ),
            ),

        // Display selected card with animation
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          left: 0,
          right: 0,
          top: selectedIndex == 0 ? 0 : 20,
          curve: Curves.easeInOut,
          child: GestureDetector(
            onTap: () => onTapChangeCard(selectedIndex),
            child: Column(
              children: [
                CreditCard(
                  maticPrice:maticPrice,
                    isSelected: true,
                    cardItem: cards[selectedIndex],
                    onTapMoreOptions: () =>
                        onTapMoreOptions(cards[selectedIndex]),
                    onTapQr: () => onTapShowQr(cards[selectedIndex]),
                  ),
                SizedBox(
                  height: ModulePadding.m.value,
                ),

                Padding(
                  padding: EdgeInsets.only(top: ModulePadding.m.value),
                  child: Row(
                    children: [
                      Expanded(
                        child: _ActionCard(
                          icon: const IconAssets().payIcon,
                          label: 'Pay',
                          onTap: () => onTapPay(cards[selectedIndex]),
                        ),
                      ),
                      SizedBox(
                        width: ModulePadding.s.value,
                      ),
                      Expanded(
                        child: _ActionCard(
                          icon: const IconAssets().discoverIcon,
                          label: 'Explore',
                          onTap: () => onTapDiscover(cards[selectedIndex]),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}



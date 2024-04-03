import 'package:bb_example_app/features/home_screen/controller/home_controller.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:bb_example_app/product/utility/enums/module_radius_enums.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:values/values.dart';

class Home extends StatelessWidget {
  const Home({required this.controller, super.key});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
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
                child: Obx(() => AnimatedStackedCards(
                      cards: controller.cards,
                      selectedIndex: controller.selectedCardIndex,
                      onTapChangeCard: controller.onTapChangeCard,
                      onTapMoreOptions: controller.onTapMoreOptions,
                      onTapShowQr: controller.onTapShowQr,
                      onTapDiscover: controller.onTapDiscover,
                      onTapPay: controller.onTapPayment,
                    ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedSelectedCard extends StatelessWidget {
  const AnimatedSelectedCard({
    Key? key,
    required this.cardItem,
    required this.onTapMoreOptions,
    required this.onTapQr,
    required this.isSelected,
    required this.onTapPay,
    required this.onTapDiscover,
  }) : super(key: key);

  final CardModel cardItem;
  final VoidCallback onTapMoreOptions;
  final VoidCallback onTapQr;
  final void Function(CardModel) onTapPay;
  final void Function(CardModel) onTapDiscover;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCard(
          cardItem: cardItem,
          onTapMoreOptions: onTapMoreOptions,
          onTapQr: onTapQr,
        ),
        Padding(
          padding: EdgeInsets.only(top: ModulePadding.m.value),
          child: Row(
            children: [
              Expanded(
                  child: _ActionCard(
                icon: const IconAssets().payIcon,
                label: 'Pay',
                onTap: () => onTapPay(cardItem),
              )),
              SizedBox(
                width: ModulePadding.s.value,
              ),
              Expanded(
                  child: _ActionCard(
                icon: const IconAssets().discoverIcon,
                label: 'Discover',
                onTap: () => onTapDiscover(cardItem),
              )),
            ],
          ),
        ).isVisible(value: isSelected),
      ],
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
        decoration: BoxDecoration(color: context.outlineVariant),
        child: Padding(
          padding: EdgeInsets.all(ModulePadding.xs.value),
          child: Column(
            children: [
              icon.svg(),
              Text(label),
            ],
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
    required this.onTapQr,
    required this.onTapMoreOptions,
  }) : super(key: key);

  final CardModel cardItem;
  final VoidCallback onTapQr;
  final VoidCallback onTapMoreOptions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth(context) - (2 * ModulePadding.l.value),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1016 / 638,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(ModuleRadius.m.value),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: Image.network(
                      cardItem.imageUrl,
                      fit: BoxFit.cover,
                    ).image,
                  ),
                ),
                child: const SizedBox(),
              ),
            ),
          ),
          Positioned(
            top: ModulePadding.s.value,
            right: ModulePadding.s.value,
            child: Row(
              children: [
                _CircleOptionIcon(
                  onTap: onTapQr,
                  svg: const IconAssets().qrIcon.svg(),
                ),
                SizedBox(
                  width: ModulePadding.xxs.value,
                ),
                _CircleOptionIcon(
                  onTap: onTapMoreOptions,
                  svg: const IconAssets().moreIcon.svg(),
                )
              ],
            ),
          ),
          Positioned(
            top: ModulePadding.s.value,
            left: ModulePadding.s.value,
            child: _HighlightWidget(
              child: Text(
                cardItem.privateKey,
                style: context.titleLarge.copyWith(color: Colors.black),
              ),
            ),
          ),
          Positioned(
            bottom: ModulePadding.s.value,
            left: ModulePadding.s.value,
            child: _HighlightWidget(
              child: Text(
                '#${cardItem.cardNumber}',
                style: context.titleLarge.copyWith(color: Colors.black),
              ),
            ),
          ),
          Positioned(
            bottom: ModulePadding.s.value,
            right: ModulePadding.s.value,
            child: _HighlightWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '~${cardItem.usd} USD',
                    style: context.titleLarge.copyWith(color: Colors.black),
                  ),
                  Text(
                    '${cardItem.matic} MATIC',
                    style: context.titleLarge.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
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
  }) : super(key: key);

  final List<CardModel> cards;
  final int selectedIndex;
  final void Function(int) onTapChangeCard;
  final void Function(CardModel) onTapMoreOptions;
  final void Function(CardModel) onTapShowQr;
  final void Function(CardModel) onTapPay;
  final void Function(CardModel) onTapDiscover;

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
                  cardItem: cards[i],
                  onTapMoreOptions: ()=>onTapMoreOptions(cards[i]),
                  onTapQr: ()=>onTapShowQr(cards[i]),
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
                  cardItem: cards[selectedIndex],
                  onTapMoreOptions: ()=>onTapMoreOptions(cards[selectedIndex]),
                  onTapQr: ()=>onTapShowQr(cards[selectedIndex]),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: ModulePadding.m.value),
                  child: Row(
                    children: [
                      Expanded(
                        child: _ActionCard(
                          icon: const IconAssets().payIcon,
                          label: 'Pay',
                          onTap: ()=>onTapPay(cards[selectedIndex]),
                        ),
                      ),
                      SizedBox(width: ModulePadding.s.value,),
                      Expanded(
                        child: _ActionCard(
                          icon: const IconAssets().discoverIcon,
                          label: 'Discover',
                          onTap: ()=>onTapDiscover(cards[selectedIndex]),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

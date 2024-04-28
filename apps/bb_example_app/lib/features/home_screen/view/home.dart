import 'package:bb_example_app/features/home_screen/controller/home_controller.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:bb_example_app/product/utility/enums/module_radius_enums.dart';
import 'package:common/common.dart';
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
              Obx(() => CreditCard(
                    showNeon: true,
                    isSelected: true,
                    maticPrice:
                        controller.sessionManager.matic.quotes?.usd?.price ?? 0,
                    cardItem: controller.selectedCard(),
                    onTapMoreOptions: () =>
                        controller.onTapMoreOptions(controller.selectedCard()),
                    onTapQr: () =>
                        controller.onTapShowQr(controller.selectedCard()),
                  )),
              SizedBox(
                height: ModulePadding.xl.value,
              ),
              Row(
                children: [
                  Expanded(
                    child: _ActionCard(
                      icon: const IconAssets().payIcon,
                      label: 'Pay',
                      onTap: () =>
                          controller.onTapPayment(controller.selectedCard()),
                    ),
                  ),
                  SizedBox(
                    width: ModulePadding.s.value,
                  ),
                  Expanded(
                    child: _ActionCard(
                      icon: const IconAssets().discoverIcon,
                      label: 'Explore',
                      onTap: () =>
                          controller.onTapDiscover(controller.selectedCard()),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ModulePadding.xs.value,
              ),
              Row(
                children: [
                  Expanded(
                    child: _ActionCard(
                      icon: const IconAssets().payIcon,
                      label: 'Buy',
                      onTap: ()=>controller.buyCrypto(card: controller.selectedCard(),context: context),
                    ),
                  ),
                  SizedBox(
                    width: ModulePadding.s.value,
                  ),
                  Expanded(
                    child: _ActionCard(
                      icon: const IconAssets().discoverIcon,
                      label: 'Sell',
                      onTap: ()=>controller.sellCrypto(card: controller.selectedCard(),context: context),
                    ),
                  ),
                ],
              ),
              Obx(
                () => InkWell(
                  onTap: controller.onTapAllCards,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: ModulePadding.m.value),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'All Cards',
                            style: context.headlineSmall,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: context.onBackground,
                        ),
                      ],
                    ),
                  ),
                ).isVisible(value: controller.activeCards.length > 1),
              ),
              Expanded(
                child: Obx(
                  () => PageView.builder(
                      clipBehavior: Clip.none,
                      padEnds: false,
                      itemCount: controller.unSelectedCards().length,
                      controller: PageController(
                        viewportFraction:
                             .95,
                      ),

                    itemBuilder:(context,index){
                      final item = controller.unSelectedCards()[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: GestureDetector(
                            onTap: () => controller.onTapMoreOptions(item),
                            child: CreditCard(
                              aspectRatio: 3,
                              showNeon: false,
                              cardItem: item,
                              isSelected: false,
                              maticPrice: controller
                                  .sessionManager.matic.quotes!.usd!.price!,
                            ),
                          ),
                        ); 
                    }
                    // List.generate(
                    //   controller.unSelectedCards().length,
                    //   (index) {
                    //     final item = controller.unSelectedCards()[index];
                    //     return GestureDetector(
                    //       onTap: () => controller.onTapMoreOptions(item),
                    //       child: CreditCard(
                    //         aspectRatio: 3,
                    //         showNeon: false,
                    //         cardItem: item,
                    //         isSelected: false,
                    //         maticPrice: controller
                    //             .sessionManager.matic.quotes!.usd!.price!,
                    //       ),
                    //     );
                    //   },
                    // ),
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
        decoration:
            BoxDecoration(color: context.outlineVariant.withOpacity(.4)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DecoratedBox(
            decoration:
                BoxDecoration(color: context.outlineVariant..withOpacity(.6)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(color: context.outlineVariant),
                child: Padding(
                  padding: EdgeInsets.all(ModulePadding.xs.value),
                  child: Column(
                    children: [
                      icon.svg(height: 24, width: 24),
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
    required this.showNeon,
    required this.maticPrice,
    this.aspectRatio,
  }) : super(key: key);

  final CardUIModel cardItem;
  final double? aspectRatio;
  final VoidCallback? onTapQr;
  final bool isSelected;
  final bool showNeon;
  final double maticPrice;
  final VoidCallback? onTapMoreOptions;

  @override
  Widget build(BuildContext context) {
    final child = Stack(
      children: [
        AspectRatio(
          aspectRatio: aspectRatio ?? 1016 / 638,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ModuleRadius.m.value),
            child: GeneralCachedImage(
              imageUrl: cardItem.imageUrl,
              externalImageWidget: (context, provider) => DecoratedBox(
                decoration: BoxDecoration(
                  color: cardItem.bgColor(),
                  image: DecorationImage(image: provider, fit: BoxFit.cover),
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
                onTap: () => onTapQr?.call(),
                svg: const IconAssets().qrIcon.svg(),
              ).isVisible(value: onTapQr != null),
              SizedBox(
                width: ModulePadding.xxs.value,
              ),
              _CircleOptionIcon(
                onTap: () => onTapMoreOptions?.call(),
                svg: const IconAssets().moreIcon.svg(),
              ).isVisible(value: onTapMoreOptions != null),
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
                  '~${(cardItem.etherBalance * maticPrice).toStringAsFixed(2)} USD',
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
    );

    return showNeon
        ? NeonContainer(
            lightBlurRadius: 20,
            borderRadius: BorderRadius.circular(ModuleRadius.m.value),
            spreadColor: cardItem.bgColor(),
            child: child,
          )
        : child;
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

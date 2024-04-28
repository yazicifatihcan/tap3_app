import 'package:bb_example_app/features/card_actions_screen/controller/card_actions_controller.dart';
import 'package:bb_example_app/features/home_screen/view/home.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/managers/auth_handler.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/option_selection_bottom_sheet.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/qr_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:values/values.dart';

class CardActions extends StatelessWidget {
  const CardActions({required this.controller, super.key});

  final CardActionsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: const Text('View Card'),
      ),
      body: BaseView<CardActionsController>(
        loadingView: Center(
          child: Column(
            children: [
              const Spacer(),
              const LottieAssets().successAnimation.lottie(),
              const Spacer(),
              Expanded(
                flex: 10,
                child: Text(
                  'Scan succesfully completed.\nCard information is processing.',
                  style: context.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        controller: controller,
        child: Padding(
          padding: EdgeInsets.all(ModulePadding.l.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () => controller.cardItem != null
                    ? CardAnimation(
                        cardItem: controller.cardItem!,
                        onAnimationCompleted: () =>
                            controller.animationCompleted = true,
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(
                height: ModulePadding.xxl.value,
              ),
              Obx(
                () => Card(
                  color: context.secondary,
                  child: Padding(
                    padding: EdgeInsets.all(ModulePadding.xs.value),
                    child: Row(
                      children: [
                        Center(
                          child: QrImageView(
                            data: controller.cardItem!.adress,
                            size: 100,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: ModulePadding.xs.value,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.cardItem!.adress,
                                  style: context.titleMedium,
                                ),
                              ),
                              SizedBox(
                                width: ModulePadding.xs.value,
                              ),
                              CircleIconButton(
                                label: 'Copy',
                                onTap: controller.copyAdress,
                                icon: const IconAssets().copyIcon.svg(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    .slideAnimation(order: 1)
                    .isVisible(value: controller.animationCompleted),
              ),
              SizedBox(
                height: ModulePadding.m.value,
              ),
              Obx(
                () => Column(
                  children: [
                    TextWithIcon(
                      title: 'Add Card to Wallet',
                      icon: const IconAssets().discoverIcon.svg(),
                      onTap: controller.onTapAddCard,
                    ),
                    const Divider(
                      height: 32,
                    ),
                  ],
                ).slideAnimation(order: 1).isVisible(
                      value: controller.animationCompleted &&
                          !controller.isCardAlreadyExist(),
                    ),
              ),
              Obx(
                () => Column(
                  children: [
                    TextWithIcon(
                      title: 'Make Payment to Card',
                      icon: const IconAssets().discoverIcon.svg(),
                      onTap: controller.onTapAddMakePayment,
                    ),
                    const Divider(
                      height: 32,
                    ),
                  ],
                ).slideAnimation(order: 2).isVisible(
                      value: controller.animationCompleted &&
                          controller.sessionManager.userAuthStatus ==
                              UserAuthStatus.authorized,
                    ),
              ),
              Obx(
                () => Column(
                  children: [
                    TextWithIcon(
                      title: 'Open Explorer',
                      icon: const IconAssets().discoverIcon.svg(),
                      onTap: controller.onTapOpenExplorer,
                    ),
                    const Divider(
                      height: 32,
                    ),
                  ],
                ).slideAnimation(order: 3).isVisible(
                      value: controller.animationCompleted,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardAnimation extends StatefulWidget {
  const CardAnimation({
    required this.cardItem,
    this.onAnimationCompleted,
    super.key,
  });

  @override
  _CardAnimationState createState() => _CardAnimationState();

  final CardUIModel cardItem;
  final VoidCallback? onAnimationCompleted;
}

class _CardAnimationState extends State<CardAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _scaleBackAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust duration as needed
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _scaleAnimation = Tween<double>(
      begin: 0.2, // Initial scale of the card
      end: 1.5, // Final scale of the card
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5,
          curve: Curves.easeInOut), // Delay the card animation
    ));

    _scaleBackAnimation = Tween<double>(
      begin: 1.5, // Initial scale of the card when coming back
      end: 1.0, // Final scale of the card when coming back
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0,
          curve: Curves.easeInOut), // Scale back animation
    ));
    _controller
      ..forward()
      ..addListener(() {
        if (_controller.status == AnimationStatus.completed) {
          widget.onAnimationCompleted?.call();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value < 0.5
                ? _scaleAnimation.value
                : _scaleBackAnimation.value,
            child: Transform.translate(
              offset: Offset(0.0, -100.0 * (1 - _animation.value)),
              child: Transform.rotate(
                angle: _animation.value * 2 * 3.141,
                child: child,
              ),
            ),
          );
        },
        child: CreditCard(
          showNeon: true,
          cardItem: widget.cardItem,
          isSelected: true,
          maticPrice: SessionHandler.instance.matic.quotes!.usd!.price!,
        ),
      ),
    );
  }
}

// ignore_for_file: inference_failure_on_function_invocation

part of '../home.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            ModuleRadius.m.value,
          ),
        ),
        color: color ?? context.primary,
      ),
      child: AspectRatio(
        aspectRatio: 2 / 1.2,
        child: Padding(
          padding: EdgeInsets.all(ModulePadding.s.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(ModulePadding.m.value),
                    child: const IconAssets().top3Logo.svg(
                          fit: BoxFit.scaleDown,
                        ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ModulePadding.m.value,
                      right: ModulePadding.xxs.value,
                    ),
                    child: GestureDetector(
                        onTap: () {
                          _QrBottomSheet(context);
                        },
                        child: const IconAssets().qrIcon.svg()),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: ModulePadding.m.value,
                      top: ModulePadding.m.value,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _ShowMoreCupertino(context);
                      },
                      child: const IconAssets().moreIcon.svg(),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ModulePadding.s.value,
                ),
                child: Text(
                  '#0001',
                  style: context.titleLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ModulePadding.s.value,
                  vertical: ModulePadding.xxs.value,
                ),
                child: Text(
                  '#0xbb10...3a79',
                  style: context.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  }

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bb_example_app/features/home_screen/controller/home_controller.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:bb_example_app/product/utility/enums/module_radius_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:values/values.dart';

part '../view/components/action_card.dart';
part '../view/components/qr_bottom_sheet.dart';
part '../view/components/show_more_cupertino.dart';
part '../view/components/wallet_card.dart';

class Home extends StatelessWidget {
  const Home({
    required this.controller,
    super.key,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'My Wallet',
          style: context.titleLarge,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ModulePadding.s.value),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Scaffold(
                      body: QRView(
                        key: controller.qrKey,
                        onQRViewCreated: controller.onQRViewCreated,
                      ),
                    );
                  },
                );
              },
              child: Icon(
                Icons.qr_code_scanner_outlined,
                color: context.onSurface,
              ),
            ),
          ),
        ],
      ),
      body: BaseView<HomeController>(
        controller: controller,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(ModulePadding.s.value),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const WalletCard(),
                SizedBox(height: ModulePadding.xl.value),
                Row(
                  children: [
                    const ActionCard(
                      title: 'Pay',
                    ),
                    SizedBox(
                      width: ModulePadding.s.value,
                    ),
                    const ActionCard(
                      title: 'Discover',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 250,
                ),
                const Stack(
                  children: [
                    WalletCard(),
                    Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: WalletCard(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

part of '../home.dart';

Future<dynamic> _QrBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.9,
    ),
    showDragHandle: true,
    isScrollControlled: true,
    elevation: 0,
    context: context,
    builder: (context) => Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: context.onSurface,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'My QR Code',
          style: context.titleLarge,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(ModulePadding.s.value),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    ModuleRadius.s.value,
                  ),
                ),
                color: context.primary.withOpacity(0.2),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  ModulePadding.s.value,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning,
                      color: context.onSurface,
                    ),
                    SizedBox(width: ModulePadding.xxs.value),
                    const Flexible(
                      child: Text(
                        'Send only Bitcoin (BTC) to this adress. Sending any other coins may result in permanent loss.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ModulePadding.s.value),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.orange,
                ),
                SizedBox(
                  width: ModulePadding.xs.value,
                ),
                const Text('BTC'),
              ],
            ),
            SizedBox(height: ModulePadding.s.value),
            QrImageView(
              data: '1234567890',
              size: 200,
              backgroundColor: context.onSurface,
            ),
            SizedBox(
              height: ModulePadding.s.value,
            ),
            const Text(
              '0x7131CA84856767fjfh8sjhqak8s88848f8E696',
            ),
            SizedBox(
              height: ModulePadding.s.value,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: context.secondary,
                      child: Icon(
                        Icons.copy,
                        color: context.inversePrimary,
                      ),
                    ),
                    const Text('Copy'),
                  ],
                ),
                SizedBox(
                  width: ModulePadding.xxs.value,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: context.secondary,
                      child: Icon(
                        Icons.share,
                        color: context.inversePrimary,
                      ),
                    ),
                    const Text('Copy'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

part of '../home.dart';

Future<dynamic> _ShowMoreCupertino(BuildContext context) {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: const Text('Choose an option'),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text('Set card as new wallet'),
          onPressed: () {
            context.pop();
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Show private key'),
          onPressed: () {
            context.pop();
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Change password'),
          onPressed: () {
            context.pop();
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDestructiveAction: true,
        onPressed: () {
          context.pop();
        },
        child: const Text('Wipe the card'),
      ),
    ),
  );
}

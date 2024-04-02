part of '../dashboard.dart';

class _CharacterCard extends StatelessWidget {
  const _CharacterCard({
    required this.item,
  });

  final Result item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(ModulePadding.s.value),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: cachedImageProvider(item.image!),
              radius: 50,
            ),
            SizedBox(height: ModulePadding.s.value),
            Text(
              item.name ?? context.i10n.unknown,
              style: context.labelMedium.copyWith(
                color: context.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

part of '../home.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: context.secondary,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: ModulePadding.s.value,
          ),
          child: Column(
            children: [
              Icon(
                Icons.credit_card,
                color: context.onInverseSurface,
              ),
              Text(
                title,
                style: context.bodyMedium.copyWith(
                  color: context.onInverseSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

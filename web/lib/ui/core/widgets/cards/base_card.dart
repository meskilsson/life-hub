import 'package:flutter/material.dart';

enum CardVariant { standard, primary, secondary, image, ghost, danger }

class BaseCard extends StatelessWidget {
  const BaseCard({
    super.key,
    this.widget,
    this.title,
    this.variant = CardVariant.standard,
    this.onTap,
    this.padding = const EdgeInsets.all(24),
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final Widget? widget;
  final String? title;
  final CardVariant variant;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final backgroundColor = switch (variant) {
      CardVariant.standard => colors.surfaceContainerLow,
      CardVariant.primary => colors.primaryContainer,
      CardVariant.secondary => colors.secondaryContainer,
      CardVariant.image => colors.surface,
      CardVariant.ghost => Colors.transparent,
      CardVariant.danger => colors.errorContainer,
    };

    final foregroundColor = switch (variant) {
      CardVariant.standard => colors.onSurface,
      CardVariant.primary => colors.onPrimaryContainer,
      CardVariant.secondary => colors.onSecondaryContainer,
      CardVariant.image => colors.onSurface,
      CardVariant.ghost => colors.onSurface,
      CardVariant.danger => colors.onErrorContainer,
    };

    return Card(
      color: backgroundColor,
      clipBehavior: Clip.antiAlias,
      elevation: variant == CardVariant.ghost ? 0 : null,
      surfaceTintColor: variant == CardVariant.ghost
          ? Colors.transparent
          : null,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: DefaultTextStyle.merge(
            style: TextStyle(color: foregroundColor),
            child: IconTheme.merge(
              data: IconThemeData(color: foregroundColor),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  if (title != null) ...[
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(color: foregroundColor),
                    ),
                    if (widget != null) const SizedBox(height: 12),
                  ],
                  ?widget,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

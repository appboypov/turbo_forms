import 'package:flutter/material.dart';
import 'package:turbo_widgets/turbo_widgets.dart';

/// An error label widget that animates in/out based on validation state.
class TurboErrorLabel extends StatelessWidget {
  const TurboErrorLabel({
    super.key,
    required this.errorText,
    required this.shouldValidate,
    this.padding,
  });

  final String? errorText;
  final bool shouldValidate;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TurboVerticalShrink(
      alignment: Alignment.bottomCenter,
      fadeDuration: turboDurationsAnimationX0p5,
      sizeDuration: turboDurationsAnimationX0p5,
      show: shouldValidate && (errorText?.isNotEmpty == true),
      child: Padding(
        padding: padding ?? const EdgeInsets.only(bottom: 4, left: 8, top: 8),
        child: Row(
          children: [
            Flexible(
              child: Text(
                errorText ?? '',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

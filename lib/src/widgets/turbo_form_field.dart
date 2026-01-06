import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turbo_widgets/turbo_widgets.dart';
import '../config/turbo_form_field_config.dart';
import '../typedefs/turbo_form_field_builder_def.dart';
import 'turbo_error_label.dart';
import 'turbo_form_field_builder.dart';

class TurboFormField<T> extends StatelessWidget {
  const TurboFormField({
    super.key,
    required this.builder,
    required this.formFieldConfig,
    this.child,
    this.errorPadding,
    this.label,
    this.labelIcon,
    this.description,
    this.labelTrailing,
    this.horizontalPadding,
  });

  final String? label;
  final IconData? labelIcon;
  final String? description;
  final Widget? labelTrailing;
  final TurboFormFieldBuilderDef<T> builder;
  final TurboFormFieldConfig<T> formFieldConfig;
  final Widget? child;
  final EdgeInsets? errorPadding;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: formFieldConfig,
    builder: (context, listenableChild) {
      return _StatelessTurboFormField(
        horizontalPadding: horizontalPadding,
        label: label,
        labelIcon: labelIcon,
        description: description,
        labelTrailing: labelTrailing,
        errorPadding: errorPadding,
        errorText: formFieldConfig.errorText,
        shouldValidate: formFieldConfig.shouldValidate,
        isEnabled: formFieldConfig.isEnabled,
        isReadOnly: formFieldConfig.isReadOnly,
        formFieldContent: TurboFormFieldBuilder(
          fieldConfig: formFieldConfig,
          builder: builder,
          child: child,
        ),
      );
    },
  );
}

class _StatelessTurboFormField extends StatelessWidget {
  const _StatelessTurboFormField({
    this.label,
    this.labelIcon,
    this.description,
    this.labelTrailing,
    this.errorPadding,
    this.errorText,
    required this.shouldValidate,
    required this.isEnabled,
    required this.isReadOnly,
    required this.formFieldContent,
    this.horizontalPadding,
  });

  final String? label;
  final IconData? labelIcon;
  final String? description;
  final Widget? labelTrailing;
  final EdgeInsets? errorPadding;
  final String? errorText;
  final bool shouldValidate;
  final bool isEnabled;
  final bool isReadOnly;
  final Widget formFieldContent;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formFieldSubLabelStyle = theme.textTheme.bodySmall;
    final subLabel = description;

    return AnimatedOpacity(
      duration: turboDurationsAnimation,
      opacity: isEnabled ? 1 : 0.3,
      child: IgnorePointer(
        ignoring: !isEnabled || isReadOnly,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (label != null || subLabel != null || labelTrailing != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (horizontalPadding != null) TurboGap(horizontalPadding!),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (label != null) ...[
                          if (labelIcon != null)
                            Row(
                              children: [
                                Icon(labelIcon, size: 16),
                                const Gap(4),
                                Text(
                                  label!,
                                  style: theme.textTheme.labelMedium,
                                ),
                              ],
                            )
                          else
                            Text(label!, style: theme.textTheme.labelMedium),
                        ],
                        if (subLabel == null)
                          const Gap(4)
                        else ...[
                          if (label != null) const Gap(4),
                          Text(subLabel, style: formFieldSubLabelStyle),
                        ],
                      ],
                    ),
                  ),
                  if (labelTrailing != null) ...[
                    if (label != null || subLabel != null) const Gap(8),
                    labelTrailing!,
                    const Gap(8),
                  ],
                  if (horizontalPadding != null) TurboGap(horizontalPadding!),
                ],
              ),
              const Gap(6),
            ],
            formFieldContent,
            TurboErrorLabel(
              errorText: errorText,
              shouldValidate: shouldValidate,
              padding: errorPadding,
            ),
          ],
        ),
      ),
    );
  }
}

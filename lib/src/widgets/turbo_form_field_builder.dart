import 'package:flutter/material.dart';
import '../config/turbo_form_field_config.dart';
import '../typedefs/turbo_form_field_builder_def.dart';

class TurboFormFieldBuilder<T> extends StatelessWidget {
  const TurboFormFieldBuilder({
    super.key,
    required this.fieldConfig,
    required this.builder,
    this.child,
  });

  final TurboFormFieldConfig<T> fieldConfig;
  final TurboFormFieldBuilderDef<T> builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: fieldConfig,
    builder: (context, value, child) =>
        builder(context, fieldConfig, this.child ?? child),
    child: child,
  );
}

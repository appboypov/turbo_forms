import 'package:flutter/widgets.dart';
import '../config/turbo_form_field_config.dart';

typedef TurboFormFieldBuilderDef<T> = Widget Function(
  BuildContext context,
  TurboFormFieldConfig<T> fieldConfig,
  Widget? child,
);

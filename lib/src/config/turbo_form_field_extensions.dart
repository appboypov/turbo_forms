part of 'turbo_form_field_config.dart';

extension TurboFormFieldConfigStringExtension on TurboFormFieldConfig<String> {
  bool get valueTrimIsEmpty => value.value?.turboTrimIsEmpty ?? true;
}

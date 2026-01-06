import 'package:flutter/foundation.dart';
import '../config/turbo_form_field_config.dart';

enum TurboCrudState { create, update }

abstract class TurboFormConfig<T> {
  late T? _initialDto;
  T? get initialDto => _initialDto;

  @protected
  Map<Enum, TurboFormFieldConfig> get formFieldConfigs;

  TurboFormFieldConfig<T> formFieldConfig<T>(Enum id) =>
      formFieldConfigs[id] as TurboFormFieldConfig<T>;

  bool get isValid {
    bool formIsValid = true;
    for (final formFieldConfig in formFieldConfigs.values) {
      if (formFieldConfig.isEnabled && formFieldConfig.isVisible) {
        if (!formFieldConfig.isValid && formIsValid) formIsValid = false;
      }
    }
    return formIsValid;
  }

  void dispose() {
    for (final formFieldConfig in formFieldConfigs.values) {
      formFieldConfig.dispose();
    }
  }
}

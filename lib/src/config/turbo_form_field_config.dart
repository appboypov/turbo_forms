import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:turbo_notifiers/turbo_notifiers.dart';
import 'package:turbolytics/turbolytics.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:turbo_widgets/turbo_widgets.dart';

import '../enums/turbo_field_type.dart';
import '../typedefs/turbo_values_validator_def.dart';

part 'turbo_form_field_extensions.dart';
part 'turbo_form_field_state.dart';

class TurboFormFieldConfig<T> extends TurboNotifier<TurboFormFieldState<T>>
    with Turbolytics {
  TurboFormFieldConfig({
    FormFieldValidator<T>? valueValidator,
    List<T>? initialValues,
    List<T>? items,
    List<TextInputFormatter>? inputFormatters,
    List<String>? autoCompleteValues,
    T? initialValue,
    TurboValuesValidatorDef<T>? valuesValidator,
    bool isEnabled = true,
    bool isReadOnly = false,
    bool isVisible = true,
    bool obscureText = false,
    required TurboFieldType fieldType,
    required Object id,
    num incrementAmount = 1,
    String Function(T value)? labelBuilder,
    num maxValue = double.maxFinite,
    num minValue = 0,
    FocusNode? focusNode,
    ShadTextEditingController? textEditingController,
    ShadSelectController<T>? selectController,
    ShadTimePickerController? timePickerController,
    ShadSliderController? sliderController,
    List<String> currentSuggestions = const [],
  }) : super(
         TurboFormFieldState<T>(
           valueValidator: valueValidator,
           initialValues: initialValues,
           items: items,
           values: null,
           inputFormatters: inputFormatters,
           autoCompleteValues: autoCompleteValues,
           initialValue: initialValue,
           value: initialValue,
           valuesValidator: valuesValidator,
           isEnabled: isEnabled,
           isReadOnly: isReadOnly,
           isVisible: isVisible,
           obscureText: obscureText,
           fieldType: fieldType,
           id: id,
           incrementAmount: incrementAmount,
           maxValue: maxValue,
           minValue: minValue,
           labelBuilder: labelBuilder,
           errorText: null,
           shouldValidate: false,
           textEditingController:
               textEditingController ??
               ((fieldType.hasTextEditingController)
                   ? ShadTextEditingController(text: initialValue?.toString())
                   : null),
           sliderController:
               sliderController ??
               (fieldType.hasSliderController
                   ? ShadSliderController(
                       initialValue: initialValue?.turboAsType() ?? 0,
                     )
                   : null),
           timePickerController:
               timePickerController ??
               (fieldType.hasTimePickerController
                   ? ShadTimePickerController(
                       hour:
                           initialValue?.turboAsType<ShadTimeOfDay>().hour ?? 0,
                       minute:
                           initialValue?.turboAsType<ShadTimeOfDay>().minute ??
                           0,
                       period: initialValue
                           ?.turboAsType<ShadTimeOfDay>()
                           .period,
                       second:
                           initialValue?.turboAsType<ShadTimeOfDay>().second ??
                           0,
                     )
                   : null),
           selectController:
               selectController ??
               (fieldType.hasSelectController
                   ? ShadSelectController<T>(
                       initialValue: initialValues?.toSet(),
                     )
                   : null),
           focusNode: focusNode ?? FocusNode(),
           currentSuggestions: currentSuggestions,
         ),
       );

  @override
  void dispose() {
    log.info('Disposing $fieldType with id: ${value.id}..');
    value.textEditingController?.dispose();
    value.selectController?.dispose();
    value.focusNode.dispose();
    super.dispose();
    log.info('Disposed $fieldType with id: ${value.id}!');
  }

  List<String> get currentSuggestions => value.currentSuggestions;

  num get minValue => value.minValue;
  num get maxValue => value.maxValue;

  bool get isNotValid => !isValid;

  bool get isValidSilent {
    final errorText = switch (fieldType) {
      TurboFieldType.textInput => value.valueValidator?.call(value.value),
      TurboFieldType.select => value.valueValidator?.call(value.value),
      TurboFieldType.checkbox => value.valueValidator?.call(value.value),
      TurboFieldType.cameraPath => value.valueValidator?.call(value.value),
      TurboFieldType.colorPicker => value.valueValidator?.call(value.value),
      TurboFieldType.datePicker => value.valueValidator?.call(value.value),
      TurboFieldType.dateRangePicker => value.valueValidator?.call(value.value),
      TurboFieldType.filePickerPath => value.valueValidator?.call(value.value),
      TurboFieldType.numberInput => value.valueValidator?.call(value.value),
      TurboFieldType.phoneInput => value.valueValidator?.call(value.value),
      TurboFieldType.radioCard => value.valueValidator?.call(value.value),
      TurboFieldType.radioGroup => value.valueValidator?.call(value.value),
      TurboFieldType.selectMulti => value.valuesValidator?.call(value.values),
      TurboFieldType.sizeSelector => value.valueValidator?.call(value.value),
      TurboFieldType.slider => value.valueValidator?.call(value.value),
      TurboFieldType.starRating => value.valueValidator?.call(value.value),
      TurboFieldType.textArea => value.valueValidator?.call(value.value),
      TurboFieldType.timePicker => value.valueValidator?.call(value.value),
      TurboFieldType.toggleGroup => value.valueValidator?.call(value.value),
      TurboFieldType.toggleSwitch => value.valueValidator?.call(value.value),
    };
    return errorText == null;
  }

  bool get isValid {
    if (!value.shouldValidate) {
      update(value.copyWith(shouldValidate: true));
    }
    final errorText = switch (fieldType) {
      TurboFieldType.textInput => value.valueValidator?.call(value.value),
      TurboFieldType.select => value.valueValidator?.call(value.value),
      TurboFieldType.checkbox => value.valueValidator?.call(value.value),
      TurboFieldType.cameraPath => value.valueValidator?.call(value.value),
      TurboFieldType.colorPicker => value.valueValidator?.call(value.value),
      TurboFieldType.datePicker => value.valueValidator?.call(value.value),
      TurboFieldType.dateRangePicker => value.valueValidator?.call(value.value),
      TurboFieldType.filePickerPath => value.valueValidator?.call(value.value),
      TurboFieldType.numberInput => value.valueValidator?.call(value.value),
      TurboFieldType.phoneInput => value.valueValidator?.call(value.value),
      TurboFieldType.radioCard => value.valueValidator?.call(value.value),
      TurboFieldType.radioGroup => value.valueValidator?.call(value.value),
      TurboFieldType.selectMulti => value.valuesValidator?.call(value.values),
      TurboFieldType.sizeSelector => value.valueValidator?.call(value.value),
      TurboFieldType.slider => value.valueValidator?.call(value.value),
      TurboFieldType.starRating => value.valueValidator?.call(value.value),
      TurboFieldType.textArea => value.valueValidator?.call(value.value),
      TurboFieldType.timePicker => value.valueValidator?.call(value.value),
      TurboFieldType.toggleGroup => value.valueValidator?.call(value.value),
      TurboFieldType.toggleSwitch => value.valueValidator?.call(value.value),
    };
    update(value.copyWith(errorText: errorText, forceUpdate: true));
    final isValid = errorText == null;
    log.info('Checking if $fieldType with id: ${value.id} is valid: $isValid!');
    return isValid;
  }

  ShadTextEditingController? get textEditingController =>
      value.textEditingController;
  ShadSelectController<T>? get selectController => value.selectController;
  ShadTimePickerController? get timePickerController =>
      value.timePickerController;
  ShadSliderController? get sliderController => value.sliderController;
  FocusNode get focusNode => value.focusNode;
  FormFieldValidator<T>? get validator => value.valueValidator;
  List<String>? get autoCompleteValues => value.autoCompleteValues;
  List<T>? get initialValues => value.initialValues;
  List<T>? get items => value.items;
  List<T>? get values => value.values;
  List<TextInputFormatter>? get inputFormatters => value.inputFormatters;
  Set<T> get valuesAsSet => values?.toSet() ?? {};
  String? get errorText => value.errorText;
  T? get cValue => value.value;
  T? get initialValue => value.initialValue;
  TurboFieldType get fieldType => value.fieldType;
  TurboValuesValidatorDef<T>? get valuesValidator => value.valuesValidator;
  bool get didChange => value.value != value.initialValue;
  bool get hasFocus => value.focusNode.hasFocus;
  bool get isEnabled => value.isEnabled;
  bool get isReadOnly => value.isReadOnly;
  bool get isVisible => value.isVisible;
  bool get obscureText => value.obscureText;
  bool get shouldValidate => value.shouldValidate;

  double? get valueAsDouble {
    final localValue = cValue;
    if (localValue is String?) {
      return localValue?.turboTryAsDouble;
    }
    return null;
  }

  int? get valueAsInt {
    final localValue = cValue;
    if (localValue is String?) {
      return localValue?.turboTryAsInt;
    }
    return null;
  }

  void _updateTextEditingController(String rTextValue) {
    final trimmed = rTextValue.trim();
    final tryParse = double.tryParse(trimmed);
    final isNumber = tryParse != null;
    final String pValue;
    if (isNumber) {
      final bool hasDecimals = tryParse.turboHasDecimals;
      pValue = hasDecimals ? trimmed : tryParse.toInt().toString();
    } else {
      pValue = trimmed;
    }

    final textEditingController = value.textEditingController;
    final oldCursorPos = textEditingController!.selection.baseOffset;
    final oldTextLength = textEditingController.text.length;

    textEditingController.text = pValue;

    int newCursorPos = oldCursorPos;
    if (pValue.length > oldTextLength) {
      newCursorPos = pValue.length;
    } else if (pValue.length < oldTextLength) {
      newCursorPos -= 1;
    }

    newCursorPos = newCursorPos.clamp(0, pValue.length);

    textEditingController.selection = TextSelection.fromPosition(
      TextPosition(offset: newCursorPos),
    );
  }

  void _tryValidate() {
    if (value.shouldValidate) {
      isValid;
    }
  }

  void _resetShouldValidate() {
    update(value.copyWith(shouldValidate: false, errorText: null));
  }

  void updateValues(List<T>? newValues) {
    update(value.copyWith(values: newValues));
    _tryValidate();
    log.info('Set values to $newValues for $fieldType with id: ${value.id}!');
  }

  void updateValue(T? value) {
    update(this.value.copyWith(value: value));
    if (fieldType.hasTextEditingController) {
      _updateTextEditingController(value?.toString() ?? '');
    }
    _tryValidate();
    log.info('Set value to $value for $fieldType with id: ${this.value.id}!');
  }

  void resetSuggestions() => update(value.copyWith(currentSuggestions: []));

  void updateSuggestions(String value) {
    if (value.isEmpty || autoCompleteValues == null) {
      if (currentSuggestions.isEmpty) return;
      updateCurrent((value) => value.copyWith(currentSuggestions: []));
      return;
    }
    updateCurrent((cValue) {
      final currentSuggestions =
          autoCompleteValues
              ?.where(
                (element) => element.turboNaked.contains(value.turboNaked),
              )
              .toList() ??
          [];
      return cValue.copyWith(currentSuggestions: currentSuggestions);
    });
  }

  void requestFocus() {
    value.focusNode.requestFocus();
    if (fieldType.hasTextEditingController) {
      textEditingController!.selection = TextSelection(
        baseOffset: 0,
        extentOffset: textEditingController!.text.length,
      );
    }
    log.info('Requested focus for $fieldType with id: ${value.id}!');
  }

  void unfocus() => value.focusNode.unfocus();

  void silentReset() {
    _resetShouldValidate();

    if (fieldType.hasTextEditingController) {
      _updateTextEditingController(value.initialValue?.toString() ?? '');
    }
    if (fieldType.hasSelectController) {
      selectController!.value = (value.initialValues ?? []).toSet();
    }

    if (fieldType.isSingleValue) {
      update(value.copyWith(value: value.initialValue));
    } else {
      update(value.copyWith(values: value.initialValues));
    }

    log.info('Reset $fieldType with id: ${value.id}!');
  }

  void silentUpdateValue(T? newValue) {
    update(value.copyWith(value: newValue));
    _tryValidate();
  }

  void silentUpdateValues(List<T>? newValues) {
    update(value.copyWith(values: newValues));
    _tryValidate();
  }

  void updateCurrentValue(T? Function(T? value) current) {
    if (fieldType.hasTextEditingController) {
      _updateTextEditingController(current(cValue)?.toString() ?? '');
    }
    update(value.copyWith(value: current(cValue)));
  }

  void updateCurrentValues(List<T>? Function(List<T>? values) current) {
    if (fieldType.hasSelectController) {
      selectController!.value = (current(values) ?? []).toSet();
    }
    update(value.copyWith(values: current(values)));
  }

  void addValue(T newValue) => updateCurrentValues(
    (values) => values == null ? [newValue] : [...values, newValue],
  );

  void removeValue(T valueToRemove) => updateCurrentValues(
    (values) => values?.where((v) => v != valueToRemove).toList(),
  );

  void updateInitialValue(T? newValue) {
    update(value.copyWith(initialValue: newValue, value: newValue));
    if (fieldType.hasTextEditingController) {
      if (textEditingController!.value.text.trim().isEmpty) {
        value.textEditingController!.text = newValue?.toString() ?? '';
      }
    }
    _tryValidate();
    log.info(
      'Set initialValue to $newValue for $fieldType with id: ${value.id}!',
    );
  }

  void updateInitialValues(List<T>? newValues) {
    update(value.copyWith(initialValues: newValues, values: newValues));
    if (fieldType.hasSelectController) {
      if (selectController!.value.isEmpty) {
        selectController!.value = (newValues ?? []).toSet();
      }
    }
    _tryValidate();
    log.info(
      'Set initialValues to $newValues for $fieldType with id: ${value.id}!',
    );
  }

  void updateItems(List<T>? newItems) {
    update(value.copyWith(items: newItems));
    _tryValidate();
    log.info('Set items to $newItems for $fieldType with id: ${value.id}!');
  }

  void updateIsReadOnly(bool newValue) {
    update(value.copyWith(isReadOnly: newValue));
    if (newValue) {
      _tryValidate();
    } else {
      _resetShouldValidate();
    }
    log.info(
      'Set isReadOnly to $newValue for $fieldType with id: ${value.id}!',
    );
  }

  void updateIsVisible(bool newValue) {
    update(value.copyWith(isVisible: newValue));
    if (newValue) {
      _tryValidate();
    } else {
      _resetShouldValidate();
    }
    log.info('Set isVisible to $newValue for $fieldType with id: ${value.id}!');
  }

  void updateIsEnabled(bool newValue) {
    update(value.copyWith(isEnabled: newValue));
    if (newValue) {
      _tryValidate();
    } else {
      _resetShouldValidate();
    }
    log.info('Set isEnabled to $newValue for $fieldType with id: ${value.id}!');
  }

  void updateInputFormatters(List<TextInputFormatter>? newValue) {
    update(value.copyWith(inputFormatters: newValue));
    _tryValidate();
    log.info(
      'Set inputFormatters to $newValue for $fieldType with id: ${value.id}!',
    );
  }

  void updateObscureText(bool newValue) {
    update(value.copyWith(obscureText: newValue));
    _tryValidate();
    log.info(
      'Set obscureText to $newValue for $fieldType with id: ${value.id}!',
    );
  }
}

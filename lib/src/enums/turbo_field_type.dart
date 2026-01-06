enum TurboFieldType {
  cameraPath,
  checkbox,
  colorPicker,
  datePicker,
  dateRangePicker,
  filePickerPath,
  numberInput,
  phoneInput,
  radioCard,
  radioGroup,
  select,
  selectMulti,
  sizeSelector,
  slider,
  starRating,
  textArea,
  textInput,
  timePicker,
  toggleGroup,
  toggleSwitch;

  bool get hasTimePickerController {
    switch (this) {
      case TurboFieldType.cameraPath:
      case TurboFieldType.checkbox:
      case TurboFieldType.colorPicker:
      case TurboFieldType.datePicker:
      case TurboFieldType.dateRangePicker:
      case TurboFieldType.filePickerPath:
      case TurboFieldType.numberInput:
      case TurboFieldType.phoneInput:
      case TurboFieldType.radioCard:
      case TurboFieldType.radioGroup:
      case TurboFieldType.select:
      case TurboFieldType.selectMulti:
      case TurboFieldType.sizeSelector:
      case TurboFieldType.slider:
      case TurboFieldType.starRating:
      case TurboFieldType.textArea:
      case TurboFieldType.textInput:
        return false;
      case TurboFieldType.timePicker:
        return true;
      case TurboFieldType.toggleGroup:
      case TurboFieldType.toggleSwitch:
        return false;
    }
  }

  bool get hasSliderController {
    switch (this) {
      case TurboFieldType.cameraPath:
      case TurboFieldType.checkbox:
      case TurboFieldType.colorPicker:
      case TurboFieldType.datePicker:
      case TurboFieldType.dateRangePicker:
      case TurboFieldType.filePickerPath:
      case TurboFieldType.numberInput:
      case TurboFieldType.phoneInput:
      case TurboFieldType.radioCard:
      case TurboFieldType.radioGroup:
      case TurboFieldType.select:
      case TurboFieldType.selectMulti:
      case TurboFieldType.sizeSelector:
        return false;
      case TurboFieldType.slider:
        return true;
      case TurboFieldType.starRating:
      case TurboFieldType.textArea:
      case TurboFieldType.textInput:
      case TurboFieldType.timePicker:
      case TurboFieldType.toggleGroup:
      case TurboFieldType.toggleSwitch:
        return false;
    }
  }

  bool get isSingleValue {
    switch (this) {
      case TurboFieldType.cameraPath:
      case TurboFieldType.checkbox:
      case TurboFieldType.colorPicker:
      case TurboFieldType.datePicker:
      case TurboFieldType.dateRangePicker:
      case TurboFieldType.filePickerPath:
      case TurboFieldType.numberInput:
      case TurboFieldType.phoneInput:
        return true;
      case TurboFieldType.radioCard:
      case TurboFieldType.radioGroup:
      case TurboFieldType.select:
      case TurboFieldType.selectMulti:
        return false;
      case TurboFieldType.sizeSelector:
      case TurboFieldType.slider:
      case TurboFieldType.starRating:
      case TurboFieldType.textArea:
      case TurboFieldType.textInput:
      case TurboFieldType.timePicker:
      case TurboFieldType.toggleGroup:
      case TurboFieldType.toggleSwitch:
        return true;
    }
  }

  bool get hasSelectController {
    switch (this) {
      case TurboFieldType.cameraPath:
      case TurboFieldType.checkbox:
      case TurboFieldType.colorPicker:
      case TurboFieldType.datePicker:
      case TurboFieldType.dateRangePicker:
      case TurboFieldType.filePickerPath:
      case TurboFieldType.numberInput:
      case TurboFieldType.phoneInput:
        return false;
      case TurboFieldType.radioCard:
      case TurboFieldType.radioGroup:
      case TurboFieldType.select:
      case TurboFieldType.selectMulti:
        return true;
      case TurboFieldType.sizeSelector:
      case TurboFieldType.slider:
      case TurboFieldType.starRating:
      case TurboFieldType.textArea:
      case TurboFieldType.textInput:
      case TurboFieldType.timePicker:
      case TurboFieldType.toggleGroup:
      case TurboFieldType.toggleSwitch:
        return false;
    }
  }

  bool get hasTextEditingController {
    switch (this) {
      case TurboFieldType.cameraPath:
      case TurboFieldType.checkbox:
      case TurboFieldType.colorPicker:
      case TurboFieldType.datePicker:
      case TurboFieldType.dateRangePicker:
      case TurboFieldType.filePickerPath:
        return false;
      case TurboFieldType.numberInput:
      case TurboFieldType.phoneInput:
        return true;
      case TurboFieldType.radioCard:
      case TurboFieldType.radioGroup:
      case TurboFieldType.select:
      case TurboFieldType.selectMulti:
      case TurboFieldType.sizeSelector:
      case TurboFieldType.slider:
      case TurboFieldType.starRating:
        return false;
      case TurboFieldType.textArea:
      case TurboFieldType.textInput:
        return true;
      case TurboFieldType.timePicker:
      case TurboFieldType.toggleGroup:
      case TurboFieldType.toggleSwitch:
        return false;
    }
  }
}

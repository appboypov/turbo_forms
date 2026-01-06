# 📝 Turbo Forms

[![Pub Version](https://img.shields.io/pub/v/turbo_forms?logo=dart&label=turbo_forms)](https://pub.dev/packages/turbo_forms)
[![License: BSD-3-Clause](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![GitHub Stars](https://img.shields.io/github/stars/appboypov/turbo_forms?style=social)](https://github.com/appboypov/turbo_forms)

**Turbo Forms** is a comprehensive form configuration and validation system for Flutter applications. It provides a type-safe, reactive approach to building and managing forms with built-in validation, state management, and UI components.

## Features

- **Type-Safe Forms**: Strongly typed form fields with generic support
- **Reactive State Management**: Built on `turbo_notifiers` for reactive form state
- **Built-in Validators**: Common validators for email, required fields, and more
- **Custom Validators**: Easy-to-create custom validation logic
- **Multiple Field Types**: Support for text input, select, checkbox, color picker, and more
- **Form Field Builders**: Flexible widget builders for custom UI rendering

## Installation

Add `turbo_forms` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  turbo_forms: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

```dart
import 'package:turbo_forms/turbo_forms.dart';

// Create a form field configuration
final emailField = TurboFormFieldConfig<String>(
  fieldType: TurboFieldType.textInput,
  id: 'email',
  valueValidator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!EmailValidator.validate(value)) {
      return 'Invalid email format';
    }
    return null;
  },
);

// Use in a widget
TurboFormField<String>(
  fieldConfig: emailField,
  builder: (context, fieldConfig, child) {
    return TextFormField(
      onChanged: (value) => fieldConfig.update(value),
      validator: fieldConfig.value.valueValidator,
    );
  },
)
```

## Example

Check the `/example` directory for a complete Flutter application demonstrating Turbo Forms features.

## Contributing

Contributions are welcome! Please open issues or pull requests on our [GitHub repository](https://github.com/appboypov/turbo_forms).

## License

This package is licensed under the BSD 3-Clause License. See the [LICENSE](LICENSE) file for details.

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:turbo_widgets/turbo_widgets.dart';
import '../typedefs/turbo_values_validator_def.dart';

/// Combines multiple validators, returning the first error found.
FormFieldValidator turboValueValidatorsMultiple(
  List<FormFieldValidator> validators,
) => (valueCandidate) {
  for (final validator in validators) {
    final validatorResult = validator.call(valueCandidate);
    if (validatorResult != null) {
      return validatorResult;
    }
  }
  return null;
};

/// Validates that a boolean value is true.
FormFieldValidator<T> turboValueValidatorsIsTrue<T>({
  required TurboLazyLocatorDef<String> errorText,
}) {
  return (T? valueCandidate) {
    if (valueCandidate is bool && valueCandidate) {
      return null;
    }
    return errorText();
  };
}

/// Validates that a value is a valid number.
FormFieldValidator<T> turboValueValidatorsIsValidNumber<T>({
  required TurboLazyLocatorDef<String> errorText,
}) {
  return (T? valueCandidate) {
    if (valueCandidate is num) return null;
    if (valueCandidate is String) {
      final normalized = valueCandidate.replaceAll(',', '.');
      if (num.tryParse(normalized) != null) return null;
    }
    return errorText();
  };
}

/// Validates that a numeric value does not exceed a maximum count.
FormFieldValidator<T> turboValueValidatorsMaxCount<T>({
  required double count,
  required TurboLazyLocatorDef<String> errorText,
}) {
  return (T? valueCandidate) {
    if (valueCandidate is double && valueCandidate > count) {
      return errorText();
    }
    if (valueCandidate is num && valueCandidate > count) {
      return errorText();
    }
    if (valueCandidate is String) {
      final numValue = double.tryParse(valueCandidate);
      if (numValue != null && numValue > count) {
        return errorText();
      }
    }
    return null;
  };
}

/// Validates that a numeric value meets a minimum count.
FormFieldValidator<T> turboValueValidatorsMinCount<T>({
  required double count,
  required TurboLazyLocatorDef<String> errorText,
}) {
  return (T? valueCandidate) {
    if (valueCandidate is double && valueCandidate < count) {
      return errorText();
    }
    if (valueCandidate is num && valueCandidate < count) {
      return errorText();
    }
    if (valueCandidate is String) {
      final normalized = valueCandidate.replaceAll(',', '.');
      final numValue = double.tryParse(normalized);
      if (numValue != null && numValue < count) {
        return errorText();
      }
    }
    return null;
  };
}

/// Validates that a value is not null or empty.
FormFieldValidator<T> turboValueValidatorsRequired<T>({
  required TurboLazyLocatorDef<String> errorText,
}) {
  return (T? valueCandidate) {
    if (valueCandidate == null ||
        (valueCandidate is String && valueCandidate.trim().isEmpty) ||
        (valueCandidate is Iterable && valueCandidate.isEmpty) ||
        (valueCandidate is Map && valueCandidate.isEmpty)) {
      return errorText();
    }
    return null;
  };
}

/// Validates that a string is a valid email address.
FormFieldValidator<T> turboValueValidatorsEmail<T>({
  required TurboLazyLocatorDef<String> errorText,
}) {
  return (T? valueCandidate) {
    String? errorMessage;
    errorMessage =
        valueCandidate is String && EmailValidator.validate(valueCandidate)
        ? null
        : errorText();
    return errorMessage;
  };
}

/// Validates that a string or iterable does not exceed a maximum length.
FormFieldValidator<T> turboValueValidatorsMaxLength<T>({
  required int length,
  required TurboLazyLocatorDef<String> errorText,
}) {
  assert(length > 0);
  return (T? valueCandidate) {
    assert(
      valueCandidate is String ||
          valueCandidate is Iterable ||
          valueCandidate == null,
    );
    var valueLength = 0;
    if (valueCandidate is String) valueLength = valueCandidate.length;
    if (valueCandidate is Iterable) valueLength = valueCandidate.length;
    return null != valueCandidate && valueLength > length ? errorText() : null;
  };
}

/// Validates that a string does not contain profanity.
FormFieldValidator<T> turboValueValidatorsNoProfanity<T>({
  required List<String> profanityWords,
  required TurboLazyLocatorDef<String> errorText,
}) {
  return (T? valueCandidate) {
    if (valueCandidate is String) {
      for (final word in profanityWords) {
        if (valueCandidate.toLowerCase().contains(word.toLowerCase())) {
          return errorText();
        }
      }
    }
    return null;
  };
}

/// Validates that a string or iterable meets a minimum length.
FormFieldValidator<T> turboValueValidatorsMinLength<T>({
  required int minLength,
  required TurboLazyLocatorDef<String> errorText,
}) {
  return (T? valueCandidate) {
    assert(
      valueCandidate is String ||
          valueCandidate is Iterable ||
          valueCandidate == null,
    );
    var valueLength = 0;
    if (valueCandidate is String) {
      valueLength = valueCandidate.length;
    }
    if (valueCandidate is Iterable) valueLength = valueCandidate.length;
    return null == valueCandidate || valueLength < minLength
        ? errorText()
        : null;
  };
}

/// Validates that a value equals another value.
FormFieldValidator<T> turboValueValidatorsEquals<T>(
  T? Function() other, {
  required TurboLazyLocatorDef<String> errorText,
}) =>
    (T? valueCandidate) => valueCandidate != other() ? errorText() : null;

/// Validates that a string is a valid phone number.
FormFieldValidator<T> turboValueValidatorsPhone<T>({
  required TurboLazyLocatorDef<String> errorText,
}) {
  return (T? valueCandidate) {
    if (valueCandidate is String) {
      final cleanedPhone = valueCandidate.replaceAll(RegExp(r'[\s\-()]'), '');
      if (RegExp(r'^(\+)?[0-9]{10,15}$').hasMatch(cleanedPhone)) {
        return null;
      }
    }
    return errorText();
  };
}

/// Validates that a string is a valid URL.
FormFieldValidator<T> turboValueValidatorsUrl<T>({
  required TurboLazyLocatorDef<String> errorText,
}) {
  return (T? valueCandidate) {
    if (valueCandidate is String) {
      if (RegExp(
        r'^(https?://)?([\da-z.-]+)\.([a-z.]{2,6})([/\w .-]*)*/?$',
      ).hasMatch(valueCandidate)) {
        return null;
      }
    }
    return errorText();
  };
}

/// Combines multiple validators for list values, returning the first error found.
TurboValuesValidatorDef turboValuesValidatorsMultiple(
  List<TurboValuesValidatorDef> validators,
) => (values) {
  for (final validator in validators) {
    final validatorResult = validator.call(values);
    if (validatorResult != null) {
      return validatorResult;
    }
  }
  return null;
};

/// Validates that a list is not empty.
TurboValuesValidatorDef<T> turboValuesValidatorsRequired<T>({
  required TurboLazyLocatorDef<String> errorText,
}) {
  return (List<T>? values) {
    if (values?.isEmpty ?? true) {
      return errorText();
    }
    return null;
  };
}

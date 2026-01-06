# Change: Update turbo_forms to use Turbolytics

## Why
After `turbolytics` package renamed `Loglytics` to `Turbolytics`, `turbo_forms` must be updated to use the new mixin name to prevent broken imports and maintain consistency.

## What Changes
- Update `turbo_forms/lib/src/config/turbo_form_field_config.dart` to use `with Turbolytics` (renamed from `with Loglytics`)

## Impact
- Affected code:
  - `turbo_forms/lib/src/config/turbo_form_field_config.dart`


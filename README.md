# Dynamix Flutter SDK

Dynamix Flutter SDK is a Flutter package that provides easy integration for displaying in-app templates and widgets.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  dynamix_flutter_sdk: ^0.0.1
```

Run:

```sh
flutter pub get
```

## Initialization

Initialize the SDK before using it:

```dart
TemplateSdk.instance.initialize();
```

## Usage

### Showing Templates on the Dashboard

Call this inside `WidgetsBinding.instance.addPostFrameCallback` to display templates:

```dart
WidgetsBinding.instance.addPostFrameCallback((_) {
  // Show app_open templates only on dashboard
  TemplateSdk.instance.showAppOpenTemplates(context);
  
  // Also show dashboard screen templates
  TemplateSdk.instance.showScreenTemplates(context, 'ScreenName');
});
```

### Displaying In-App Widget

Use the `inAppWidgetContainer` method to display in-app widgets:

```dart
TemplateSdk.instance.inAppWidgetContainer(
  screenName: 'ScreenName',
  height: 250,
  padding: const EdgeInsets.all(16),
);
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
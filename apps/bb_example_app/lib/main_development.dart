import 'package:bb_example_app/app.dart';
import 'package:values/values.dart';

/// DEV ENVIRONMENT
///
/// COMMAND LINE EXAMPLE
/// flutter run --flavor development lib/app/main/main_development.dart
/// flutter build apk --release --flavor development lib/app/main/main_development.dart --no-tree-shake-icons
/// flutter build appbundle --release --flavor development lib/app/main/main_development.dart
void main() {
  run(
    EnvironmentConfigModel(
      appName: 'Dev App',
      environment: AppEnvironment.development,
      apiBaseUrl: 'rickandmortyapi.com',
      socketUrl: 'Socket Url',
    ),
  );
}

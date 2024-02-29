import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import './di.config.dart';

final GetIt _di = GetIt.instance;

@InjectableInit(
  initializerName: r'$build',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> _build() async => await $build(_di, environment: const String.fromEnvironment('DI_ENV'));

class DI {
  static Future<void> build() async => await _build();

  static T get<T extends Object>({String? name}) => _di.get<T>(instanceName: name);

  static Future<T> getAsync<T extends Object>({String? name}) => _di.getAsync<T>(instanceName: name);

  static Logger logger() => _di.get<Logger>();
}

const local = Environment('local');

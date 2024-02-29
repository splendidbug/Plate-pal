import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class LoggerModule {
  @singleton
  Logger logger() => Logger(
        printer: PrettyPrinter(
          printTime: true,
        ),
      );
}

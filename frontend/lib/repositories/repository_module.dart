import 'package:dio/dio.dart';
import 'package:frontend/repositories/ocr/ocr_repository.dart';
import 'package:frontend/repositories/recpie/recpie_repository.dart';
import 'package:injectable/injectable.dart';

import 'chat/chat_repository.dart';

@module
abstract class RepositoryModule {
  @injectable
  OcrRepository ocrRepository(Dio dio) => OcrRepository(dio);

  @injectable
  RecpieRepository recpieRepository(Dio dio) => RecpieRepository(dio);

  @injectable
  ChatRepository chatRepository(Dio dio) => ChatRepository(dio);
}

import 'package:frontend/repositories/ocr/ocr_dtos.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'ocr_repository.g.dart';

@RestApi()
abstract class OcrRepository {
  factory OcrRepository(Dio dio) = _OcrRepository;

  @POST('/ocr')
  Future<List<String>> scan(@Body() OcrInput dto);
}

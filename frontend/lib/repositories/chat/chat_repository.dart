import 'package:dio/dio.dart';
import 'package:frontend/repositories/chat/chat_dtos.dart';
import 'package:retrofit/http.dart';

part 'chat_repository.g.dart';

@RestApi()
abstract class ChatRepository {
  factory ChatRepository(Dio dio) = _ChatRepository;

  @POST("/ask_chat_gpt")
  Future<ChatOutput> chat(@Body() ChatInput dto);

  @POST("/get_recipe")
  Future<String> initial(@Body() ChatStart dto);
}

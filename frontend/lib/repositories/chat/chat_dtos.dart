import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_dtos.freezed.dart';
part 'chat_dtos.g.dart';

@freezed
class ChatInput with _$ChatInput {
  factory ChatInput({
    required String current_recipe,
    required String input_string,
    required List<String> inventory,
    required List<String> recipe_history,
    required String calorie,
  }) = _ChatInput;

  factory ChatInput.fromJson(Map<String, dynamic> json) => _$ChatInputFromJson(json);
}

@freezed
class ChatOutput with _$ChatOutput {
  factory ChatOutput({required String result}) = _ChatOutput;

  factory ChatOutput.fromJson(Map<String, dynamic> json) => _$ChatOutputFromJson(json);
}

@freezed
class ChatStart with _$ChatStart {
  factory ChatStart({
    required String title,
  }) = _ChatStart;

  factory ChatStart.fromJson(Map<String, dynamic> json) => _$ChatStartFromJson(json);
}

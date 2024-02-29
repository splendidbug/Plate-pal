import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_dtos.freezed.dart';
part 'ocr_dtos.g.dart';

@freezed
class OcrInput with _$OcrInput {
  factory OcrInput({required String input_string, required String filename}) = _OcrInput;

  factory OcrInput.fromJson(Map<String, dynamic> json) => _$OcrInputFromJson(json);
}

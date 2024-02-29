import 'package:freezed_annotation/freezed_annotation.dart';

part 'recpie_dtos.freezed.dart';
part 'recpie_dtos.g.dart';

@freezed
class RecpieInput with _$RecpieInput {
  factory RecpieInput({required RecpieQuery query}) = _RecpieInput;

  factory RecpieInput.fromJson(Map<String, dynamic> json) => _$RecpieInputFromJson(json);
}

@freezed
class RecpieQuery with _$RecpieQuery {
  factory RecpieQuery({required List<String> ingredients}) = _RecpieQuery;

  factory RecpieQuery.fromJson(Map<String, dynamic> json) => _$RecpieQueryFromJson(json);
}

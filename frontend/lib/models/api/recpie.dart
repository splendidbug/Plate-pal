import 'package:freezed_annotation/freezed_annotation.dart';

part 'recpie.freezed.dart';
part 'recpie.g.dart';

@freezed
class Recpie with _$Recpie {
  factory Recpie({
    required String recipe_name,
    required String prep_time,
    required String calories,
    required String url,
  }) = _Recpie;

  factory Recpie.fromJson(Map<String, dynamic> json) => _$RecpieFromJson(json);
}

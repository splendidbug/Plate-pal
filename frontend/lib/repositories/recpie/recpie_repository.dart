import 'package:dio/dio.dart';
import 'package:frontend/models/models.dart';
import 'package:retrofit/http.dart';

import 'recpie_dtos.dart';

part 'recpie_repository.g.dart';

@RestApi()
abstract class RecpieRepository {
  factory RecpieRepository(Dio dio) = _RecpieRepository;

  @POST('/all_recipes')
  Future<List<Recpie>> getAll(@Body() RecpieQuery dto);
}

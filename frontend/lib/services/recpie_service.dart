import 'dart:convert';

import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/recpie/recpie_dtos.dart';
import 'package:frontend/repositories/recpie/recpie_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter/services.dart' show rootBundle;

@lazySingleton
class RecpieService {
  final RecpieRepository _repository;

  RecpieService(
    this._repository,
  );

  Future<List<Recpie>> loadApi(List<String> items) async {
    return await _repository.getAll(RecpieQuery(ingredients: items));
  }
}

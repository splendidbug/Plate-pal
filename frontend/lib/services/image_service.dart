import 'dart:convert';

import 'package:frontend/repositories/ocr/ocr_dtos.dart';
import 'package:frontend/repositories/ocr/ocr_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import '../blocs/notification/notification_bloc.dart';

@lazySingleton
class ImageService {
  final OcrRepository _repository;
  final ImagePicker _picker = ImagePicker();

  ImageService(
    this._repository,
  );

  Future<List<String>> scan() async {
    final images = await _picker.pickImage(source: ImageSource.gallery);
    final img64 = base64Encode(await images!.readAsBytes());
    final result = (await this._repository.scan(OcrInput(input_string: img64, filename: "pp.png")));
    return result;
  }
}

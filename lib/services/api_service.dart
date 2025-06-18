import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://10.0.2.2:8000'; // Substitua aqui

  Future<Map<String, dynamic>> uploadImage(File imageFile) async {
    String fileName = imageFile.path.split('/').last;

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path, filename: fileName),
    });

    try {
      final response = await _dio.post(
        '$_baseUrl/ocr/',
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
        }),
      );

      return response.data;
    } catch (e) {
      throw Exception('Erro ao enviar imagem: $e');
    }
  }
}
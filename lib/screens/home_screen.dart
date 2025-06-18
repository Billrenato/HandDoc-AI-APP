import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/api_service.dart';
import 'ocr_result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _requestPermission(Permission permission) async {
    var status = await permission.status;
    if (!status.isGranted) {
      await permission.request();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    // Solicita permissões
    await _requestPermission(Permission.camera);
    await _requestPermission(Permission.photos);
    await _requestPermission(Permission.storage);

    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      try {
        final response = await ApiService().uploadImage(_imageFile!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OcrResultScreen(
              filename: response['filename'] ?? 'sem_nome',
              text: response['text'] ?? 'Sem texto retornado',
              timestamp: response['timestamp'] ?? '',
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro no OCR: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HandDoc AI'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!, height: 200)
                : const Text('Nenhuma imagem selecionada.'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capturar da Câmera'),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text('Selecionar da Galeria'),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}

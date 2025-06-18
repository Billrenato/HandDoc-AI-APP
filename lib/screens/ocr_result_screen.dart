import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/file_utils.dart';

class OcrResultScreen extends StatelessWidget {
  final String filename;
  final String text;
  final String timestamp;

  const OcrResultScreen({
    Key? key,
    required this.filename,
    required this.text,
    required this.timestamp,
  }) : super(key: key);

  Future<void> _savePdf(BuildContext context) async {
    final file = await FileUtils.saveTextAsPdf(text, filename);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF salvo em: ${file.path}')),
    );
  }

  Future<void> _saveTxt(BuildContext context) async {
    final file = await FileUtils.saveTextAsTxt(text, filename);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('TXT salvo em: ${file.path}')),
    );
  }

  Future<void> _share(BuildContext context) async {
    final file = await FileUtils.saveTextAsTxt(text, filename);
    await FileUtils.shareFile(file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado OCR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('📁 Arquivo: $filename'),
            Text('⏰ Data: $timestamp'),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(text),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _savePdf(context),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Salvar PDF'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _saveTxt(context),
                  icon: const Icon(Icons.note),
                  label: const Text('Salvar TXT'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _share(context),
                  icon: const Icon(Icons.share),
                  label: const Text('Compartilhar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

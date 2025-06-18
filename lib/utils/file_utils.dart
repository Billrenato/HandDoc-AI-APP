import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class FileUtils {
  static Future<String> _getDirectoryPath() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/HandDocAI';
    final directory = Directory(path);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return path;
  }

  static Future<File> saveTextAsTxt(String content, String filename) async {
    final path = await _getDirectoryPath();
    final file = File('$path/$filename.txt');
    return file.writeAsString(content);
  }

  static Future<File> saveTextAsPdf(String content, String filename) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Text(content),
      ),
    );

    final path = await _getDirectoryPath();
    final file = File('$path/$filename.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static Future<void> printPdf(File file) async {
    await Printing.layoutPdf(onLayout: (_) => file.readAsBytes());
  }

  static Future<void> shareFile(File file) async {
    await Share.shareXFiles([XFile(file.path)], text: 'Compartilhado via HandDoc AI');
  }
}

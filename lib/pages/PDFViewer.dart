import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class PDFViewer extends StatefulWidget {
  late final String url;
  late final String name;
  PDFViewer(String name, String url) {
    this.url = url;
    this.name = name;
  }

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  late Future<String> _pdfPath;

  @override
  void initState() {
    super.initState();
    _pdfPath = _downloadAndCachePDF(widget.url);
  }

  Future<String> _downloadAndCachePDF(String url) async {
    try {
      // Download PDF
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to download PDF');
      }

      // Get cache directory
      final dir = await getTemporaryDirectory();
      final filename = url.split('/').last.replaceAll(RegExp(r'[^\w\s.]'), '_');
      final filepath = '${dir.path}/$filename';

      // Save to file
      final file = File(filepath);
      await file.writeAsBytes(response.bodyBytes);

      return filepath;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: FutureBuilder<String>(
        future: _pdfPath,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return PDFView(
              filePath: snapshot.data!,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              pageSnap: true,
              fitPolicy: FitPolicy.BOTH,
              onRender: (_pages) {},
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}

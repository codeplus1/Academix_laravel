import 'dart:convert';
import 'dart:io';

import 'package:academix/Api/api.dart';
import 'package:academix/const/const.dart';
import 'package:academix/pages/download_search_page.dart';
import 'package:academix/widgets/loading_effect.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ReadPdf extends StatefulWidget {
  const ReadPdf({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReadPdfState createState() => _ReadPdfState();
}

class _ReadPdfState extends State<ReadPdf> {
  String? _downloadProgress;

  Future<List<dynamic>> getNotes() async {
    var response = await Api().getData('download');
    var data = json.decode(response.body)['data'];
    return data;
  }

  Future<String?> downloadAndSavePdf(String url, String fileName) async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = "${directory.path}/$fileName";

      File file = File(filePath);
      if (await file.exists()) {
        return filePath; // Return existing file path
      } else {
        Dio dio = Dio();
        await dio.download(
          url,
          filePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              setState(() {
                _downloadProgress = (received / total * 100).toStringAsFixed(0);
              });
            }
          },
        );
        return filePath; // Return the downloaded file path
      }
    } catch (e) {
      logger.e("Error downloading PDF: $e");
      return null; // Return null on error
    }
  }

  void openPdf(String url, String title) async {
    String fileName = url.split('/').last; // Extract the file name from the URL
    String? localFilePath = await downloadAndSavePdf(url, fileName);

    if (localFilePath != null && localFilePath.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PdfViewerScreen(pdfPath: localFilePath, title: title),
        ),
      );
    } else {
      if (mounted) {
        // Check if the widget is still mounted
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: const Text("Failed to download the PDF."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'PDF Notes',
          style: TextStyle(color: textColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DownloadSearchPage()),
              );
            },
            icon: const Icon(Icons.search, size: 30),
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: loadingEffect())
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var mydata = snapshot.data![index];
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                openPdf(mydata['document'], mydata['title']);
                              },
                              title: Text(mydata['title']),
                              subtitle: Text(mydata['created_at']),
                              trailing: Icon(
                                Icons.remove_red_eye_outlined,
                                size: 30,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          if (_downloadProgress != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Downloading... $_downloadProgress%'),
                            ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}

class PdfViewerScreen extends StatefulWidget {
  // Make the class public
  final String pdfPath;
  final String title;

  const PdfViewerScreen(
      {super.key, required this.pdfPath, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  bool _isPdfReady = false;
  int? totalPages;
  int? currentPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.pdfPath,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: false,
            onRender: (pages) {
              if (mounted) {
                // Ensure the widget is still mounted
                setState(() {
                  _isPdfReady = true;
                  totalPages = pages;
                });
              }
            },
            onError: (error) {
              logger.e("Error loading PDF: $error");
              if (mounted) {
                // Ensure the widget is still mounted
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Error loading PDF: $error"),
                ));
              }
            },
            onPageChanged: (page, total) {
              if (mounted) {
                // Ensure the widget is still mounted
                setState(() {
                  currentPage =
                      page! + 1; // Ensure currentPage is updated correctly
                });
              }
            },
            onPageError: (page, error) {
              logger.e("Error on page $page: $error");
              if (mounted) {
                // Ensure the widget is still mounted
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Error on page $page: $error"),
                ));
              }
            },
          ),
          if (!_isPdfReady) const Center(child: CircularProgressIndicator()),
          if (_isPdfReady)
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                'Page ${currentPage ?? 0} of ${totalPages ?? 0}',
                style: const TextStyle(color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:open_file/open_file.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:async';

void teste() async {
  final pdf = PdfDocument(deflate: zlib.encode);
  final page = PdfPage(pdf, pageFormat: PdfPageFormat.letter);
  final g = page.getGraphics();
  final font = g.defaultFont;
  final top = page.pageFormat.height;

  g.setColor(PdfColor(0.0, 1.0, 1.0));
  g.drawRect(50.0 * PdfPageFormat.mm, top - 80.0 * PdfPageFormat.mm,
      100.0 * PdfPageFormat.mm, 50.0 * PdfPageFormat.mm);
  g.fillPath();

  g.setColor(PdfColor(0.3, 0.3, 0.3));
  g.drawString(font, 12.0, "Hello World!", 10.0 * PdfPageFormat.mm,
      top - 10.0 * PdfPageFormat.mm);

  //var file = File('example.pdf');
  //file.writeAsBytesSync(pdf.save());

  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  var file = File("$tempPath/file.pdf");
  await file.writeAsBytes(pdf.save());
  await OpenFile.open("$tempPath/file.pdf");
  //print("file://$tempPath/file.pdf");
  //await launch("content://$tempPath/file.pdf");
  print("hm");
}

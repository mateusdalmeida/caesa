import 'dart:io';
import 'package:open_file/open_file.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:caesa/models/debito.dart';
import 'package:caesa/models/cliente.dart';
import 'package:caesa/functions/dateConvert.dart';
import 'package:caesa/services/barcode.dart';
//import 'dart:async';

// void teste() async {
//   final pdf = PdfDocument(deflate: zlib.encode);
//   final page = PdfPage(pdf, pageFormat: PdfPageFormat.letter);
//   final g = page.getGraphics();
//   final font = g.defaultFont;
//   final top = page.pageFormat.height;

//   g.setColor(PdfColor(0.0, 1.0, 1.0));
//   g.drawRect(50.0 * PdfPageFormat.mm, top - 80.0 * PdfPageFormat.mm,
//       100.0 * PdfPageFormat.mm, 50.0 * PdfPageFormat.mm);
//   g.fillPath();

//   g.setColor(PdfColor(0.3, 0.3, 0.3));
//   g.drawString(font, 12.0, "Hello World!", 10.0 * PdfPageFormat.mm,
//       top - 10.0 * PdfPageFormat.mm);

//   Directory tempDir = await getTemporaryDirectory();
//   String tempPath = tempDir.path;
//   var file = File("$tempPath/file.pdf");
//   await file.writeAsBytes(pdf.save());
//   await OpenFile.open("$tempPath/file.pdf");
//   print("hm");
// }

void boletoPDF(Debito debitos, Cliente cliente, String digitavel) async {
  final Document pdf = Document(deflate: zlib.encode);

  pdf.addPage(MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const BoxDecoration(
                border:
                    BoxBorder(bottom: true, width: 0.5, color: PdfColor.grey)),
            child: Text('Portable Document Format',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColor.grey)));
      },
      build: (Context context) => <Widget>[
            Header(
                level: 0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Caesa Boleto', textScaleFactor: 2),
                    ])),
            Row(children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //nome
                      Text('Nome', textScaleFactor: 1.5),
                      Text(cliente.nome),
                      Container(height: 20),
                      //Vencimento
                      Text('Vencimento', textScaleFactor: 1.5),
                      Text(dateConvert(debitos.dataVencimento.toString())),
                      Container(height: 20),
                      //Endereço
                      Text('Endereço', textScaleFactor: 1.5),
                      Text("${cliente.endereco} - ${cliente.numeroPorta}"),
                      Container(height: 20),
                      Text('Valor a Pagar', textScaleFactor: 1.5),
                    ]),
              ),
              Expanded(
                flex: 1,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //matricula
                      Text('Matricula', textScaleFactor: 1.5),
                      Text(debitos.inscricao.toString()),
                      Container(height: 20),
                      //Mes Referencia
                      Text('Mes Referencia', textScaleFactor: 1.5),
                      Text(dateConvert(debitos.refFaturamento.toString())),
                      Container(height: 20),
                      //Origem
                      Text('Origem', textScaleFactor: 1.5),
                      Text(debitos.origem.toString()),
                      Container(height: 20),
                      Text("R\$ ${debitos.valorTotal.toStringAsFixed(2)}"),
                    ]),
              )
            ]),
            Container(height: 20),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Linha Digitavel'),
                    Text(digitavel),
                  ]
                )
              ]
            )
          ]));

  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  var file = File("$tempPath/file.pdf");
  await file.writeAsBytes(pdf.save());
  await OpenFile.open("$tempPath/file.pdf");
}

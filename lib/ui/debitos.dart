import 'package:flutter/material.dart';

import 'package:caesa/models/debito.dart';
import 'package:caesa/ui/fatura.dart';
import 'package:caesa/functions/dateConvert.dart';

class Debitos extends StatefulWidget {
  List<Debito> debitos;

  Debitos(this.debitos);

  _DebitosState createState() => _DebitosState();
}

class _DebitosState extends State<Debitos> {
  // essa é uma classe diferente da de cima, então é necessário declarar aqui também
  List<Debito> debitos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debitos = widget.debitos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CAESA - Debitos"),
        centerTitle: true,
      ),
      body: _createDebitosList(context, debitos),
    );
  }
}

Widget _createDebitosList(BuildContext context, List<Debito> debitos) {
  return SingleChildScrollView(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Text(
          "Suas Faturas\nMatricula: ${debitos[0].inscricao}",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      ListView.separated(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: debitos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              child: ListTile(
            title: Text(dateConvert(debitos[index].refFaturamento.toString())),
            subtitle: Text(
                "Vencimento: ${dateConvert(debitos[index].dataVencimento.toString())}\nR\$ ${debitos[index].valorTotal.toStringAsFixed(2)}"),
            isThreeLine: true,
            trailing: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: debitos[index].status == "Pagar"
                      ? Colors.yellow
                      : debitos[index].status == "Pago"
                          ? Colors.green
                          : Colors.red,
                  borderRadius: BorderRadius.circular(50)),
              child: Text(debitos[index].status),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Fatura(debitos[index])));
            },
          ));
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 0,
            ),
          );
        },
      )
    ],
  ));
}

import 'package:flutter/material.dart';
import 'package:caesa/models/debito.dart';

class Fatura extends StatefulWidget {
  List<Debito> debitos;
  
  Fatura(this.debitos);
  _FaturaState createState() => _FaturaState();
}

class _FaturaState extends State<Fatura> {
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
        title: Text("${debitos[0].refFaturamento}"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Nome: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "Fulano",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                "Endereço: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "Fulano",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                "Localidade: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "Fulano",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                "Vol. Faturado: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "${debitos[0].volume} m3",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                "Data de Vencimento: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "${debitos[0].dataVencimento}",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                "Total: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "R\$ ${debitos[0].valorTotal}",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(),
          FlatButton(
            color: Colors.blue,
            padding: EdgeInsets.all(13),
            //minWidth: double.infinity,
            child: Text(
              "COPIAR CÓDIGO DE BARRAS",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () {},
          ),
          FlatButton(
            color: Colors.blue,
            padding: EdgeInsets.all(13),
            //minWidth: double.infinity,
            child: Text(
              "GERAR BOLETO",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () {},
          ),
        ],
      ),

    );
  }
}
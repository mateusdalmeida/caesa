import 'package:flutter/material.dart';
import 'package:caesa/models/debito.dart';
import 'package:caesa/services/barcode.dart';

class Fatura extends StatefulWidget {
  Debito debitos;
  
  Fatura(this.debitos);
  _FaturaState createState() => _FaturaState();
}

class _FaturaState extends State<Fatura> {
  Debito debitos;
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
        title: Text("${debitos.refFaturamento}"),
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
                "${debitos.volume} m3",
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
                "${debitos.dataVencimento}",
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
                "R\$ ${debitos.valorTotal}",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(),
          MaterialButton(
            color: Colors.blue,
            padding: EdgeInsets.all(13),
            //minWidth: double.infinity,
            child: Text(
              "COPIAR CÓDIGO DE BARRAS",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: geraCodigo(
              'copia', 
              debitos.valorTotal, 
              debitos.inscricao, 
              debitos.refFaturamento, 
              debitos.origem),
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
import 'package:flutter/material.dart';
import 'package:caesa/models/debito.dart';
import 'package:caesa/models/cliente.dart';
import 'package:caesa/services/barcode.dart';
import 'package:caesa/functions/dateConvert.dart';

class Fatura extends StatefulWidget {
  Debito debitos;
  Cliente cliente;

  Fatura(this.debitos, this.cliente);
  _FaturaState createState() => _FaturaState();
}

class _FaturaState extends State<Fatura> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(dateConvert(debitos.refFaturamento.toString())),
        centerTitle: true,
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Nome: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                widget.cliente.nome,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Row(
            children: <Widget>[
              Text(
                "Endereço: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "${widget.cliente.endereco} - ${widget.cliente.numeroPorta}",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Row(
            children: <Widget>[
              Text(
                "Localidade: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                widget.cliente.cidade,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Row(
            children: <Widget>[
              Text(
                "Vol. Faturado: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "${debitos.volume} m³",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Row(
            children: <Widget>[
              Text(
                "Data de Vencimento: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                dateConvert(debitos.dataVencimento.toString()),
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Row(
            children: <Widget>[
              Text(
                "Total: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "R\$ ${debitos.valorTotal.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          debitos.status == "Pago"
              ? Center(
                  child: Text("FATURA PAGA"),
                )
              : botoes()
        ],
      ),
    );
  }

  Widget botoes() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        FlatButton(
          color: Colors.blue,
          padding: EdgeInsets.all(13),
          child: Text(
            "COPIAR CÓDIGO DE BARRAS",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () {
            geraCodigo('copia', debitos.valorTotal, debitos.inscricao,
                debitos.refFaturamento, debitos.origem);
            final snackBar =
                SnackBar(content: Text("Codigo Copiado com Sucesso"));
            _scaffoldKey.currentState.showSnackBar(snackBar);
          },
        ),
        FlatButton(
          color: Colors.blue,
          padding: EdgeInsets.all(13),
          child: Text(
            "GERAR BOLETO",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}

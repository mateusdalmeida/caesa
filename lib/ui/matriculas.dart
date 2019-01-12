import 'package:flutter/material.dart';

import 'package:caesa/services/api.dart' as api;
import 'package:caesa/models/cliente.dart';

class Matriculas extends StatefulWidget {

  List<Cliente> matriculas;

  Matriculas(this.matriculas);

  _MatriculasState createState() => _MatriculasState();
}

class _MatriculasState extends State<Matriculas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CAESA - Matriculas"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: api.getClientes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _createMatriculasList(context, snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

Widget _createMatriculasList(BuildContext context, List<Cliente> clientes) {
  return SingleChildScrollView(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Text(
          "Bem vindo(a) ${clientes[0].nome}\nEssas são as matriculas em seu nome",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      ListView.separated(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              child: ListTile(
            title: Text("Matricula: ${clientes[index].inscricao}"),
            subtitle: Text(
                "${clientes[index].idLogradouro}\n${clientes[index].categoria}"),
            isThreeLine: true,
          ));
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          );
        },
      )
    ],
  ));
}

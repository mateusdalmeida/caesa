import 'package:flutter/material.dart';

import 'package:caesa/services/api.dart' as api;
import 'package:caesa/models/cliente.dart';

class Matriculas extends StatefulWidget {

  List<Cliente> matriculas;

  // aqui tu obriga o construtor a ter o parametro matricula, tudo okay
  Matriculas(this.matriculas);

  _MatriculasState createState() => _MatriculasState();
}

class _MatriculasState extends State<Matriculas> {

  // essa é uma classe diferente da de cima, então é necessário declarar aqui também
  List<Cliente> matriculas;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      // na inicialização do widget eu pego o valor da matricula da classe de cima com widget.matriculas
      // o widget. é usado pra pegar os valores da classe que extende statefulwidget
      matriculas = widget.matriculas;
      print(matriculas.length);
      for (var matricula in matriculas){
        print(matricula.nome);
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CAESA - Matriculas"),
        centerTitle: true,
      ),
      // nao faz sentido ter um futurebuilder aqui, a requisição é a mesma utilizada na tela anterior
      body: _createMatriculasList(context, matriculas),
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

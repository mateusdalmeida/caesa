import 'package:flutter/material.dart';

//mport 'package:caesa/services/api.dart' as api;
import 'package:caesa/models/debito.dart';
import 'package:caesa/ui/fatura.dart';

class Faturas extends StatefulWidget {
  List<Debito> debitos;

  // aqui tu obriga o construtor a ter o parametro matricula, tudo okay
  Faturas(this.debitos);

  _FaturasState createState() => _FaturasState();
}

class _FaturasState extends State<Faturas> {
  // essa é uma classe diferente da de cima, então é necessário declarar aqui também
  List<Debito> debitos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // na inicialização do widget eu pego o valor da matricula da classe de cima com widget.matriculas
    // o widget. é usado pra pegar os valores da classe que extende statefulwidget
    debitos = widget.debitos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CAESA - Faturas"),
        centerTitle: true,
      ),
      // nao faz sentido ter um futurebuilder aqui, a requisição é a mesma utilizada na tela anterior
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
            title: Text("${debitos[index].refFaturamento}"),
            subtitle: Text(
                "Vencimento: ${debitos[index].dataVencimento}\nR\$ ${debitos[index].valorTotal}"),
            isThreeLine: true,
            trailing: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: debitos[index].status == "Pagar" ? Colors.yellow : debitos[index].status == "Pago"? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(50)
                
              ),
              
              child: Text("${debitos[index].status}"),
            ),
            onTap:() {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Fatura(debitos)));
            },
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

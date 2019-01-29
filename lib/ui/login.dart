//todo
//exibe 00.0 por padrão na matricula
//quando o cpf não existe exibir erro apropriado,  está dandoo erro de range
//erro de timeout

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

import 'package:caesa/services/api.dart' as api;
import 'package:caesa/ui/matriculas.dart';
import 'package:caesa/models/cliente.dart';
import 'package:caesa/functions/dialogs.dart';
import 'package:caesa/functions/matriculaController.dart';
import 'package:caesa/functions/mod11.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int tabIndex = 0;

  //VALIDACAO CPF
  GlobalKey<FormState> _cpfKey = GlobalKey<FormState>();
  var cpfController = MaskedTextController(mask: '000.000.000-00');
  bool cpfIsValid = false;
  void _validarCPF(String text) {
    cpfIsValid = false;
    cpfIsValid = CPFValidator.isValid(text);
  }

  //Validacao Matricula
  GlobalKey<FormState> _matriculaKey = GlobalKey<FormState>();
  var matriculaController = MatriculaController();
  bool matriculaIsValid = false;
  String matriculaLimpa;
  // void _validarMatricula(String text) {
  //   matriculaIsValid = false;
  //   String matricula = text.split('-')[0];
  //   //print("matricula $matricula");
  //   String dv = text.split('-')[1];
  //   //print("dv $dv");
  //   int dvCorreto = mod11(matricula);
  //   //print("correto $dvCorreto");
  //   if (int.parse(dv) == dvCorreto) {
  //     matriculaIsValid = true;
  //     matriculaLimpa = matricula;
  //   }
  // }
  // refatorada
  void _validarMatricula(String text) {
    matriculaIsValid = false;
    if (int.parse(text.split('-')[1]) == mod11(text.split('-')[0])) {
      matriculaIsValid = true;
      matriculaLimpa = text.split('-')[0];
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: 2, initialIndex: tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CAESA - 2ª via"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Escolha a forma de acesso",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.justify,
                )),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          "MATRICULA",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: _tabController.index == 0
                                      ? Colors.blue
                                      : Colors.grey,
                                  width: 2))),
                    ),
                    onTap: () {
                      _tabController.animateTo(0);
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          "CPF",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: _tabController.index == 1
                                      ? Colors.blue
                                      : Colors.grey,
                                  width: 2))),
                    ),
                    onTap: () {
                      _tabController.animateTo(1);
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            //TABS
            Expanded(
                child: TabBarView(
              controller: _tabController,
              // Restrict scroll by user
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                //login por matricula
                Form(
                    key: _matriculaKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 10),
                        TextFormField(
                          controller: matriculaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Matricula",
                              labelText: "Insira sua Matricula aqui"),
                          validator: (value) {
                            if (value.isNotEmpty) {
                              if (value.length > 4) {
                                _validarMatricula(value);
                                if (matriculaIsValid == false)
                                  return "DV Invalido";
                              } else {
                                return "Informe uma matricula";
                              }
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        FlatButton(
                          color: Colors.blue,
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Entrar",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          onPressed: () async {
                            if (_matriculaKey.currentState.validate()) {
                              loadingDialog(context);
                              List<Cliente> user = await api.getClientes(
                                  inscricao: int.parse(matriculaLimpa));
                              if (user != null) {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Matriculas(user)));
                              } else {
                                Navigator.of(context).pop();
                                showAvisoLogin(context);
                              }
                            }
                          },
                        ),
                        FlatButton(
                          child: Text("hm"),
                          onPressed: () {
                            formataData();
                          },
                        )
                      ],
                    )),

                //login por cpf
                Form(
                    key: _cpfKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: cpfController,
                          decoration: InputDecoration(
                              hintText: "CPF",
                              labelText: "Insira seu CPF aqui"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "CPF não informado";
                            } else if (value.isNotEmpty) {
                              _validarCPF(value);
                              if (cpfIsValid == false) return "CPF não valido";
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        FlatButton(
                          color: Colors.blue,
                          padding: EdgeInsets.all(15),
                          //minWidth: double.infinity,
                          child: Text(
                            "Entrar",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          onPressed: () async {
                            if (_cpfKey.currentState.validate()) {
                              loadingDialog(context);
                              List<Cliente> user = await api.getClientes(
                                  cpf: CPFValidator.strip(cpfController.text));
                              if (user != null) {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Matriculas(user)));
                              } else {
                                Navigator.of(context).pop();
                                showAvisoLogin(context);
                              }
                            }
                          },
                        ),
                      ],
                    )),
              ],
            )),
          ],
        ),
      ),
    );
  }

  void formataData() {
    // 201810 => Outubro 2018
    // 20190129 => 29/01/2019
    List meses = [
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maioi',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro'
    ];
    String dataAntiga1 = "201810";
    String anoAntigo1 = dataAntiga1.substring(0, 4);
    String mesAntigo1 = dataAntiga1.substring(4, 6);
    print(dataAntiga1);
    print(anoAntigo1);
    print(mesAntigo1);
    mesAntigo1 = (int.parse(mesAntigo1)-1).toString();
    print("${meses[int.parse(mesAntigo1)]} $anoAntigo1");

    String dataAntiga2 = "20190129";
    String anoAntigo2 = dataAntiga2.substring(0, 4);
    String mesAntigo2 = dataAntiga2.substring(4, 6);
    String diaAntigo = dataAntiga2.substring(6, 8);
    print(dataAntiga2);
    print(anoAntigo2);
    print(mesAntigo2);
    print(diaAntigo);
    print("$diaAntigo/$mesAntigo2/$anoAntigo2");
  }
}

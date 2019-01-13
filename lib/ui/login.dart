import 'package:flutter/material.dart';
import 'package:caesa/services/api.dart' as api;
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

import 'package:caesa/ui/matriculas.dart';
import 'package:caesa/ui/matriculaController.dart';
import 'package:caesa/models/cliente.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

int _mod11(String matricula) {
  List<int> numbers = matricula
      .split("")
      .map((number) => int.parse(number, radix: 10))
      .toList();
  int modulus = numbers.length + 1;
  List<int> multiplied = [];
  for (var i = 0; i < numbers.length; i++) {
    multiplied.add(numbers[i] * (modulus - i));
  }
  int mod = multiplied.reduce((buffer, number) => buffer + number) % 11;
  return (mod < 2 ? 0 : 11 - mod);
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int tabIndex = 0;
  bool tabColor = true;

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
  void _validarMatricula(String text) {
    matriculaIsValid = false;
    String matricula = text.split('-')[0];
    //print("matricula $matricula");
    String dv = text.split('-')[1];
    //print("dv $dv");
    int dvCorreto = _mod11(matricula);
    //print("correto $dvCorreto");
    if (int.parse(dv) == dvCorreto) {
      matriculaIsValid = true;
      matriculaLimpa = matricula;
    }
  }
  // refatorada
  // void _validarMatricula(String text) {
  //   matriculaIsValid = false;
  //   if (int.parse(text.split('-')[1]) == _mod11(text.split('-')[0])) {
  //     matriculaIsValid = true;
  //     matriculaLimpa = text.split('-')[0];
  //   }
  // }

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
                                  color: tabColor ? Colors.grey : Colors.blue,
                                  width: 2))),
                    ),
                    onTap: () {
                      _tabController.animateTo(0);
                      setState(() {
                        tabColor = false;
                      });
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
                                  color: tabColor ? Colors.blue : Colors.grey,
                                  width: 2))),
                    ),
                    onTap: () {
                      _tabController.animateTo(1);
                      setState(() {
                        tabColor = true;
                      });
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
                              _loadingDialog();
                              List<Cliente> user = await api.getClientes(
                                  inscricao: int.parse(matriculaLimpa));
                              if (user != null) {
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Matriculas(user)));
                              } else {
                                Navigator.of(context).pop();
                                _showAvisoLogin();
                              }
                            }
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
                              _loadingDialog();
                              List<Cliente> user = await api.getClientes(
                                  cpf: CPFValidator.strip(cpfController.text));
                              if (user != null) {
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Matriculas(user)));
                              } else {
                                Navigator.of(context).pop();
                                _showAvisoLogin();
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

  _loadingDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Entrando",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          );
        });
  }

  _showAvisoLogin() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Erro"),
            content: Text("Usuario não encontrado"),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}

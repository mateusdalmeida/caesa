import 'package:flutter/material.dart';
import 'package:caesa/services/api.dart' as api;
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  TabController _tabController;
  var cpfController = MaskedTextController(
    mask: '000.000.000-00',
  );
  int tabIndex = 0;
  bool tabColor = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: 2, initialIndex: tabIndex);

    // Chama a tela de "aguardar"
    api.getClientes().then((result) {
      // repara que aqui eu não utilizei o await, porque a função initState não pode ser async
      // por isso usei .then (parecido com o js da vida)
      //print(result[0].nome);
      setState(() {
        // Após o delay, dispensa a tela de "aguardar"
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CAESA - 2ª via"),
        centerTitle: true,
      ),
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
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
                                        color: tabColor
                                            ? Colors.grey
                                            : Colors.blue,
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
                                        color: tabColor
                                            ? Colors.blue
                                            : Colors.grey,
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
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    // Restrict scroll by user
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      //login por matricula
                      Form(
                          child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 8,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "Matricula",
                                      labelText: "Insira sua Matricula aqui"),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "DV", labelText: "DV"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          MaterialButton(
                            color: Colors.blue,
                            padding: EdgeInsets.all(15),
                            minWidth: double.infinity,
                            child: Text(
                              "Entrar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () {},
                          )
                        ],
                      )),
                      //login por cpf
                      Form(
                          child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: cpfController,
                            decoration: InputDecoration(
                                hintText: "CPF",
                                labelText: "Insira seu CPF aqui"),
                          ),
                          SizedBox(height: 15),
                          MaterialButton(
                            color: Colors.blue,
                            padding: EdgeInsets.all(15),
                            minWidth: double.infinity,
                            child: Text(
                              "Entrar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () {},
                          )
                        ],
                      )),
                    ],
                  )),
                ],
              ),
            ),
    );
  }
}

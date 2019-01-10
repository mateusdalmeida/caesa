import 'package:flutter/material.dart';
import 'package:caesa/services/api.dart' as api;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int controller = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: 2, initialIndex: controller);

    // Chama a tela de "aguardar"
    api.getClientes(123).then((result) {
      // repara que aqui eu não utilizei o await, porque a função initState não pode ser async
      // por isso usei .then (parecido com o js da vida)
      print(result[0].nome);
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
                                        color: controller == 0
                                            ? Colors.grey[200]
                                            : Colors.blue,
                                        width: 2))),
                          ),
                          onTap: () {
                            _tabController.animateTo(0);
                            setState(() {
                              controller = 1;
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
                                        color: controller == 0
                                            ? Colors.blue
                                            : Colors.grey[200],
                                        width: 2))),
                          ),
                          onTap: () {
                            _tabController.animateTo(1);
                            setState(() {
                              controller = 0;
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
                      Form(
                        child: TextFormField(
                          autofocus: true,
                          decoration: InputDecoration(
                              hintText: "Insira sua Matricula aqui",
                              labelText: "Matricula"),
                        ),
                      ),
                      Form(
                        child: TextFormField(
                          autofocus: true,
                          decoration: InputDecoration(
                              hintText: "Insira seu CPF Aqui",
                              labelText: "CPF"),
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                    child: RaisedButton(
                      child: Text("Entrar"),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

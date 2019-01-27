import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:caesa/models/debito.dart';
import 'package:caesa/models/cliente.dart';

const baseUrl = 'http://192.168.2.203:3000/';

Future<List<Cliente>> getClientes({int inscricao, String cpf}) async {
  //var response;
  //if(inscricao != null)
    final response = await http.get("$baseUrl/api/cliente/matricula/dados/$inscricao"); 
   //else if (cpf != null)
    //response = await http.get("$baseUrl/api/cliente/cpf/dados/$cpf");

  print(response);
  List<Cliente> clientes = new List();

  // clientes.add(Cliente(
  //     inscricao: 25,
  //     nome: "Anderson",
  //     numeroPorta: "305",
  //     categoria: 02,
  //     idLogradouro: 12,
  //     cidade: 201));

  // await Future.delayed(Duration(seconds: 5));
  // return clientes;

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    for (var despesa in responseJson['data']) {
      Cliente des = Cliente.fromJson(despesa);
      clientes.add(des);
    }
    return clientes;
  } else {
    print("${response.statusCode}");
    return clientes;
  }
}

Future<List<Debito>> getDebito(int inscricao) async {
  List<Debito> debitos = new List();
  debitos.add(Debito(
      refFaturamento: 12,
      dataVencimento: 203,
      valorTotal: 13.5,
      volume: 26.9,
      origem: 95));

  await Future.delayed(Duration(seconds: 5));
  return debitos;
}

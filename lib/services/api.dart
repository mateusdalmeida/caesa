import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:caesa/models/debito.dart';
import 'package:caesa/models/cliente.dart';

//const baseUrl = 'http://192.168.0.1/';

List<Cliente> getCliente(){
  List<Cliente> clientes = new List();
  clientes.add(Cliente(inscricao: 25, nome: "Anderson", numeroPorta: "Teste", categoria: 30, idLogradouro: 12, cidade: 32));
  return clientes;
}

List<Debito> getDebito(){
  List<Debito> debitos = new List();
  debitos.add(Debito(refFaturamento: 12, dataVencimento: 203, valorTotal: 13.5, volume: 26.9, origem: 95));
  debitos.add(Debito(refFaturamento: 12, dataVencimento: 203, valorTotal: 13.5, volume: 26.9, origem: 95));
  return debitos;
}


// Future<List<Cliente>> getClientes(int inscricao) async {
//   final response = await http.get("$baseUrl/api/cliente/matricula/dados/$inscricao");
//   List<Cliente> cliente = new List();

//   cliente.add(Cliente(inscricao: 25, nome: "Anderson", numeroPorta: "305", categoria: 02, idLogradouro: 12, cidade: 201));


//   if (response.statusCode == 200) {
//     var responseJson = json.decode(response.body);
//     for (var despesa in responseJson['data']) {
//       Cliente des = Cliente.fromJson(despesa);
//       cliente.add(des);
//     }
//     return cliente;
//   } else {
//     print("${response.statusCode}");
//     return cliente;
//   }
// }
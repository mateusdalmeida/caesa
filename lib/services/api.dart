import 'package:caesa/models/debito.dart';
import 'package:caesa/models/cliente.dart';

List<Cliente> getCliente(){
  List<Cliente> clientes = new List();
  clientes.add(Cliente(inscricao: 25, nome: "Anderson", complemento: "Teste", categoria: 30, idLogradouro: 12, cidade: 32, cpf: "dsadsadsa"));
  clientes.add(Cliente(inscricao: 25, nome: "Anderson", complemento: "Teste", categoria: 30, idLogradouro: 12, cidade: 32, cpf: "dsadsadsa"));
  clientes.add(Cliente(inscricao: 25, nome: "Anderson", complemento: "Teste", categoria: 30, idLogradouro: 12, cidade: 32, cpf: "dsadsadsa"));
  clientes.add(Cliente(inscricao: 25, nome: "Anderson", complemento: "Teste", categoria: 30, idLogradouro: 12, cidade: 32, cpf: "dsadsadsa"));
  return clientes;
}

List<Debito> getDebito(){
  List<Debito> debitos = new List();
  debitos.add(Debito(refFaturamento: 12, dataVencimento: 203, valorTotal: 13.5, volume: 26.9, origem: 95));
  debitos.add(Debito(refFaturamento: 12, dataVencimento: 203, valorTotal: 13.5, volume: 26.9, origem: 95));
  return debitos;
}

//  int refFaturamento;
//   int dataVencimento;
//   double valorTotal;
//   double volume;
//   int origem;
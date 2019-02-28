import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:caesa/models/debito.dart';
import 'package:caesa/models/cliente.dart';
import 'package:caesa/models/pagamento.dart';

const baseUrl = 'http://192.168.2.203:3000/api';

var year = DateTime.now().year.toString();
var month = DateTime.now().month.toString().padLeft(2, '0');
var day = DateTime.now().day.toString().padLeft(2, '0');

int dataAtual = int.parse("$year$month$day");

//int dataAtual = 20180101;

Future<List<Cliente>> getClientes({int inscricao, String cpf}) async {
  var response;
  int secondsTimeout = 3;
  // O try catch é responsável por verificar o tempo necessário pra fazer a requisição
  // e retornar null quando o tempo for estourado
  try {
    if (inscricao != null)
      response = await http
          .get("$baseUrl/cliente/matricula/dados/$inscricao")
          .timeout(Duration(seconds: secondsTimeout));
    else if (cpf != null)
      response = await http
          .get("$baseUrl/cliente/cpf/dados/$cpf")
          .timeout(Duration(seconds: secondsTimeout));
  } on TimeoutException catch (e) {
    print(e);
    // Ao dar timeout, o Future retorna null
    return null;
  }

  List<Cliente> clientes = new List();

  // await Future.delayed(Duration(seconds: 5));
  // return clientes;

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    //print(responseJson);
    for (var despesa in responseJson) {
      Cliente des = Cliente.fromJson(despesa);
      String urlDadosEndereco = "$baseUrl/logradouro/dados/${des.inscricao}";
      var responseDados = await http.get(urlDadosEndereco);
      var responseDadosJson = json.decode(responseDados.body);
      //print(responseDadosJson);
      des.endereco = responseDadosJson[0]['NOME'];
      //matriculasPegas[matricula].CDG_CATEGORIA = resultJson[0].CDG_CATEGORIA
      //matriculasPegas[matricula].COMPLEMENTO = resultJson[0].COMPLEMENTO
      //matriculasPegas[matricula].CDG_CIDADE = resultJson[0].CDG_CIDADE
      clientes.add(des);
    }
    return clientes;
  } else {
    print("${response.statusCode}");
    return clientes;
  }
}

Future<List<Debito>> getDebitos(matricula) async {
  var response;
  int secondsTimeout = 3;
  try {
    response = await http
        .get("$baseUrl/debitos/dados/$matricula")
        .timeout(Duration(seconds: secondsTimeout));
  } on TimeoutException catch (e) {
    print(e);
    // Ao dar timeout, o Future retorna null
    return null;
  }

  List<Debito> debitos = new List();

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);

    String urlDadosDebito = "$baseUrl/pagamentos/dados/$matricula";
    var responseDados = await http.get(urlDadosDebito);
    var responseDadosJson = json.decode(responseDados.body);

    for (var debito in responseJson) {
      Debito debt = Debito.fromJson(debito);
      debt.inscricao = matricula;
      //nesse caso não existe retorno, logo nenhuma fatura foi paga
      if (responseDadosJson.length == 0) {
        debt.status = "Vencida";
      }
      //percorre os dados de pagamento e compara com a fatura
      for (var faturaPaga in responseDadosJson) {
        Pagamento pgmt = Pagamento.fromJson(faturaPaga);
        if (debt.refFaturamento == pgmt.refFaturamento) {
          debt.status = "Pago";
          break;
        } else {
          debt.status = "Pagar";
        }
      }
      //compara as faturas que não foram pagas com a data atual
      //para determinar as atrasadas
      if (debt.status == "Pagar" && debt.dataVencimento <= dataAtual) {
        debt.status = "Vencida";
      }
      debitos.add(debt);
    }
    return debitos;
  } else {
    print(response.statusCode);
    return debitos;
  }
}

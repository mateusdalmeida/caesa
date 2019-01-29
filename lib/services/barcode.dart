import 'package:flutter/services.dart';

geraCodigo(tipoRetorno, valorPagar1, matricula1, mesReferencia1, origem1) {
  String banco = '826';
  var dvGeral;
  String valorPagar =
      valorPagar1.toStringAsFixed(2).replaceAll('.', '').padLeft(11, '0');
  String empresa = '00070';
  String matricula = matricula1.toString().padLeft(6, '0');
  String mesReferencia = mesReferencia1.toString();
  String origem = origem1.toString();
  String campoLivre = '0000000001';
  var dv1;
  var dv2;
  var dv3;
  var dv4;

  var calculoDvGeral = banco +
      valorPagar +
      empresa +
      matricula +
      mesReferencia +
      origem +
      campoLivre;
  dvGeral = _calculaDigitoMod10(calculoDvGeral);

  var parte1 = calculoDvGeral.substring(0, 3);
  var parte2 = calculoDvGeral.substring(3, 43);
  var codigoSemDv = parte1 + dvGeral + parte2;

  var sub1 = codigoSemDv.substring(0, 11);
  dv1 = _calculaDigitoMod10(sub1);
  var sub2 = codigoSemDv.substring(11, 22);
  dv2 = _calculaDigitoMod10(sub2);
  var sub3 = codigoSemDv.substring(22, 33);
  dv3 = _calculaDigitoMod10(sub3);
  var sub4 = codigoSemDv.substring(33, 44);
  dv4 = _calculaDigitoMod10(sub4);

  if (tipoRetorno == 'copia') {
    String codigoCompletoCopia = "$sub1$dv1$sub2$dv2$sub3$dv3$sub4$dv4";
    Clipboard.setData(ClipboardData(text: codigoCompletoCopia));
    //print(codigoCompletoCopia);
    //return codigoCompletoCopia;
  } else if (tipoRetorno == 'boleto') {
    return "$sub1-$dv1 $sub2-$dv2 $sub3-$dv3 $sub4-$dv4";
  } else if (tipoRetorno == 'barcode') {
    return "$sub1$sub2$sub3$sub4";
  }
}

_calculaDigitoMod10(String dado) {
  var i;
  var mult = 2;
  var soma = 0;
  var s = "";

  for (i = dado.length - 1; i >= 0; i--) {
    s = (mult * int.parse(dado[i])).toString() + s;
    if (--mult < 1) {
      mult = 2;
    }
  }
  for (i = 0; i < s.length; i++) {
    soma = soma + int.parse(s[i]);
  }
  soma = soma % 10;
  if (soma != 0) {
    soma = 10 - soma;
  }
  return soma.toString();
}

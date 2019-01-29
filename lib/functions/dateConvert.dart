String dateConvert(String data) {
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
  String ano = data.substring(0, 4);
  String mes = data.substring(4, 6);
  if (data.length == 6) {  
    mes = (int.parse(mes) - 1).toString();
    return "${meses[int.parse(mes)]} $ano";
  } else {
    String dia = data.substring(6, 8);
    return "$dia/$mes/$ano";
  }
}

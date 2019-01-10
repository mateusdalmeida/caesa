class Pagamento{
  int refFaturamento;
  int inscricao;

  Pagamento({this.refFaturamento, this.inscricao});

  factory Pagamento.fromJson(Map<String,dynamic>json) {
    return Pagamento(
      inscricao: json['INSCRICAO'],
      refFaturamento: json['REF_FATUR']
      );
  }
}
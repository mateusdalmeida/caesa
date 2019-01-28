class Debito {
  int inscricao;
  int refFaturamento;
  int dataVencimento;
  var valorTotal;
  int volume;
  int origem;
  String status;

  Debito(
      {this.inscricao,
      this.refFaturamento,
      this.dataVencimento,
      this.valorTotal,
      this.volume,
      this.origem,
      this.status});

  factory Debito.fromJson(Map<String, dynamic> json) {
    return Debito(
        refFaturamento: json['REF_FATUR'],
        dataVencimento: json['DATA_VENCIMENTO'],
        valorTotal: json['VALOR_TOTAL'],
        volume: json['VOL_FATURADO'],
        origem: json['ORIGEM']);
  }
}

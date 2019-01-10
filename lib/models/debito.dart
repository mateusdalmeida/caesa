class Debito {
  int refFaturamento;
  int dataVencimento;
  double valorTotal;
  double volume;
  int origem;

  Debito(
      {this.refFaturamento,
      this.dataVencimento,
      this.valorTotal,
      this.volume,
      this.origem});

  factory Debito.fromJson(Map<String, dynamic> json) {
    return Debito(
        refFaturamento: json['REF_FATUR'],
        dataVencimento: json['DATA_VENCIMENTO'],
        valorTotal: json['VALOR_TOTAL'],
        volume: json['VOL_FATURADO'],
        origem: json['ORIGEM']);
  }
}

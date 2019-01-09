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
        refFaturamento: json['refFaturamento'],
        dataVencimento: json['dataVencimento'],
        valorTotal: json['valorTotal'],
        volume: json['volume'],
        origem: json['origem']);
  }
}

class Cliente {
  int inscricao;
  String nome;
  String complemento;
  int categoria;
  int idLogradouro;
  int cidade;
  String cpf;

  Cliente(
      {this.inscricao,
      this.nome,
      this.complemento,
      this.categoria,
      this.idLogradouro,
      this.cidade,
      this.cpf});

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
        inscricao: json['inscricao'],
        nome: json['nome'],
        complemento: json['complemento'],
        categoria: json['categoria'],
        idLogradouro: json['idLogradouro'],
        cidade: json['cidade'],
        cpf: json['cpf']);
  }
}

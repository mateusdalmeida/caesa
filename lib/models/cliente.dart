class Cliente {
  int inscricao;
  String nome;
  String numeroPorta;
  int categoria;
  int idLogradouro;
  int cidade;
  //tirei pq o dado nunca é armazenado
  //String cpf;

  Cliente(
      {this.inscricao,
      this.nome,
      this.numeroPorta,
      this.categoria,
      this.idLogradouro,
      this.cidade,
      //this.cpf
      });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
        inscricao: json['INSCRICAO'],
        nome: json['NOME'],
        numeroPorta: json['COMPLEMENTO'],
        categoria: json['CDG_CATEGORIA'],
        idLogradouro: json['CDG_LOGRA'],
        cidade: json['CDG_CIDADE'],
        //cpf: json['cpf']
        );
  }
}

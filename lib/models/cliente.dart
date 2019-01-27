class Cliente {
  int inscricao;
  String nome;
  String numeroPorta;
  String categoria;
  int idLogradouro;
  String cidade;
  String endereco;

  Cliente(
      {this.inscricao,
      this.nome,
      this.numeroPorta,
      this.categoria,
      this.idLogradouro,
      this.cidade,
      this.endereco
      });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    //exibir dados humanos na categoria
    switch (json['CDG_CATEGORIA']){
      case 0:
        json['CDG_CATEGORIA'] = 'Erro';
        break;
      case 1:
        json['CDG_CATEGORIA'] = 'Residencial';
        break;
      case 2:
        json['CDG_CATEGORIA'] = 'Empresarial';
        break;
      case 3:
        json['CDG_CATEGORIA'] = 'Descobrir';
        break;
      case 4:
        json['CDG_CATEGORIA'] = 'Governamental';
        break;
    }

    switch (json['CDG_CATEGORIA']){
      case 201:
        json['CDG_CIDADE'] = 'Macapá';
        break;
      case 579:
        json['CDG_CIDADE'] = 'Santana';
        break;
      default:
        json['CDG_CIDADE'] = json['CDG_CIDADE'].toString();
    }

    return Cliente(
        inscricao: json['INSCRICAO'],
        nome: json['NOME'],
        numeroPorta: json['COMPLEMENTO'],
        categoria: json['CDG_CATEGORIA'],
        idLogradouro: json['CDG_LOGRA'],
        cidade: json['CDG_CIDADE'],
        );
  }
}

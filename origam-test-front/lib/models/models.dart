class Person {
  String nomesobrenome;
  String profissao;
  String cidadeEstado;
  String urlImages;
  String dataHora;

  Person({
    required this.nomesobrenome,
    required this.profissao,
    required this.cidadeEstado,
    required this.urlImages,
    required String dataHora,
  }) : dataHora = dataHora.isNotEmpty
            ? dataHora
            : DateTime.now().toString(); // Atribui a data e hora atual se dataHora estiver vazia


  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      nomesobrenome: json['nomesobrenome'],
      profissao: json['profissao'],
      cidadeEstado: json['cidadeEstado'],
      urlImages: json['urlImages'],
      dataHora: json['dataHora'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nomesobrenome': nomesobrenome,
      'profissao': profissao,
      'cidadeEstado': cidadeEstado,
      'urlImages': urlImages,
      'dataHora': dataHora,
    };
  }
}


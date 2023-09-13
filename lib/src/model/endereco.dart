class Endereco {
  String pais;
  String provincia;
  String ruaAv;
  String bairro;
  String descricao;
  Endereco(
      {this.pais = "",
      this.provincia = "",
      this.ruaAv = "",
      this.bairro = "",
      this.descricao = ""});

  Map<String, dynamic> toJson() => {
        'pais': pais,
        'provincia': provincia,
        'ruaAv': ruaAv,
        'bairro': bairro,
        'decricao': descricao,
      };

  factory Endereco.fromJson(Map<String, dynamic> json) => Endereco(
        bairro: json['bairro'],
        descricao: json['descricao'],
        pais: json['pais'],
        provincia: json['provincia'],
        ruaAv: json['ruaAv'],
      );
}

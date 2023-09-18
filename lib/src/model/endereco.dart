class Endereco {
  String pais;
  String provincia;
  String ruaAv;
  String bairro;
  String descricao;
  String? latitude;
  String? longitude;
  Endereco({
    this.pais = "",
    this.provincia = "",
    this.ruaAv = "",
    this.bairro = "",
    this.descricao = "",
    this.latitude = "",
    this.longitude = "",
  });

  Map<String, dynamic> toJson() => {
        'pais': pais,
        'provincia': provincia,
        'ruaAv': ruaAv,
        'bairro': bairro,
        'decricao': descricao,
        'latitude': latitude,
        'longitude': longitude,
      };

  factory Endereco.fromJson(Map<String, dynamic> json) => Endereco(
        bairro: json['bairro'],
        descricao: json['descricao'],
        pais: json['pais'],
        provincia: json['provincia'],
        ruaAv: json['ruaAv'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
}

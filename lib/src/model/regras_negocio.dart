/// *
///

/// Modelo RegraPrecoDesconto

///

/// Verificar se algum artigo possui algum desconto ou novo preco diferente dos PVP's

class RegraPrecoDesconto {
  String? encomenda;
  int? regra;
  String? artigo;
  String? cliente;
  bool? validade;
  String? dataInicial;
  String? dataFinal;
  double preco;
  int tipoPreco;
  double desconto;

  static const int REGRA_ARTIGO = 1;
  static const int REGRA_CLIENTE = 4;
  static const int REGRA_CLIENTE_ARTIGO = 6;

  RegraPrecoDesconto(
      {this.regra,
      this.artigo,
      this.cliente,
      this.validade,
      this.dataInicial,
      this.dataFinal,
      this.preco = 0,
      this.tipoPreco = 0,
      this.desconto = 0,
      this.encomenda});

  factory RegraPrecoDesconto.fromMap(Map<String, dynamic> json) =>
      RegraPrecoDesconto(
        regra: int.parse(json['regra']),
        artigo: json['artigo'],
        cliente: json['cliente'],
        preco: json['preco'].toDouble(),
        validade: json['validade'] == 1 ? true : false,
        dataInicial: json['dataInicial'],
        dataFinal: json['dataFinal'],
        tipoPreco: json['tipoPreco'].toInt(),
        desconto: json['desconto'],
        encomenda: json['encomenda'],
      );

  factory RegraPrecoDesconto.fromJson(Map<String, dynamic> json) {
    return RegraPrecoDesconto(
      regra: int.parse(json['regra'].toString()),
      artigo: json['artigo'],
      cliente: json['cliente'],
      preco:
          double.tryParse(json['preco'].toString().replaceAll(",", ".")) ?? 0,
      validade: json['validade'] == 1 ? true : false,
      dataInicial: json['dataInicial'],
      dataFinal: json['dataFinal'],

      tipoPreco: int.parse(json['tipoPreco'].toString()),
      //  imagemBuffer:  data['imagemBuffer'] ,
      desconto: double.tryParse(json['desconto'].toString()) ?? 0,
      encomenda: json['encomenda'] ?? "",
    );
  }

  /// verificar se a data actual esta no intervalo do perido do desconto ou novo preco

  /// de um determinado artigo

  bool isDataNoIntervalo() {
    return false;
  }

/*
 * 
 *  Verificar se a regra possui validade e se  ainda é aplicavel
 * 
 */
  bool isRegraDataValido() {
    return false;
  }

  Map<String, dynamic> toJson() => {
        'regra': regra,
        'artigo': artigo,
        'cliente': cliente,
        'preco': preco,
        'validade': validade,
        'dataInicial': dataInicial,
        'dataFinal': dataFinal,
        'tipoPreco': tipoPreco,
        'desconto': desconto,
        'encomenda': encomenda,
      };
}

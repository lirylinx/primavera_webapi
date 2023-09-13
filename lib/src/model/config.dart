import 'dart:convert';

// modelo para configuração da primavera webapi no servidor
class ConfigWebapi {
  final String baseUrl;
  final String company;
  final String instance;
  final String grantType;
  final String line;

  ConfigWebapi(
      {required this.baseUrl,
      required this.company,
      required this.instance,
      required this.grantType,
      required this.line});

  String toJson() {
    return jsonEncode({
      'baseUrl': baseUrl,
      'company': company,
      'instance': instance,
      'grant_type': grantType,
      'line': line,
    });
  }
}

// modelo para configuração do POS
class ConfigPos {
  final String vendaDoc;
  final int vendaSerie;
  final String encomendaDoc;
  final int encomendaSerie;
  final String posCaixaPosto;

  ConfigPos(
      {required this.vendaDoc,
      required this.vendaSerie,
      required this.encomendaDoc,
      required this.encomendaSerie,
      required this.posCaixaPosto});

  String toJson() {
    return jsonEncode({
      'vendaDoc': vendaDoc,
      'vendaSerie': vendaSerie,
      'encomendaDoc': encomendaDoc,
      'encomendaSerie': encomendaSerie,
      'posCaixaPosto': posCaixaPosto,
    });
  }
}

class ConfigSessao {
  final String accessToken;
  final String tokenType;
  final String expireIn;

  ConfigSessao(
      {required this.accessToken,
      required this.tokenType,
      required this.expireIn});
}
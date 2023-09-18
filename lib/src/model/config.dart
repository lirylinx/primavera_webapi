import 'dart:convert';

// modelo para configuração da primavera webapi no servidor
class ConfigWebapi {
  final String company;
  final String instance;
  final String grantType;
  final String line;

  ConfigWebapi(
      {required this.company,
      this.instance = 'default',
      required this.grantType,
      required this.line});

  @override
  String toString() => jsonEncode({
        'company': company,
        'instance': instance,
        'grant_type': grantType,
        'line': line,
      });

  Map<String, dynamic> toJson() => {
        'company': company,
        'instance': instance,
        'grant_type': grantType,
        'line': line,
      };
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

class ConfigTokenSessao {
  final String accessToken;
  final String tokenType;
  final int expireIn;

  ConfigTokenSessao(
      {required this.accessToken,
      required this.tokenType,
      required this.expireIn});

  factory ConfigTokenSessao.fromJson(Map<String, dynamic> data) {
    ConfigTokenSessao _token = ConfigTokenSessao(
        accessToken: data['access_token'],
        tokenType: data['token_type'],
        expireIn: data['expires_in']);

    return _token;
  }

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'token_type': tokenType,
        'expires_in': expireIn
      };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class ConfigServidor {
  final String ip;
  final int porta;

  ConfigServidor(this.ip, this.porta);

  @override
  String toString() {
    return '$ip:$porta';
  }
}

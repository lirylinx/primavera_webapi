// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

class ArtigoLote {
  String? artigo;
  String? lote;
  String? descricao;
  DateTime? dataFabrico;
  DateTime? dataValidade;
  bool? activo;
  double? quantidadeStock;
  String? armazem;
  String? localizacao;

  ArtigoLote(
      {this.artigo,
      this.lote,
      this.descricao,
      this.dataFabrico,
      this.dataValidade,
      this.activo,
      this.quantidadeStock,
      this.armazem,
      this.localizacao});

  Map<String, dynamic> toJson() => {
        'lote': lote,
        'artigo': artigo,
        'descricao': descricao,
        'dataFabrico': dataFabrico == null
            ? dataValidade.toString()
            : dataFabrico.toString(),
        'dataValidade': dataValidade.toString(),
        'activo': activo,
      };

  factory ArtigoLote.fromJson(Map<String, dynamic> json) {
    return ArtigoLote(
        lote: json['lote'],
        artigo: json['artigo'],
        descricao: json['descricao'],
        dataFabrico:
            json['dataFabrico'] != null && json['dataValidade'] != 'null'
                ? DateTime.parse(json['dataFabrico'])
                : null,
        dataValidade:
            json['dataValidade'] != null && json['dataValidade'] != 'null'
                ? DateTime.parse(json['dataValidade'])
                : null,
        activo: json['activo'],
        quantidadeStock: json['quantidadeStock'] != null
            ? double.parse(json['quantidadeStock'].toString())
            : 0,
        armazem: json['armazem'],
        localizacao: json['localizacao']);
  }

  static List<ArtigoLote> parseArtigos(String response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();

    return parsed.map<ArtigoLote>((json) => ArtigoLote.fromJson(json)).toList();
  }

  // static Future<http.Response?> httpPost(ArtigoLote artigoLote) async {
  //   Map<String, dynamic> parsed = await SessaoApiProvider.readSession();
  //   String protocolo = 'http://';
  //   String host = parsed['ip_local'] + ':' + parsed['porta'];
  //   String rota = '/WebApi/ArtigoController/Lote/' + artigoLote.artigo!;
  //   var url = protocolo + host + rota;
  //   http.Response response;

  //   // ArtigoLote _lote = new ArtigoLote(
  //   //     artigo: "CER0753L",
  //   //     lote: "2M2021/005",
  //   //     descricao: "LOTE 2M2021/005",
  //   //     dataFabrico: new DateTime(2021, 6, 22),
  //   //     dataValidade: new DateTime(2023, 6, 22),
  //   //     activo: true);

  //   try {
  //     String body = json.encode(artigoLote.toJson());

  //     var sessao = await SessaoApiProvider.readSession();
  //     if (sessao == null || sessao.length == 0) {
  //       print('Ficheiro sessão não existe');
  //       return null;
  //     } else {
  //       String token = sessao['access_token'];
  //       response = await http.post(Uri.http(url, ''),
  //           headers: {
  //             "Authorization": "Bearer $token",
  //             "Accept": "application/json"
  //           },
  //           body: body);
  //     }
  //   } catch (e) {
  //     throw e;

  //     // return 3;
  //   }

  //   return response;
  // }

  bool isReadyToPost() {
    try {
      if (artigo!.isNotEmpty && lote!.isNotEmpty && descricao!.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // static Future<Map<String, List<ArtigoLote>>> httpGet() async {
  //   Map<String, dynamic> parsed = await SessaoApiProvider.readSession();
  //   String protocolo = 'http://';
  //   String host = parsed['ip_local'] + ':' + parsed['porta'];
  //   String rota = '/WebApi/ArtigoController/Artigo/lista/loteStock';
  //   var url = protocolo + host + rota;
  //   http.Response response;

  //   // ArtigoLote _lote = new ArtigoLote(
  //   //     artigo: "CER0753L",
  //   //     lote: "2M2021/005",
  //   //     descricao: "LOTE 2M2021/005",
  //   //     dataFabrico: new DateTime(2021, 6, 22),
  //   //     dataValidade: new DateTime(2023, 6, 22),
  //   //     activo: true);
  //   if (mapaListaLote.isEmpty) {
  //     try {
  //       var sessao = await SessaoApiProvider.readSession();
  //       if (sessao == null || sessao.length == 0) {
  //         print('Ficheiro sessão não existe');
  //         return Map();
  //       } else {
  //         String token = sessao['access_token'];
  //         response = await http.get(
  //           Uri.http(url, ''),
  //           headers: {
  //             "Authorization": "Bearer $token",
  //             "Accept": "application/json"
  //           },
  //         );
  //       }
  //     } catch (e) {
  //       throw e;

  //       // return 3;
  //     }

  //     if (response.statusCode == 200) {
  //       dynamic data = json.decode(response.body);
  //       mapaListaLote.clear();
  //       data = json.decode(data)["DataSet"]["Table"];
  //       for (dynamic lote in data) {
  //         ArtigoLote _artigoLote = ArtigoLote.fromJson(lote);

  //         if (mapaListaLote[_artigoLote.artigo] == null)
  //           mapaListaLote[_artigoLote.artigo!] = <ArtigoLote>[];

  //         mapaListaLote[_artigoLote.artigo]?.add(_artigoLote);
  //       }
  //     } else if (response.statusCode == 401) {
  //       await SessaoApiProvider.refreshToken();

  //       return await httpGet();
  //     } else {
  //       mapaListaLote = Map();
  //     }
  //   }
  //   return mapaListaLote;
  // }

  // static Future<Map<String, List<ArtigoLote>>> httpGetLoteStock(
  //     {bool activo = false, bool sincronizar = false}) async {
  //   dynamic data = await getCacheData('lote');

  //   if (!sincronizar && data != null) {
  //     data = json.decode(data);

  //     for (dynamic keys in data.keys) {
  //       for (dynamic value in data[keys]) {
  //         ArtigoLote _artigoLote = ArtigoLote.fromJson(value);
  //         if (mapaListaLote[_artigoLote.artigo] == null)
  //           mapaListaLote[_artigoLote.artigo!] = <ArtigoLote>[];

  //         bool existe = false;
  //         mapaListaLote[_artigoLote.artigo]?.forEach((element) {
  //           if (element != null && element.lote == _artigoLote.lote)
  //             existe = true;
  //         });
  //         if (!existe) mapaListaLote[_artigoLote.artigo]?.add(_artigoLote);
  //         existe = false;
  //       }
  //     }

  //     return mapaListaLote;
  //   }
  //   Map<String, dynamic> parsed = await SessaoApiProvider.readSession();
  //   String protocolo = 'http://';
  //   String host = parsed['ip_local'] + ':' + parsed['porta'];
  //   String rota = activo == true
  //       ? '/WebApi/ArtigoController/Artigo/lista/loteStockActivo'
  //       : '/WebApi/ArtigoController/Artigo/lista/loteStockActivo';
  //   var url = protocolo + host + rota;
  //   http.Response response;

  //   // ArtigoLote _lote = new ArtigoLote(
  //   //     artigo: "CER0753L",
  //   //     lote: "2M2021/005",
  //   //     descricao: "LOTE 2M2021/005",
  //   //     dataFabrico: new DateTime(2021, 6, 22),
  //   //     dataValidade: new DateTime(2023, 6, 22),
  //   //     activo: true);
  //   try {
  //     var sessao = await SessaoApiProvider.readSession();
  //     if (sessao == null || sessao.length == 0) {
  //       print('Ficheiro sessão não existe');
  //       return Map();
  //     } else {
  //       String token = sessao['access_token'];
  //       response = await http.get(
  //         Uri.http(url, ''),
  //         headers: {
  //           "Authorization": "Bearer $token",
  //           "Accept": "application/json"
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     throw e;

  //     // return 3;
  //   }

  //   if (response.statusCode == 200) {
  //     dynamic data = json.decode(response.body);
  //     removeKeyCacheData("lote");
  //     data = json.decode(data)["DataSet"]["Table"];
  //     for (dynamic lote in data) {
  //       ArtigoLote _artigoLote = ArtigoLote.fromJson(lote);

  //       if (mapaListaLote[_artigoLote.artigo] == null)
  //         mapaListaLote[_artigoLote.artigo!] = <ArtigoLote>[];

  //       bool existe = false;
  //       mapaListaLote[_artigoLote.artigo]?.forEach((element) {
  //         if (element != null && element.lote == _artigoLote.lote)
  //           existe = true;
  //       });
  //       if (!existe) mapaListaLote[_artigoLote.artigo]?.add(_artigoLote);
  //       existe = false;
  //     }
  //     await saveCacheData("lote", mapaListaLote);
  //   } else if (response.statusCode == 401) {
  //     await SessaoApiProvider.refreshToken();

  //     return await httpGet();
  //   } else {
  //     mapaListaLote = Map();
  //   }
  //   return mapaListaLote;
  // }

  @override
  String toString() =>
      'ArtigoLote { artigo: $artigo , lote: $lote, descricao: $descricao, lote: $lote, dataFabrico: $dataFabrico, dataValidade: $dataValidade}';
}

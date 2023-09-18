import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'artigo_armazem.dart';

// ignore: must_be_immutable
class Artigo extends Equatable {
  String? artigo;
  String? descricao;
  double preco;
  double quantidade;
  double quantidadeStock;
  double civa;
  double iva;
  String? unidade;
  double pvp1;
  bool pvp1Iva;
  double pvp2;
  bool pvp2Iva;
  double pvp3;
  bool pvp3Iva;
  double pvp4;
  bool pvp4Iva;
  double pvp5;
  bool pvp5Iva;
  double pvp6;
  bool pvp6Iva;
  Uint8List? imagemBuffer;
  String? imagemBufferStr;
  String? codigoBarra;
  List<ArtigoArmazem>? artigoArmazem = <ArtigoArmazem>[];

  Artigo(
      {this.artigo,
      this.descricao,
      this.preco = 0,
      this.quantidade = 0,
      this.quantidadeStock = 0,
      this.civa = 0,
      this.iva = 0,
      this.unidade,
      this.pvp1 = 0,
      this.pvp1Iva = false,
      this.pvp2 = 0,
      this.pvp2Iva = false,
      this.pvp3 = 0,
      this.pvp3Iva = false,
      this.pvp4 = 0,
      this.pvp4Iva = false,
      this.pvp5 = 0,
      this.pvp5Iva = false,
      this.pvp6 = 0,
      this.pvp6Iva = false,
      this.imagemBuffer,
      this.imagemBufferStr,
      this.codigoBarra,
      this.artigoArmazem});

  Map<String, dynamic> toJson() => {
        'artigo': artigo,
        'descricao': descricao,
        'preco': preco,
        'quantidadeStock': quantidadeStock,
        'quantidade': quantidade,
        'civa': civa,
        'iva': iva,
        'unidade': unidade,
        'imagemBuffer': imagemBuffer,
        'pvp1': pvp1,
        'pvp1Iva': pvp1Iva == true ? 1 : 0,
        'pvp2': pvp2,
        'pvp2Iva': pvp2Iva == true ? 1 : 0,
        'pvp3': pvp3,
        'pvp3Iva': pvp3Iva == true ? 1 : 0,
        'pvp4': pvp4,
        'pvp4Iva': pvp4Iva == true ? 1 : 0,
        'pvp5': pvp5,
        'pvp5Iva': pvp5Iva == true ? 1 : 0,
        'pvp6': pvp6,
        'pvp6Iva': pvp6Iva == true ? 1 : 0,
        'artigoArmazem': listaArmazemToJson()
      };

  Map<String, dynamic> imagemToMap() =>
      {'artigo': artigo, 'imagemBuffer': imagemBuffer};
//  double.parse(         data['totalStock'].toString() ) ?? data['quantidadeStock'].toString()

  factory Artigo.fromJson(Map<String, dynamic> data) {
    Artigo artigo = Artigo(
      artigo: data['artigo'],
      descricao: data['descricao'],
      preco: data['pvp1'],
      quantidade: data['quantidade'] ?? 0.0,
      quantidadeStock: double.parse(data['quantidadeStock'].toString()),
      civa: 1.0,
      iva: double.parse(data['iva'].toString()),
      unidade: data['unidade'],
      pvp1: data['pvp1'],
      pvp1Iva: true,
      pvp2: data['pvp2'],
      pvp2Iva: true,
      pvp3: data['pvp3'],
      pvp3Iva: true,
      pvp4: data['pvp4'],
      pvp4Iva: true,
      pvp5: data['pvp5'],
      pvp5Iva: true,
      pvp6: data['pvp6'] ?? 0,
      pvp6Iva: true,
      imagemBuffer: Uint8List(0),
      codigoBarra: data['codigoBarra'] ?? "",
      artigoArmazem: [],
      imagemBufferStr: '',
    );
    List armazens = data['artigoArmazem'] ?? [];
    if (armazens.isNotEmpty) {
      for (var element in armazens) {
        ArtigoArmazem armazem = ArtigoArmazem.fromJson(element);
        if (artigo.artigoArmazem != null) {
          artigo.artigoArmazem?.add(armazem);
        } else {
          artigo.artigoArmazem = <ArtigoArmazem>[];
          artigo.artigoArmazem?.add(armazem);
        }
      }
    } else {
      ArtigoArmazem armazem = ArtigoArmazem.fromJson(data);
      if (artigo.artigoArmazem != null) {
        artigo.artigoArmazem?.add(armazem);
      } else {
        artigo.artigoArmazem = <ArtigoArmazem>[];
        artigo.artigoArmazem?.add(armazem);
      }
    }

    return artigo;
  }

  // Converter dados json em objeto
  static List<Artigo> parseArtigos(String response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    return parsed.map<Artigo>((json) => Artigo.fromJson(json)).toList();
  }

  @override
  String toString() => 'Artigo { id: $artigo }';

  // verificar se o artigo currente possui o mesmo codigo de barra que o do parametro
  bool existeArtigoByCodigoBarra(String codigoBarra) {
    if (this.codigoBarra != null || this.codigoBarra == codigoBarra) {
      return true;
    } else {
      return false;
    }
  }

  // Instanciar objecto ArtigoArmazem e armazenar na lista de artigoArmazem
  void addArtigoArmazem(Map<String, dynamic> data) {
    ArtigoArmazem armazem = ArtigoArmazem.fromJson(data);
    bool existe = false;
    artigoArmazem?.forEach((element) {
      if (element.localizacao == armazem.localizacao &&
          element.lote == armazem.lote &&
          element.armazem == armazem.armazem) {
        existe = true;
        return;
      }
    });
    if (!existe) artigoArmazem?.add(armazem);
  }

  // Percorrer a lista de artigo e retornar o artigo pretendido
  // static Artigo getArtigo(List<dynamic> lstArtigo, String artigo) {
  //   Artigo _artigo = Artigo();
  //   lstArtigo.forEach((e) {
  //     Artigo element = Artigo.fromJson(e);
  //     if (element.artigo == artigo) {
  //       _artigo = element;
  //       if (mapaListaLote.isNotEmpty)
  //         _artigo.artigoArmazem = getArtigoLote(_artigo);

  //       return;
  //     }
  //   });

  //   return _artigo;
  // }

  List<Map<String, dynamic>> listaArmazemToJson() {
    if (artigoArmazem != null) {
      return artigoArmazem!.map((armazem) {
        return armazem.toJson();
      }).toList();
    } else {
      return <Map<String, dynamic>>[];
    }
  }

  @override
  List<Object?> get props => [artigo, descricao, preco, quantidade];
}

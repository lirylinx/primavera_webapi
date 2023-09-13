import 'dart:convert';
import 'package:uuid/uuid.dart';

class ArtigoArmazem {
  String? id = Uuid().v4();

  String? idLinha;

  String? artigo;
  String? armazem;
  String? localizacao;

  String? lote;
  double? quantidadeStock;
  double? quantidade = 0.0;
  String? estado;
  double? quantidadeExpedir;
  double? quantidadePendente;
  double? quantidadeRecebida;
  double? quantidadeRejeitada;
  double? quantidadeOriginal;

  bool? alterado = false;

  ArtigoArmazem(
      {this.idLinha,
      this.artigo,
      this.armazem,
      this.localizacao,
      this.lote,
      this.quantidadeStock,
      this.quantidade,
      this.estado,
      this.quantidadeRecebida,
      this.quantidadeRejeitada,
      this.quantidadeExpedir,
      this.quantidadePendente,
      this.quantidadeOriginal,
      this.alterado});

  factory ArtigoArmazem.fromMap(Map<String, dynamic> data) {
    try {
      return ArtigoArmazem(
        // id: data['id'],
        idLinha: data['idLinha'] ?? "@",
        artigo: data['artigo'],
        armazem: data['armazem'] ?? "@",
        localizacao: data['localizacao'] ?? "@",
        lote: data['lote'] ?? "@",
        quantidadeStock:
            double.tryParse(data['quantidadeStock'].toString()) ?? 0.0,
        quantidade: double.tryParse(data['quantidade'].toString()) ?? 0.0,
        estado: data['estado'] ?? "",
        quantidadeExpedir: double.tryParse(data['quantidadeExpedir']) ?? 0.0,
        quantidadePendente: double.tryParse(data['quantidadePendente']) ?? 0.0,
        quantidadeRecebida: double.tryParse(data['quantidadeRecebida']) ?? 0.0,
        quantidadeOriginal: double.tryParse(data['quantidade_original']) ?? 0.0,

        quantidadeRejeitada:
            double.tryParse(data['quantidadeRejeitada']) ?? 0.0,
        alterado: data['alterado'] ?? false,
      );
    } catch (e) {
      rethrow;
    }
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'idLinha': idLinha,
        'artigo': artigo,
        'armazem': armazem,
        'localizacao': localizacao,
        'lote': lote,
        'quantidadeStock': quantidadeStock,
        'quantidade': quantidade,
        'estado': estado,
        'quantidadeExpedir': quantidadeExpedir,
        'quantidadePendente': quantidadePendente,
        'quantidadeRecebida': quantidadeRecebida,
        'quantidadeRejeitada': quantidadeRejeitada,
        'quantidadeOriginal': quantidadeOriginal,
        'alterado': alterado
      };

  factory ArtigoArmazem.fromJson(Map<String, dynamic> data) {
    return ArtigoArmazem(
      // id: data['id'],
      idLinha: data['idLinha'] ?? "@",

      artigo: data['artigo'],
      armazem: data['armazem'] ?? "@",
      localizacao: data['localizacao'] ?? "@",
      lote: data['lote'] ?? "@",
      quantidadeStock:
          double.tryParse(data['quantidadeStock'].toString()) ?? 0.0,
      quantidade: data['quantidade'] ?? 0.0,
      estado: data['estado'] ?? "",
      quantidadeExpedir:
          double.tryParse(data['quantidadeExpedir'].toString()) ?? 0.0,
      quantidadePendente:
          double.tryParse(data['quantidadePendente'].toString()) ?? 0.0,
      quantidadeRecebida:
          double.tryParse(data['quantidadeRecebida'].toString()) ?? 0.0,
      quantidadeRejeitada:
          double.tryParse(data['quantidadeRejeitada'].toString()) ?? 0.0,
      quantidadeOriginal:
          double.tryParse(data['quantidadeOriginal'].toString()) ?? 0.0,
      alterado: data['alterado'] ?? false,
    );
  }

  static List<ArtigoArmazem> parseArtigos(String response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    return parsed
        .map<ArtigoArmazem>((json) => ArtigoArmazem.fromJson(json))
        .toList();
  }

  void resetQuantidade() {
    quantidadeStock = 0.0;
    quantidade = 0.0;
    quantidadeExpedir = 0.0;
    quantidadePendente = 0.0;
    quantidadeRecebida = 0.0;
    quantidadeRejeitada = 0.0;
    alterado = false;
  }

  @override
  String toString() =>
      'ArtigoArmazem { id: $id, artigo: $artigo , armazem: $armazem, localizacao: $localizacao, lote: $lote, stock: $quantidadeStock, qtd: $quantidade, alterado: $alterado, idLinha: $idLinha}';

  String? artigoArmazemId() => id;
  String? getIdLinha() => idLinha;
  // '$artigo:$armazem:$localizacao:$lote:$quantidadeStock';
}

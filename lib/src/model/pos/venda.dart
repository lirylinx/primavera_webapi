import '../artigo/artigo.dart';
import '../endereco.dart';

class PosVenda {
  PosVenda(
      {this.id,
      required this.tipodoc,
      required this.serie,
      required this.cliente,
      required this.artigos,
      required this.caixaPosto,
      this.vendedor,
      this.valorTotal,
      this.dataHora,
      this.referencia,
      this.endereco,
      this.assinaturaCliente,
      this.assinaturaUsuario});

  int? id;
  String tipodoc;
  int serie;
  String caixaPosto;
  String cliente;
  String? vendedor;
  List<Artigo> artigos;
  double? valorTotal;
  DateTime? dataHora;
  String? referencia;
  Endereco? endereco;

  String? assinaturaCliente;
  String? assinaturaUsuario;

  // List<RegraPrecoDesconto>? regrasPreco;
  List regrasPrecoJson = [];

  factory PosVenda.fromMap(Map<String, dynamic> json) {
    // Cliente cliente = Cliente(cliente: json['cliente']);

    return PosVenda(
      id: json['encomenda'],
      tipodoc: json['tipodoc'],
      serie: json['serie'],
      cliente: json['cliente'],
      vendedor: json['vendedor'],
      caixaPosto: json['caixaPosto'],
      artigos: <Artigo>[],
      valorTotal: json['valor'],
      dataHora: DateTime.tryParse(json['data_hora']),
      referencia: json['encomendaId'],
      endereco: json['endereco'],
      assinaturaCliente: json['assinaturaCliente'],
      assinaturaUsuario: json['assinaturaVendedor'],
    );
  }

  Map<String, dynamic> toJson() => {
        'tipodoc': tipodoc,
        'serie': serie,
        'cliente': cliente,
        'vendedor': vendedor,
        'caixaPosto': caixaPosto,
        'referencia': DateTime.now().toString(),
        'artigos': artigos,
        'formaPagamento': []
      };
}

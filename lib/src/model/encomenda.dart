import 'artigo/artigo.dart';
import 'endereco.dart';

class Encomenda {
  Encomenda(
      {this.id,
      required this.tipodoc,
      required this.serie,
      required this.cliente,
      required this.artigos,
      this.vendedor,
      this.valorTotal,
      this.estado,
      this.dataHora,
      this.encomendaId,
      this.endereco,
      this.assinaturaCliente,
      this.assinaturaUsuario});

  int? id;
  String tipodoc;
  int serie;
  String cliente;
  String? vendedor;
  List<Artigo> artigos;
  double? valorTotal;
  String? estado;
  DateTime? dataHora;
  String? encomendaId;
  Endereco? endereco;

  String? assinaturaCliente;
  String? assinaturaUsuario;

  // List<RegraPrecoDesconto>? regrasPreco;
  List regrasPrecoJson = [];

  factory Encomenda.fromMap(Map<String, dynamic> json) {
    // Cliente cliente = Cliente(cliente: json['cliente']);

    return Encomenda(
      id: json['encomenda'],
      tipodoc: json['tipodoc'],
      serie: json['serie'],
      cliente: json['cliente'],
      vendedor: json['vendedor'],
      artigos: <Artigo>[],
      valorTotal: json['valor'],
      estado: json['estado'],
      dataHora: DateTime.tryParse(json['data_hora']),
      encomendaId: json['encomendaId'],
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
        'referencia': DateTime.now().toString(),
        'artigos': artigos
      };
}

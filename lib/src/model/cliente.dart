import 'dart:convert';

import 'endereco.dart';

class Cliente {
  String? cliente;
  String? nome;
  String? nomeFiscal;
  String? numContrib;
  Endereco? endereco;
  bool? anulado;
  int? tipoCredito;
  double totalDeb = 0;
  double encomendaPendente = 0;
  double vendaNaoConvertida = 0;
  double limiteCredito = 0;
  double? desconto;
  int? tipoPreco;
  String? telefone;
  String? imagemBuffer;
  bool? limiteCreditoValor;

  static int creditoLimite = 1;
  static int creditoSuspenso = 2;

  static bool temLimiteCreditoValor = true;
  static bool naoTemLimiteCreditoValor = false;

  Cliente({
    this.cliente,
    this.nome,
    this.nomeFiscal,
    this.endereco,
    this.anulado,
    this.desconto,
    this.tipoCredito,
    this.tipoPreco,
    this.telefone,
    this.imagemBuffer,
    this.limiteCreditoValor,
    this.numContrib = "0",
    this.totalDeb = 0,
    this.encomendaPendente = 0,
    this.vendaNaoConvertida = 0,
    this.limiteCredito = 0,
  });
  factory Cliente.fromMap(Map<String, dynamic> map) {
    // Map<String, dynamic> endereco = map['endereco'];
    return Cliente(
        cliente: map['Cliente'],
        nome: map['Nome'],
        nomeFiscal: map['Nome Fiscal'],
        numContrib: (map['numcontrib'] ?? "0").toString(),
        endereco: Endereco(),
        anulado: map['clienteanulado'] ?? false,
        tipoCredito: 0,
        totalDeb: 0,
        encomendaPendente: 0,
        vendaNaoConvertida: 0,
        limiteCredito: 0,
        limiteCreditoValor: map['limiteCreditoValor'] == 0 ? false : true,

        // imagemBuffer: json['imagemBuffer']
        imagemBuffer: map['imagemBuffer']);
  }

  Map<String, dynamic> toJson() => {
        'cliente': cliente,
        'nome': nome,
        'numcontrib': numContrib,
        'endereco': endereco?.toJson().toString(),
        'anulado': anulado,
        'totaldeb': totalDeb,
        'telefone': telefone,
        'encomendapendente': encomendaPendente,
        'vendanaoconvertida': vendaNaoConvertida,
        'limitecredito': limiteCredito,
        'desconto': desconto,
        'tipocredito': tipoCredito.toString(),
        'tipopreco': tipoPreco.toString(),
        'limiteCreditoValor': limiteCreditoValor
      };

  Map<String, dynamic> imagemToMap() =>
      {'cliente': cliente, 'imagemBuffer': imagemBuffer};

  factory Cliente.fromJson(Map<String, dynamic> json) {
    // String numContrib = json['numContrib'] == "" ? "0" : data['numContrib'];
    // numContrib = numContrib.replaceAll(" ", "");
    Endereco endereco = Endereco(
        bairro: json['morada'],
        descricao: json['morada'],
        pais: "Mocambique",
        provincia: "Maputo",
        ruaAv: json['morada']);
    return Cliente(
      cliente: json['Cliente'] ?? json['cliente'],
      nome: json['Nome'] ?? json['nome'],
      numContrib: json['numcontrib'] ?? "0",
      endereco: endereco,
      anulado: json['clienteanulado'] ?? false,
      tipoCredito: int.tryParse(json['tipocredito'].toString()),
      totalDeb: json['totaldeb'],
      encomendaPendente: json['encomendaspendentes'],
      vendaNaoConvertida: json['vendasnaoconvertidas'],
      limiteCredito: json['limitecredito'],
      desconto: json['desconto'],
      tipoPreco: int.tryParse(json['tipopreco']),
      telefone: json['telefone'] ?? "",
      imagemBuffer: null,
      limiteCreditoValor: json['limiteCreditoValor'],
    );
    // data['imagemBuffer'] == null ? null : data['imagemBuffer']);
  }

  List<Cliente> parseUsuarios(String response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    return parsed.map<Cliente>((json) => Cliente.fromJson(json)).toList();
  }

  // static Color getColorSaldoCliente(Cliente cliente, totalVenda) {
  //   if (cliente.cliente == null) return Colors.blue;
  //   if (cliente.anulado == false &&
  //       cliente.limiteCreditoValor == Cliente.naoTemLimiteCreditoValor) {
  //     return Colors.brown;
  //   } else if (cliente.anulado == false &&
  //       Encomenda.estaDentroLimiteCredito(cliente, totalVenda) == true) {
  //     return Colors.green;
  //   }

  //   return Colors.red;
  // }

  // static Future<Cliente> getClienteOmissao() async {
  //   final sessao = await SessaoApiProvider.readSession();
  //   String data = sessao['pos_sessao'];
  //   PosEstado posEstado = PosEstado.fromJson(jsonDecode(data));

  //   return await DBProvider.db.getCliente(posEstado.clienteOmissao);
  // }

  // static Future<Cliente> getClienteOmissao() async {
  //   Cliente cliente = Cliente();

  //   List<Cliente> lstCliente = await ClienteBloc.fetchClientes(http.Client());

  //   final sessao = await SessaoApiProvider.readSession();
  //   String data = sessao['pos_sessao'];
  //   PosEstado posEstado = PosEstado.fromJson(jsonDecode(data));

  //   lstCliente.forEach((cli) {
  //     if (cli.cliente == posEstado.clienteOmissao) {
  //       cliente = cli;
  //       return;
  //     }
  //   });

  //   return cliente;
  // }
}

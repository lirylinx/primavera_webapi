import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:primavera_webapi/src/model/config.dart';
import 'package:primavera_webapi/src/model/encomenda.dart';
import 'package:primavera_webapi/src/model/utilizador.dart';
import 'package:primavera_webapi/src/utils/app_endpoint.dart';

import '../model/artigo/artigo.dart';
import '../model/cliente.dart';

class Fetch {
  final Utilizador utilizador =
      Utilizador(username: 'jmr', password: 'jmr2013!');
  final ConfigServidor servidor = ConfigServidor('165.90.83.186', 2018);
  final ConfigWebapi webapi = ConfigWebapi(
      company: 'terramar',
      instance: 'default',
      grantType: 'password',
      line: 'professional');

  ConfigTokenSessao? tokenSessao;

  Fetch();

  //_______________________________Set Header__________________________________________
  // Cabeçalho necessário para todas request feitas a webapi
  Map<String, String> setHeader(String token) => {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  //_______________________________GetToken__________________________________________
  // Request necessária para autenticação de todos outros requests
  // feitas ao servidor usando dado de utilizador e configuração
  Future<ConfigTokenSessao> getToken() async {
    var url = Uri.http(servidor.toString(), AppEndpoint.TOKEN);
    Map<String, dynamic> data = webapi.toJson();
    data.addAll(utilizador.toJson());

    var response = await http.post(url, body: data);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map<String, dynamic> body = jsonDecode(response.body);
    return ConfigTokenSessao.fromJson(body);
  }

  //_______________________________GetListaArtigo__________________________________________
  // Busca pela lista de artigos
  Future<List<Artigo>> listaArtigo(String token) async {
    var url = Uri.http(servidor.toString(), AppEndpoint.LISTA_ARTIGO);

    var response = await http.get(url, headers: setHeader(token));

    List<Artigo> _listaArtigos = [];

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      data = jsonDecode(data)["DataSet"]["Table"];

      for (dynamic rawArtigo in data) {
        Artigo artigo = Artigo.fromJson(rawArtigo);
        _listaArtigos.add(artigo);
      }
    } else if (response.statusCode == 401) {
      // renovar o token apos expirar
      ConfigTokenSessao tokenSessao = await getToken();
      _listaArtigos = await listaArtigo(tokenSessao.accessToken);
    } else {
      _listaArtigos = [];
    }

    return _listaArtigos;
  }

  //_______________________________GetListaCliente__________________________________________
  // Busca pela lista de clientes
  Future<List<Cliente>> listaCliente(String token) async {
    var url = Uri.http(servidor.toString(), AppEndpoint.LISTA_CLIENTE);

    var response = await http.get(url, headers: setHeader(token));

    List<Cliente> _listaCliente = [];

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      data = jsonDecode(data)["DataSet"]["Table"];

      for (dynamic rawCliente in data) {
        Cliente _cliente = Cliente.fromJson(rawCliente);
        _listaCliente.add(_cliente);
      }

      print(_listaCliente);
    } else if (response.statusCode == 401) {
      // renovar o token apos expirar
      ConfigTokenSessao tokenSessao = await getToken();
      _listaCliente = await listaCliente(tokenSessao.accessToken);
    } else {
      _listaCliente = [];
    }

    return _listaCliente;
  }

  //_______________________________CriarEncomenda__________________________________________
  // Criar encomenda indicando o cliente, documento e os artigos

  Future<void> criarEncomenda(String token, String tipodoc, int serie,
      String cliente, String referencia, List<Artigo> listaArtigos) async {
    var url = Uri.http(servidor.toString(), AppEndpoint.CRIAR_ENCOMENDA);

    Encomenda encomenda = Encomenda(
        tipodoc: tipodoc,
        serie: serie,
        cliente: cliente,
        vendedor: 'jmr',
        artigos: listaArtigos);

    print(encomenda.toJson());

    var response = await http.post(url,
        headers: setHeader(token), body: jsonEncode(encomenda.toJson()));

    print(response);
  }

  //_______________________________POS CAIXA__________________________________________
  //_______________________________Abertura__________________________________________
  // Abrir o caixa POS, indicando o saldo, conta e o utilizador
  Future<void> abrirPosCaixa(String token) async {
    var url = Uri.http(servidor.toString(), AppEndpoint.ABRIR_POS_CAIXA);

    var response = await http.post(url,
        headers: setHeader(token),
        body: jsonEncode({
          "diariocaixa": {"saldo": "1500", "conta": "CXM1", "utilizador": "jmr"}
        }));

    print(response);
  }

  //_______________________________Fechamento__________________________________________
  // Fechar o caixa POS
  Future<void> fecharPosCaixa(String token, String caixaPosto) async {
    var url = Uri.http(servidor.toString(), AppEndpoint.FECHAR_POS_CAIXA);

    var response = await http.post(url,
        headers: setHeader(token),
        body: jsonEncode({"caixaPosto": caixaPosto}));

    print(response);
  }

  //_______________________________CriarVenda__________________________________________
  // Criar POS venda indicando o cliente, documento e os artigos

  Future<void> criarVenda(String token, String tipodoc, int serie,
      String cliente, String referencia, List<Artigo> listaArtigos) async {
    var url = Uri.http(servidor.toString(), AppEndpoint.CRIAR_ENCOMENDA);

    Encomenda encomenda = Encomenda(
        tipodoc: tipodoc,
        serie: serie,
        cliente: cliente,
        vendedor: 'jmr',
        artigos: listaArtigos);

    print(encomenda.toJson());

    var response = await http.post(url,
        headers: setHeader(token), body: jsonEncode(encomenda.toJson()));

    print(response);
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:primavera_webapi/src/model/config.dart';
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

  Map<String, String> setHeader(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

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

  Future<List<Artigo>> getListaArtigo(String token) async {
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
      _listaArtigos = await getListaArtigo(tokenSessao.accessToken);
    } else {
      _listaArtigos = [];
    }

    return _listaArtigos;
  }

  Future<List<Cliente>> getListaCliente(String token) async {
    var url = Uri.http(servidor.toString(), AppEndpoint.LISTA_CLIENTE);

    var response = await http.get(url, headers: setHeader(token));

    List<Cliente> listaCliente = [];

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      data = jsonDecode(data)["DataSet"]["Table"];

      for (dynamic rawCliente in data) {
        Cliente _cliente = Cliente.fromJson(rawCliente);
        listaCliente.add(_cliente);
      }

      print(listaCliente);
    } else if (response.statusCode == 401) {
      // renovar o token apos expirar
      ConfigTokenSessao tokenSessao = await getToken();
      getListaCliente(tokenSessao.accessToken);
    } else {
      listaCliente = [];
    }

    return listaCliente;
  }
}

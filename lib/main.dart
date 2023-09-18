import 'package:primavera_webapi/src/utils/fetch.dart';

Future<void> main(List<String> args) async {
  Fetch().getToken().then((data) async {
    await Fetch().listaCliente(data.accessToken);
  });
}

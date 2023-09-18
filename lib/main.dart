import 'package:primavera_webapi/src/utils/fetch.dart';

Future<void> main(List<String> args) async {
  Fetch().getToken().then((data) async {
    await Fetch().getListaCliente(data.accessToken);
  });
}

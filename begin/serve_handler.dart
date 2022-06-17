import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServeHandler {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response(200, body: 'Primeira Rota');
    });

    router.get('/ola/mundo/<user>', (Request req, String user) {
      return Response.ok('Ola mundo $user');
    });

    router.get('/query', (Request req) {
      String? name = req.url.queryParameters['name'];
      String? age = req.url.queryParameters['age'];
      return Response.ok('Query eh: $name $age');
    });

    router.post('/login', (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);

      // se usuario == admin e senha == 123
      var user = json['user'];
      var password = json['password'];

      if (user == 'admin' && password == '123') {
        Map result = {'token': 'token', 'user_id': 1};
        String json = jsonEncode(result);
        return Response.ok(json, headers: {'content-type': 'application/json'});
      } else {
        return Response.forbidden('Acesso negado');
      }
    });

    return router;
  }
}

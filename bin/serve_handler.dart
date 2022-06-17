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

    return router;
  }
}

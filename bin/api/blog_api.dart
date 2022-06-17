import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class BlogApi {
  Handler get handler {
    Router router = Router();

    // listagem
    router.get('/blog/noticias', (Request req) {
      return Response.ok('choveu hoje');
    });

    // nova noticias
    router.post('/blog/noticias', (Request req) {
      return Response.ok('enviou noticia');
    });

    // atualizar noticia /blog/noticias?id=1
    router.put('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      return Response.ok('atualizou');
    });

    // deletar noticia
    router.delete('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      return Response.ok('deletou');
    });

    return router;
  }
}

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';

class LoginApi {
  final SecurityService _securityService;

  LoginApi(this._securityService);

  Handler get handler {
    Router router = Router();

    router.post('/login', (Request req) async {
      var token = await _securityService.genereteJWT('1');
      var verify = await _securityService.validateJWT(token);
      return Response.ok((verify != null).toString());
    });

    return router;
  }
}

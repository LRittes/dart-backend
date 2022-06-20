import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middleware,
    bool isSecurity = false,
  });

  Handler createHandler({
    required Handler router,
    List<Middleware>? middleware,
    bool isSecurity = false,
  }) {
    middleware ??= [];
    if (isSecurity) {
      var _securityService = DependencyInjector().get<SecurityService>();
      middleware.addAll([
        _securityService.authorization,
        _securityService.verifyJWT,
      ]);
    }
    var pipeline = Pipeline();

    // ignore: avoid_function_literals_in_foreach_calls
    middleware.forEach((e) => pipeline = pipeline.addMiddleware(e));

    return pipeline.addHandler(router);
  }
}

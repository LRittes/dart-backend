import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middleware,
  });

  Handler createHandler({
    required Handler router,
    List<Middleware>? middleware,
  }) {
    middleware ??= [];
    var pipeline = Pipeline();

    // ignore: avoid_function_literals_in_foreach_calls
    middleware.forEach((e) => pipeline = pipeline.addMiddleware(e));

    return pipeline.addHandler(router);
  }
}

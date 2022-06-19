import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../utils/custom_env.dart';
import 'security_service.dart';
import 'validate/api_route_validate.dart';

class SecurityServiceImp implements SecurityService<JWT> {
  @override
  Future<String> genereteJWT(String userID) async {
    var jwt = JWT({
      'iat': DateTime.now().microsecondsSinceEpoch,
      'userID': userID,
      'roles': ['admin', 'user']
    });

    String key = await CustomEnv.get(key: 'jwt_key');
    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    String key = await CustomEnv.get(key: 'jwt_key');
    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidError {
      return null;
    } on JWTExpiredError {
      return null;
    } on JWTNotActiveError {
      return null;
    } on JWTUndefinedError {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        JWT? jwt;
        String? authorizationHeadler = req.headers['Authorization'];
        if (authorizationHeadler != null) {
          if (authorizationHeadler.startsWith('Bearer ')) {
            String token = authorizationHeadler.substring(7);
            jwt = await validateJWT(token);
          }
        }
        var request = req.change(context: {'jwt': jwt});
        return handler(request);
      };
    };
  }

  @override
  Middleware get verifyJWT => createMiddleware(
        requestHandler: (Request req) {
          ApiRouteValidate _apiSecurity = ApiRouteValidate()
              .add('login')
              .add('xpto')
              .add('register')
              .add('teste');

          if (_apiSecurity.isPublic(req.url.path)) return null;

          if (req.context['jwt'] == null) {
            return Response.forbidden('Not authorized');
          }
          return null;
        },
      );
}

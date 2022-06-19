import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/src/middleware.dart';

import '../../utils/custom_env.dart';
import 'security_service.dart';

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
  // TODO: implement autorization
  Middleware get autorization {
    return (Handler handler) {
      return (Request req) async {
        JWT? jwt;
        String? autorizationHeadler = req.headers['Authorization'];
        if (autorizationHeadler != null) {
          if (autorizationHeadler.startsWith('Bearer ')) {
            String token = autorizationHeadler.substring(7);
            jwt = await validateJWT(token);
          }
        }
        var request = req.change(context: {'jwt': jwt});
        return handler(request);
      };
    };
  }

  @override
  // TODO: implement verifyJWT
  Middleware get verifyJWT => throw UnimplementedError();
}

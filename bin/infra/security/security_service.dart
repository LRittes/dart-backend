import 'package:shelf/shelf.dart';

abstract class SecurityService<T> {
  Future<String> genereteJWT(String userID);
  Future<T?> validateJWT(String token);

  Middleware get verifyJWT;
  Middleware get autorization;
}

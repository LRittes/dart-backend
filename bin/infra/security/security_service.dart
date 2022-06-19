abstract class SecurityService<T> {
  Future<String> genereteJWT(String userID);
  Future<T?> validateJWT(String token);
}

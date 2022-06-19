abstract class SecurityService<T> {
  Future<String> genereteJWT(String userID);
  T? validadeJWT(String token);
}

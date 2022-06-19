class ApiRouteValidate {
  final List<String> _rotas = [];
  ApiRouteValidate add(String rota) {
    _rotas.add(rota);
    return this;
  }

  bool isPublic(String rota) {
    return _rotas.contains(rota);
  }
}

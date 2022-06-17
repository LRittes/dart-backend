import "package:shelf/shelf.dart";
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'serve_handler.dart';

void main() async {
  var _server = ServeHandler();

  final server = await shelf_io.serve(_server.handler, 'localhost', 8000);
  print("Servidor inicializado: http://localhost:8000");
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://exam-api.origam.services/api/posts';

  Future<List<dynamic>> buscarPostagens() async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao buscar postagens: ${response.reasonPhrase}');
    }
  }

  Future<void> criarPostagem(String title) async {
    var url = Uri.parse(baseUrl);
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title}),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao criar o post: ${response.reasonPhrase}');
    }
  }

  Future<void> editarPostagem(int postId, String newTitle) async {
    var url = Uri.parse('$baseUrl/$postId');
    var response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': newTitle}),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar o post: ${response.reasonPhrase}');
    }
  }

  Future<void> excluirPostagem(int postId) async {
    var url = Uri.parse('$baseUrl/$postId');
    var response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Falha ao excluir o post: ${response.reasonPhrase}');
    }
  }
}

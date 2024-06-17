import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'models/post_model.dart';
import 'api/api_service.dart';
import 'models/models.dart';

//import 'package:intl/intl.dart';
import 'assets/font_style.dart';
//import 'package:google_fonts/google_fonts.dart' as googlefonts;
import 'dart:convert';


class Home extends StatefulWidget {
  final Person usuario;

  Home(this.usuario);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> _posts = [];
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _newPostController = TextEditingController();
  final ApiService apiService = ApiService(); // instância da ApiService

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      List<dynamic> responseData = await apiService.buscarPostagens(); // Chamando a função de busca da ApiService
      setState(() {
        _posts = parsePostList(responseData);
      });
    } catch (e) {
      print('Erro ao buscar postagens: $e');
    }
  }

  List<Post> parsePostList(List<dynamic> responseData) {
    return responseData.map<Post>((json) => Post.fromJson(json)).toList();
  }

  Future<void> _createPost(String newTitle) async {
    try {
      await apiService.criarPostagem(newTitle); // Chama a função de criação da ApiService
      _fetchPosts(); // Atualiza a lista após a criação
      _newPostController.clear(); // Limpa o campo de texto após a criação
    } catch (e) {
      print('Erro ao criar o post: $e');
    }
  }

  Future<void> _editPost(int postId, String novoTitulo) async {
    try {
      await apiService.editarPostagem(postId, novoTitulo); // Chama a função de edição da ApiService
      _fetchPosts(); // Atualiza a lista após a edição
    } catch (e) {
      print('Erro ao atualizar o post: $e');
    }
  }

  Future<void> _deletePost(int postId) async {
    try {
      await apiService.excluirPostagem(postId); // Chamando a função de exclusão da ApiService
      _fetchPosts(); // Atualiza a lista após a exclusão
    } catch (e) {
      print('Erro ao excluir o post: $e');
    }
  }

   @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 767; //mobile first

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: EdgeInsets.fromLTRB(90, 15, 105, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                height: 60,
                child: SvgPicture.asset(
                  'images/logo.svg',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 209, 206, 206),
                        width: 1.0,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 214, 207, 207)),
              ),
              
              child: isMobile
                  ? Column(
                      children: [
                        _buildProfileSection(widget.usuario),
                        Expanded(
                          child: _buildMessagesSection(context),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildProfileSection(widget.usuario),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 7,
                          child: _buildMessagesSection(context),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileSection(Person usuario) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.all(23),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage(usuario.urlImages),
            ),
            SizedBox(height: 12),
            Text(
              '${usuario.nomesobrenome}',
              style: tituloStyle, // Utilizando a variável de estilo para título
            ),
            SizedBox(height: 8),
            Text(
              '${usuario.profissao}',
              style: textoStyle, 
            ),
            Text(
              '${usuario.cidadeEstado}',
              style: textoStyle,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Editar Perfil'),
                    content: Text('Indisponível'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(
                    color: Color(0xFF717806), 
                    width: 2.0, 
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, size: 18, color: Color(0xFF717806)), 
                  SizedBox(width: 8), // Espaço entre o ícone e o texto
                  Text(
                    'Editar Perfil',
                    style: TextStyle(color: Color(0xFF717806)), 
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //futura implementação
                _buildCustomLink('Portifólio', Icons.open_in_new, 'https://www.google.com'),
                _buildCustomLink('LinkedIn', Icons.open_in_new, 'https://www.google.com'),
                _buildCustomLink('Instagram', Icons.open_in_new, 'https://www.google.com'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomLink(String label, IconData icon, String url) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        onPressed: () {
          //Implementação para navegação URL
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(12),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerLeft,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.black, 
                  fontWeight: FontWeight.bold, 
                ),
              ),
            ),
            Icon(icon, size: 18, color: Colors.black), 
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
    );
  }

  Widget _buildMessagesSection(BuildContext context) {
    return Column(
      children: [
        _buildMessageSection(),
        Expanded(child: _buildMessageList()),
      ],
    );
  }

  Widget _buildMessageSection() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          TextField(
            controller: _newPostController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'O que está pensando?',
            ),
            maxLines: 3,
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              _createPost(_newPostController.text); 
            },
            child: Text('Publicar'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        return PostWidget(
          post: _posts[index],
          onEdit: _editPost,
          onDelete: _deletePost,
        );
      },
    );
  }
}

class PostWidget extends StatelessWidget {
  final Post post;
  final Function(int, String) onEdit;
  final Function(int) onDelete;

  PostWidget({required this.post, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(post.userImage),
        ),
        title: Text(
          post.title,
          style: tituloStyle, 
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Postado por ${post.userName} em ${post.timestamp}',
              style: textoStyle, 
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _showEditDialog(context, post);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                onDelete(post.id); // Chamada para deletar o post
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, Post post) {
    final TextEditingController _editController = TextEditingController(text: post.title);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Postagem'),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(
              hintText: 'Novo título',
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF717806),
              ),
              child: Text('Salvar alterações'),
              onPressed: () {
                onEdit(post.id, _editController.text); 
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

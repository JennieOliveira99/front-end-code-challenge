import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:front_end_code_challenge/models/post_model.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final Function(int, String) onEdit;
  final Function(int) onDelete;

  PostWidget({
    required this.post,
    required this.onEdit,
    required this.onDelete,
  });

  final TextEditingController _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _editController.text = post.title;

    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    final String formattedDate = formatter.format(DateTime.parse(post.timestamp));

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(post.userImage),
        ),
        title: Text(post.userName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title),
            Text(formattedDate, style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (String result) {
            if (result == 'edit') {
              _showEditDialog(context);
            } else if (result == 'delete') {
              onDelete(post.id);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'edit',
              child: Text('Editar'),
            ),
            const PopupMenuItem<String>(
              value: 'delete',
              child: Text('Excluir'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Postagem'),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Salvar'),
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

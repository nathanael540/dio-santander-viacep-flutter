import 'package:flutter/material.dart';
import 'package:viacep/src/classes/cep.dart';
import 'package:viacep/src/views/pages/add_edit_page.dart';

class CepTile extends StatelessWidget {
  final CEP cep;

  const CepTile({super.key, required this.cep});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: const CircleAvatar(
        child: Icon(Icons.place),
      ),
      title: Text(cep.cepComTraco),
      subtitle: Text(cep.endereco),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddEditPage(cep: cep),
          ),
        );
      },
    );
  }
}

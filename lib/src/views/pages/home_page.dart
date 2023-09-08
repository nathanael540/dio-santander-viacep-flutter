import 'package:flutter/material.dart';
import 'package:viacep/src/classes/cep.dart';
import 'package:viacep/src/controllers/cep_controller.dart';
import 'package:viacep/src/views/components/cep_tile.dart';
import 'package:viacep/src/views/pages/add_edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CepController _cepController = CepController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de CEP'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _cepController.getAllCEP(),
        builder: (context, AsyncSnapshot<List<CEP>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<CEP> cepList = snapshot.data!;

          if (cepList.isEmpty) {
            return const Center(
              child: Text('Nenhum CEP cadastrado'),
            );
          }

          return ListView.builder(
            itemCount: cepList.length,
            itemBuilder: (context, index) => CepTile(cep: cepList[index]),
          );
        },
      ),
    );
  }
}

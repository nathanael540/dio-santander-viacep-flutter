import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viacep/src/classes/cep.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:viacep/src/controllers/cep_controller.dart';
import 'package:viacep/src/views/pages/home_page.dart';

class AddEditPage extends StatefulWidget {
  final CEP? cep;

  const AddEditPage({super.key, this.cep});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final cepController = CepController();

  List<String> estados = [
    "AC",
    "AL",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MT",
    "MS",
    "MG",
    "PA",
    "PB",
    "PR",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RS",
    "RO",
    "RR",
    "SC",
    "SP",
    "SE",
    "TO"
  ];

  CEP _cep = CEP(
    cep: '',
    logradouro: '',
    complemento: '',
    bairro: '',
    localidade: '',
    uf: 'AC',
  );

  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _localidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!isAdding) {
        _cep = widget.cep!;
        _cepController.text = _cep.cep;
        _logradouroController.text = _cep.logradouro;
        _complementoController.text = _cep.complemento;
        _bairroController.text = _cep.bairro;
        _localidadeController.text = _cep.localidade;
      }
      setState(() {});
    });
  }

  bool get isAdding => widget.cep == null;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isAdding ? 'Adicionar CEP' : 'Editar CEP'),
        actions: [
          if (!isAdding)
            IconButton(
              onPressed: _deleteCEP,
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            children: [
              TextField(
                controller: _cepController,
                decoration: const InputDecoration(
                  labelText: 'CEP',
                  hintText: 'Digite o CEP',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _cep.cep = value;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
              ),
              if (!isAdding) ...[
                TextField(
                  controller: _logradouroController,
                  decoration: const InputDecoration(
                    labelText: 'Logradouro',
                    hintText: 'Digite o logradouro',
                  ),
                  onChanged: (value) {
                    _cep.logradouro = value;
                  },
                ),
                TextField(
                  controller: _complementoController,
                  decoration: const InputDecoration(
                    labelText: 'Complemento',
                    hintText: 'Digite o complemento',
                  ),
                  onChanged: (value) {
                    _cep.complemento = value;
                  },
                ),
                TextField(
                  controller: _bairroController,
                  decoration: const InputDecoration(
                    labelText: 'Bairro',
                    hintText: 'Digite o bairro',
                  ),
                  onChanged: (value) {
                    _cep.bairro = value;
                  },
                ),
                TextField(
                  controller: _localidadeController,
                  decoration: const InputDecoration(
                    labelText: 'Localidade',
                    hintText: 'Digite a localidade',
                  ),
                  onChanged: (value) {
                    _cep.localidade = value;
                  },
                ),
                DropdownButtonFormField(
                  items: estados.map((String estado) {
                    return DropdownMenuItem(
                      value: estado,
                      child: Text(estado),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _cep.uf = value.toString();
                  },
                  value: _cep.uf,
                  decoration: const InputDecoration(
                    labelText: 'UF',
                    hintText: 'Selecione a UF',
                  ),
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isAdding ? _addCEP : _editCEP,
                child: Text(isAdding ? 'ADICIONAR' : 'EDITAR'),
              ),
            ],
          ),

          // Loading
          if (loading)
            Container(
              color: Colors.white.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void _addCEP() async {
    String cep = _cep.cep.replaceAll('-', '').replaceAll(".", "");

    if (cep.length != 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('CEP inválido'),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    CEP? cepInfos = await cepController.getCEP(cep);

    if (cepInfos == null) {
      setState(() {
        loading = false;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('CEP não encontrado'),
        ),
      );
      return;
    }

    cepInfos.id = null;
    final added = await cepController.addCEP(cepInfos);

    if (added) {
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false);
    } else {
      setState(() {
        loading = false;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao salvar CEP!'),
        ),
      );
    }
  }

  void _editCEP() async {
    setState(() {
      loading = true;
    });

    final edited = await cepController.updateCEP(_cep);

    if (edited) {
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false);
    } else {
      setState(() {
        loading = false;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao editar CEP!'),
        ),
      );
    }
  }

  void _deleteCEP() async {
    setState(() {
      loading = true;
    });

    final deleted = await cepController.deleteCEP(_cep.id!);

    if (deleted) {
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false);
    } else {
      setState(() {
        loading = false;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao deletar CEP!'),
        ),
      );
    }
  }
}

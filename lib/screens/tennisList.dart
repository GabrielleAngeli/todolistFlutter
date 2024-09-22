import 'package:flutter/material.dart';
import '../util/dbHelper.dart';
import '../model/Tennis.dart';
import 'registrationScreen.dart';

class TennisList extends StatefulWidget {
  const TennisList({super.key});

  @override
  State createState() => TennisListState();
}

class TennisListState extends State<TennisList> {
  final DbHelper dbHelper = DbHelper();
  List<Tennis> itens = [];

  @override
  void initState() {
    super.initState();
    _loadTennis();
  }

  void _loadTennis() async {
    final tennisList = await dbHelper.getTennis();
    setState(() {
      itens = tennisList.map((item) => Tennis.fromMap(item)).toList();
    });
  }

  void _abreTelaDigitacao(BuildContext context, [Tennis? tennis]) async {
    var resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RegistrationScreen(tennis: tennis);
        },
      ),
    );
    if (resultado == true) {
      _loadTennis();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Cancelado!",
            style: TextStyle(fontSize: 18),
          ),
          duration: const Duration(milliseconds: 1500),
          width: 180.0,
          padding: const EdgeInsets.all(16.0),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tênis')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: itens.isEmpty
                ? const Center(
              child: Text(
                'Nenhum tênis cadastrado',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: itens.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (BuildContext _context, int i) {
                return _buildRow(i);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _abreTelaDigitacao(context);
        },
        tooltip: 'Incluir Novo Tênis',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRow(int i) {
    var item = itens[i];
    return Card(
      color: Colors.teal[50],
      child: ListTile(
        title: Text(
          item.modelo,
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          'Marca: ${item.marca}\nTamanho: ${item.tamanho}',
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          _abreTelaDigitacao(context, item);
        },
      ),
    );
  }
}
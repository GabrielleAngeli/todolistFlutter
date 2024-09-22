import 'package:flutter/material.dart';
import '../util/dbHelper.dart';
import '../model/Tennis.dart';

class RegistrationScreen extends StatefulWidget {
  final Tennis? tennis;
  const RegistrationScreen({super.key, this.tennis});

  @override
  State createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController tcModelo = TextEditingController();
  TextEditingController tcMarca = TextEditingController();
  TextEditingController tcTamanho = TextEditingController();
  final DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    if (widget.tennis != null) {
      tcModelo.text = widget.tennis!.modelo;
      tcMarca.text = widget.tennis!.marca;
      tcTamanho.text = widget.tennis!.tamanho;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isViewMode = widget.tennis != null;
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de novo tênis')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text(
                  "MODELO: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 45.0,
                    child: TextField(
                      controller: tcModelo,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(fontSize: 20),
                        hintText: 'modelo do tênis',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      readOnly: isViewMode,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text(
                  "MARCA: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 45.0,
                    child: TextField(
                      controller: tcMarca,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(fontSize: 20),
                        hintText: 'marca do tênis',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      readOnly: isViewMode,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text(
                  "TAMANHO: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 45.0,
                    child: TextField(
                      controller: tcTamanho,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(fontSize: 20),
                        hintText: 'tamanho do tênis',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      readOnly: isViewMode,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                if (isViewMode)
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('EXCLUIR'),
                      onPressed: () async {
                        if (widget.tennis != null) {
                          bool? confirmDelete = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirmar Exclusão'),
                                content: const Text('Você tem certeza que deseja excluir este tênis?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('CANCELAR'),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('CONFIRMAR'),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirmDelete == true) {
                            await dbHelper.deleteTennis(widget.tennis!.id!);
                            Navigator.pop(context, true);
                          }
                        }
                      },
                    ),
                  )
                else
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('ADICIONAR'),
                      onPressed: () async {
                        Tennis newTennis = Tennis(
                          tcModelo.text,
                          tcMarca.text,
                          tcTamanho.text,
                        );
                        await dbHelper.insertTennis(newTennis);
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('CANCELAR'),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
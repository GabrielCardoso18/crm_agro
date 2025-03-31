import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdicionarClientePage extends StatefulWidget{

  @override
  _AdicionarClientePage createState() => _AdicionarClientePage();

  static const ROUT_NAME = '/adicionar-cliente';

}

class _AdicionarClientePage extends State {

  final nomeFantasiaController = TextEditingController();
  final dataCadastroControler = TextEditingController();
  final _dateFormat = DateFormat('dd/MM/yyyy');
  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
    );
  }

  AppBar _criarAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      centerTitle: true,
      title: const Text('Adicionar Cliente'),
    );
  }

  Widget _criarBody() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nomeFantasiaController,
              decoration: InputDecoration(labelText: 'Nome Fantasia'),
              validator: (String? valor){
                if (valor == null || valor.isEmpty){
                  return 'O campo descrição é obrigatório';
                }
                return null;
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nomeFantasiaController,
              decoration: InputDecoration(labelText: 'Razão social'),
              validator: (String? valor){
                if (valor == null || valor.isEmpty){
                  return 'O campo descrição é obrigatório';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nomeFantasiaController,
              decoration: InputDecoration(labelText: 'Cpf/Cnpj'),
              validator: (String? valor){
                if (valor == null || valor.isEmpty){
                  return 'O campo descrição é obrigatório';
                }
                return null;
              },
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text("Contatos"),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nomeFantasiaController,
                        decoration: InputDecoration(labelText: 'Celular'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: nomeFantasiaController,
                        decoration: InputDecoration(labelText: 'Telefone'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: nomeFantasiaController,
                        decoration: InputDecoration(labelText: 'WhatsApp'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: nomeFantasiaController,
                        decoration: InputDecoration(labelText: 'E-mail'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text("Endereço"),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nomeFantasiaController,
                        decoration: InputDecoration(labelText: 'Endereço'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: nomeFantasiaController,
                        decoration: InputDecoration(labelText: 'Numero'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: nomeFantasiaController,
                        decoration: InputDecoration(labelText: 'Bairro'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: nomeFantasiaController,
                        decoration: InputDecoration(labelText: 'Complemento'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: nomeFantasiaController,
                        decoration: InputDecoration(labelText: 'Cidade'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: nomeFantasiaController,
                        decoration: InputDecoration(labelText: 'UF'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextButton(
                onPressed: (){
                  final navigator = Navigator.of(context);
                  navigator.pop();
                },
                child: Text("Salvar")),
            ),
          )
        ],
      ),
    );
  }
}


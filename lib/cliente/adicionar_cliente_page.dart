import 'package:crm_agro/cliente/cliente.dart';
import 'package:crm_agro/cliente_contato/cliente_contato.dart';
import 'package:crm_agro/cliente_endereco/cliente_endereco.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdicionarClientePage extends StatefulWidget{

  @override
  _AdicionarClientePage createState() => _AdicionarClientePage();

  static const ROUT_NAME = '/adicionar-cliente';

}

class _AdicionarClientePage extends State {

  final nomeFantasiaController = TextEditingController();
  final razaoSocialController = TextEditingController();
  final cpfCnpjController = TextEditingController();
  final dataCadastroControler = TextEditingController();
  final telefoneControler = TextEditingController();
  final celularControler = TextEditingController();
  final whatsAppControler = TextEditingController();
  final emailControler = TextEditingController();
  final enderecoControler = TextEditingController();
  final bairroControler = TextEditingController();
  final numeroControler = TextEditingController();
  final cidadeControler = TextEditingController();
  final ufControler = TextEditingController();
  final complementoControler = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat('dd/MM/yyyy');

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
              controller: razaoSocialController,
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
              controller: cpfCnpjController,
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
                        controller: celularControler,
                        decoration: InputDecoration(labelText: 'Celular'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: telefoneControler,
                        decoration: InputDecoration(labelText: 'Telefone'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: whatsAppControler,
                        decoration: InputDecoration(labelText: 'WhatsApp'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailControler,
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
                        controller: enderecoControler,
                        decoration: InputDecoration(labelText: 'Endereço'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: numeroControler,
                        decoration: InputDecoration(labelText: 'Numero'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: bairroControler,
                        decoration: InputDecoration(labelText: 'Bairro'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: complementoControler,
                        decoration: InputDecoration(labelText: 'Complemento'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: cidadeControler,
                        decoration: InputDecoration(labelText: 'Cidade'),
                        validator: (String? valor){
                          if (valor == null || valor.isEmpty){
                            return 'O campo descrição é obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: ufControler,
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
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    final cliente = Cliente(
                      nomeFantasia: nomeFantasiaController.text,
                      razaoSocial: razaoSocialController.text,
                      cpfCnpj: cpfCnpjController.text,
                      dataCadastro: DateTime.now(),
                      contato: ClienteContato(
                        telefone: telefoneControler.text,
                        celular: celularControler.text,
                        whatsapp: whatsAppControler.text,
                        email: emailControler.text,
                      ),
                      endereco: ClienteEndereco(
                        endereco: enderecoControler.text,
                        numero: numeroControler.text,
                        bairro: bairroControler.text,
                        complemento: complementoControler.text,
                        cidade: cidadeControler.text,
                        uf: ufControler.text,
                      ),
                    );

                    Navigator.of(context).pop(cliente);
                  },
                  child: Text("Salvar")),
            ),
          )
        ],
      ),
    );
  }
}


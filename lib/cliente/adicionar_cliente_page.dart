import 'dart:convert';

import 'package:crm_agro/cliente/cliente.dart';
import 'package:crm_agro/dao/cliente_dao.dart';
import 'package:crm_agro/util/cores_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class AdicionarClientePage extends StatefulWidget {
  final Cliente? cliente;

  AdicionarClientePage({this.cliente});

  @override
  _AdicionarClientePage createState() => _AdicionarClientePage();

  static const ROUT_NAME = '/adicionar-cliente';
}

class _AdicionarClientePage extends State<AdicionarClientePage> {
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
  final cepControler = TextEditingController();
  final complementoControler = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat('dd/MM/yyyy');
  bool preencheuCliente = false;
  int idCliente = 0;

  static const base_url = 'https://viacep.com.br/ws/:cep/json/';


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Cliente? cliente = ModalRoute.of(context)?.settings.arguments as Cliente?;
    if(cliente != null && cliente.id != null && !preencheuCliente){
      preencheuCliente = true;
      final c = cliente;
      idCliente = c.id ?? 0;
      nomeFantasiaController.text = c.nomeFantasia ?? '';
      razaoSocialController.text = c.razaoSocial ?? '';
      cpfCnpjController.text = c.cpfCnpj ?? '';
      telefoneControler.text = c.telefone ?? '';
      celularControler.text = c.celular ?? '';
      whatsAppControler.text = c.whatsapp ?? '';
      emailControler.text = c.email ?? '';
      enderecoControler.text = c.endereco ?? '';
      bairroControler.text = c.bairro ?? '';
      numeroControler.text = c.numero ?? '';
      cidadeControler.text = c.cidade ?? '';
      ufControler.text = c.uf ?? '';
      cepControler.text = c.cep ?? '';
      complementoControler.text = c.complemento ?? '';
      dataCadastroControler.text = c.dataCadastro != null
          ? _dateFormat.format(c.dataCadastro!)
          : '';
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CoresApp.verde,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Adicionar Cliente',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 4,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          abrirRotaComEndereco('${enderecoControler.text}, ${numeroControler.text},  ${bairroControler.text}, '
              '${cidadeControler.text}, ${ufControler.text}');
        },
        child: Icon(Icons.map),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _buildInfoBasicaCard(),
              SizedBox(height: 16),
              _buildContatosCard(),
              SizedBox(height: 16),
              _buildEnderecoCard(),
              SizedBox(height: 24),
              _buildBotaoSalvar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBasicaCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'INFORMAÇÕES BÁSICAS',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: CoresApp.verde,
              ),
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: nomeFantasiaController,
              label: 'Nome Fantasia',
              icon: Icons.business,
              validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: razaoSocialController,
              label: 'Razão Social',
              icon: Icons.description,
              validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: cpfCnpjController,
              label: 'CPF/CNPJ',
              icon: Icons.badge,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(14),
              ],
              validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContatosCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Text(
          'CONTATOS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildTextField(
                  controller: celularControler,
                  label: 'Celular',
                  icon: Icons.phone_android,
                  keyboardType: TextInputType.phone,
                  validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: telefoneControler,
                  label: 'Telefone',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: whatsAppControler,
                  label: 'WhatsApp',
                  icon: Icons.comment_sharp,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: emailControler,
                  label: 'E-mail',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnderecoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Text(
          'ENDEREÇO',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: cepControler,
                        label: 'Cep:',
                        icon: Icons.location_on,
                        validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(8),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (cepControler.text.isNotEmpty) {
                          await findCep(cepControler.text);
                        } else {
                        }
                      },
                      icon: Icon(Icons.search_outlined),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: enderecoControler,
                  label: 'Endereço',
                  icon: Icons.location_on,
                  validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        controller: numeroControler,
                        label: 'Número',
                        icon: Icons.numbers,
                        validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: _buildTextField(
                        controller: bairroControler,
                        label: 'Bairro',
                        icon: Icons.location_city,
                        validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: complementoControler,
                  label: 'Complemento',
                  icon: Icons.home_work,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildTextField(
                        controller: cidadeControler,
                        label: 'Cidade',
                        icon: Icons.location_city,
                        validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: _buildTextField(
                        controller: ufControler,
                        label: 'UF',
                        icon: Icons.map,
                        validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: CoresApp.verde),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CoresApp.verde),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }

  Widget _buildBotaoSalvar() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CoresApp.cinzaEscuro,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _salvarCliente,
        child: Text(
          'SALVAR CLIENTE',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _salvarCliente() {
    if (!formKey.currentState!.validate()) return;

    final cliente = Cliente(
      id: idCliente != 0 ? idCliente : null,
      nomeFantasia: nomeFantasiaController.text,
      razaoSocial: razaoSocialController.text,
      cpfCnpj: cpfCnpjController.text,
      dataCadastro: DateTime.now(),
      endereco: enderecoControler.text,
      numero: numeroControler.text,
      bairro: bairroControler.text,
      complemento: complementoControler.text,
      cidade: cidadeControler.text,
      uf: ufControler.text,
      telefone: telefoneControler.text,
      celular: celularControler.text,
      whatsapp: whatsAppControler.text,
      email: emailControler.text,
      cep: cepControler.text
    );

    ClienteDAO().salvar(cliente);
    Navigator.of(context).pop(true);
  }
  Future<void> abrirRotaComEndereco(String enderecoDestino) async {
    try {
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      final origin = '${pos.latitude},${pos.longitude}';
      final destination = Uri.encodeComponent(enderecoDestino);

      final url = 'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&travelmode=driving';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Não foi possível abrir o Google Maps.');
      }
    } catch (e) {
      print('Erro ao pegar localização: $e');
    }
  }

  Future<void> findCep(String cep) async{
    final url = base_url.replaceAll(':cep', cep);
    final uri = Uri.parse(url);
    final response = await get(uri);

    if (response.statusCode != 200 || response.body.isEmpty){
      throw Exception();
    }
    final decodeBody = jsonDecode(response.body);
    setState(() {
      cepControler.text = decodeBody['cep'];
      enderecoControler.text = decodeBody['logradouro'];
      complementoControler.text = decodeBody['complemento'];
      bairroControler.text = decodeBody['bairro'];
      cidadeControler.text = decodeBody['localidade'];
      ufControler.text = decodeBody['uf'];

    });
  }

}
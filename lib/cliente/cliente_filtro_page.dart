import 'package:crm_agro/util/cores_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cliente.dart';

class FiltroClientePage extends StatefulWidget {

  @override
  _FiltroClientePage createState() => _FiltroClientePage();

  static const ROUT_NAME = '/filtro-cliente';

  static const CHAVE_CAMPO_ORDENACAO = 'campoOrdenacao';
  static const USAR_ORDEM_DECRESCENTE = 'usarOrdemDescrescente';
  static const CHAVE_FILTRO_NOME_FANTASIA = 'filtroNomeFantasia';
  static const CHAVE_FILTRO_RAZAO_SOCIAL= 'filtroRazaoSocial';
  static const CHAVE_FILTRO_CPF_CNPJ= 'filtroCPFCNPJ  ';
}

class _FiltroClientePage extends State<FiltroClientePage> {

  final camposParaOrdenacao = {
    Cliente.CAMPO_ID: 'Código', Cliente.CAMPO_NOME_FANTASIA: 'Nome Fantasia',
    Cliente.CAMPO_RAZAO_SOCIAL: 'Razão Social'
  };

  late final SharedPreferences prefs;
  String campoOrdenacao = Cliente.CAMPO_ID;
  bool usarOrdemDecrescente = false;
  final nomeFantasiaController = TextEditingController();
  final razaoSocialController = TextEditingController();
  final cpfCnpjController = TextEditingController();
  bool _alterouValores = false;


  @override
  void initState() {
    _carregarSharedPreferences();
  }

  void _carregarSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      campoOrdenacao = prefs.getString(FiltroClientePage.CHAVE_CAMPO_ORDENACAO) ?? Cliente.CAMPO_ID;
      usarOrdemDecrescente = prefs.getBool(FiltroClientePage.USAR_ORDEM_DECRESCENTE) ?? false;
      nomeFantasiaController.text = prefs.getString(FiltroClientePage.CHAVE_FILTRO_NOME_FANTASIA) ?? '';
      razaoSocialController.text = prefs.getString(FiltroClientePage.CHAVE_FILTRO_RAZAO_SOCIAL) ?? '';
      cpfCnpjController.text = prefs.getString(FiltroClientePage.CHAVE_FILTRO_CPF_CNPJ) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onVoltarClick,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CoresApp.verde,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Filtrar Clientes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 4,
        ),
        body: _criarBody(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: CoresApp.cinzaEscuro,
          child: Icon(Icons.check, color: Colors.white),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop(_alterouValores);
            });
          }
        ),
      ),
    );
  }

  Widget _criarBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _criarSecaoOrdenacao(),
          SizedBox(height: 16),
          _criarSecaoFiltros(),
        ],
      ),
    );
  }

  Widget _criarSecaoOrdenacao() {
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
              "ORDENAÇÃO",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: CoresApp.verde,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Ordenar por:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: campoOrdenacao,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              items: camposParaOrdenacao.keys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(camposParaOrdenacao[key] ?? ''),
                );
              }).toList(),
              onChanged: _onCheckCampoOrdenacao,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: usarOrdemDecrescente,
                  onChanged: _onCheckUsarOrdemDecrescente,
                  activeColor: CoresApp.verde,
                ),
                Text(
                  "Ordem decrescente",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _criarSecaoFiltros() {
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
              "FILTROS",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: CoresApp.verde,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nomeFantasiaController,
              decoration: InputDecoration(
                labelText: "Nome Fantasia",
                prefixIcon: Icon(Icons.business, color: CoresApp.verde),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CoresApp.verde),
                ),
              ),
              onChanged: _onCheckNomeFantasia,
            ),
            SizedBox(height: 16),
            TextField(
              controller: razaoSocialController,
              decoration: InputDecoration(
                labelText: "Razão Social",
                prefixIcon: Icon(Icons.description, color: CoresApp.verde),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CoresApp.verde),
                ),
              ),
              onChanged: _onCheckRazaoSocial,
            ),
            SizedBox(height: 16),
            TextField(
              controller: cpfCnpjController,
              decoration: InputDecoration(
                labelText: "CPF/CNPJ",
                prefixIcon: Icon(Icons.badge, color: CoresApp.verde),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CoresApp.verde),
                ),
              ),
              onChanged: _onCheckCPFCNPJ,
            ),
          ],
        ),
      ),
    );
  }

  void _onCheckCampoOrdenacao(String? valor) {
    prefs.setString(FiltroClientePage.CHAVE_CAMPO_ORDENACAO, valor ?? "");
    _alterouValores = true;

    setState(() {
      campoOrdenacao = valor ?? '';
    });
  }

  void _onCheckUsarOrdemDecrescente(bool? valor) {
    prefs.setBool(FiltroClientePage.USAR_ORDEM_DECRESCENTE, valor == true);
    _alterouValores = true;
    setState(() {
      usarOrdemDecrescente = valor == true;
    });
  }

  void _onCheckRazaoSocial(String valor) {
      prefs.setString(FiltroClientePage.CHAVE_FILTRO_RAZAO_SOCIAL, valor ?? '');
      _alterouValores = true;
  }

  void _onCheckNomeFantasia(String valor) {
      prefs.setString(FiltroClientePage.CHAVE_FILTRO_NOME_FANTASIA, valor ?? '');
      _alterouValores = true;
  }

  void _onCheckCPFCNPJ(String valor) {
      prefs.setString(FiltroClientePage.CHAVE_FILTRO_CPF_CNPJ, valor ?? '');
      _alterouValores = true;
  }


  Future<bool> _onVoltarClick() async {
    Navigator.of(context).pop(_alterouValores);
    return _alterouValores;
  }


}

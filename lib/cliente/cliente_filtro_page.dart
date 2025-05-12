import 'package:crm_agro/util/cores_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cliente.dart';

class FiltroClientePage extends StatefulWidget {

  @override
  _FiltroClientePage createState() => _FiltroClientePage();

  static const ROUT_NAME = '/filtro-cliente';

}

class _FiltroClientePage extends State {

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
    final prefs = await SharedPreferences.getInstance();
    setState(() {

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
          onPressed: () => Navigator.of(context).pop(_alterouValores),
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
            _criarCampoTexto(
              controller: nomeFantasiaController,
              label: "Nome Fantasia",
              icone: Icons.business,
            ),
            SizedBox(height: 16),
            _criarCampoTexto(
              controller: razaoSocialController,
              label: "Razão Social",
              icone: Icons.description,
            ),
            SizedBox(height: 16),
            _criarCampoTexto(
              controller: cpfCnpjController,
              label: "CPF/CNPJ",
              icone: Icons.badge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _criarCampoTexto({
    required TextEditingController controller,
    required String label,
    required IconData icone,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icone, color: CoresApp.verde),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CoresApp.verde),
        ),
      ),
      onChanged: _onCheckDescricao,
    );
  }

  void _onCheckCampoOrdenacao(String? valor) {
    _alterouValores = true;
    setState(() {
      campoOrdenacao = valor!;
    });
  }

  void _onCheckUsarOrdemDecrescente(bool? valor) {
    _alterouValores = true;
    setState(() {
      usarOrdemDecrescente = valor == true;
    });
  }

  void _onCheckDescricao(String valor) {
    _alterouValores = true;
  }

  Future<bool> _onVoltarClick() async {
    Navigator.of(context).pop(_alterouValores);
    return true;
  }


}

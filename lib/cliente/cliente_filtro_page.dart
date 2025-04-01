import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FiltroClientePage extends StatefulWidget {

  @override
  _FiltroClientePage createState() => _FiltroClientePage();

  static const ROUT_NAME = '/filtro-cliente';

}

class _FiltroClientePage extends State {

  final camposParaOrdenacao = {

  };

  late final SharedPreferences prefs;
  bool usarOrdemDecrescente = false;
  final numeroController = TextEditingController();
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: const Text('Filtro cliente'),
        ),
        body: _criarBody(),
      ),
      onWillPop: _onVoltarClick,
    );
  }

  Widget _criarBody() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Text("Campos para ordenação"),
        ),
        for(final campo in camposParaOrdenacao.keys)
          Row(
            children: [
              Text(camposParaOrdenacao[campo] ?? '')
            ],
          ),
        Divider(),
        Row(
          children: [
            Checkbox(
                value: usarOrdemDecrescente,
                onChanged: _onCheckUsarOrdemDecrescente

            ),
            Text("Usar ordem decrescente")
          ],
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            decoration: InputDecoration(labelText: "Nome fantasia: "),
            controller: numeroController,
            onChanged: _onCheckDescricao,
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            decoration: InputDecoration(labelText: "Razão social: "),
            controller: numeroController,
            onChanged: _onCheckDescricao,
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            decoration: InputDecoration(labelText: "CPF/CNPJ: "),
            controller: numeroController,
            onChanged: _onCheckDescricao,
          ),
        ),
      ],
    );
  }

  void _onCheckCampoOrdenacao(String? valor) {

    _alterouValores = true;

    setState(() {

    });
  }

  void _onCheckUsarOrdemDecrescente(bool? valor) {

    _alterouValores = true;
    setState(() {
      usarOrdemDecrescente = valor == true;
    });
  }

  void _onCheckDescricao(String? valor) {

    _alterouValores = true;
  }


  Future<bool> _onVoltarClick() async {
    Navigator.of(context).pop(_alterouValores);
    return true;

  }


}

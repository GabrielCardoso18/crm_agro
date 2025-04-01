import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FiltroVendaPage extends StatefulWidget {

  @override
  _FiltroVendaPageState createState() => _FiltroVendaPageState();

  static const ROUT_NAME = '/filtro-venda';

}

class _FiltroVendaPageState extends State {

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
          title: const Text('Filtro venda'),
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
          padding: const EdgeInsets.all(8.0),
          child: Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              List<String> options = [];
              if (textEditingValue.text.isEmpty) {
                return options;
              }
              return options.where((option) => option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()));
            },
            onSelected: (String selection) {},
            fieldViewBuilder:
                (context, controller, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  labelText: "Item",
                  border: OutlineInputBorder(),
                ),
              );
            },
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              List<String> options = [];
              if (textEditingValue.text.isEmpty) {
                return options;
              }
              return options.where((option) => option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()));
            },
            onSelected: (String selection) {},
            fieldViewBuilder:
                (context, controller, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  labelText: "Cliente",
                  border: OutlineInputBorder(),
                ),
              );
            },
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            decoration: InputDecoration(labelText: "Numero: "),
            controller: numeroController,
            onChanged: _onCheckDescricao,
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            decoration: InputDecoration(labelText: "Observação: "),
            controller: numeroController,
            onChanged: _onCheckDescricao,
          ),
        )
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

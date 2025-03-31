import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AdicionarItemPage extends StatefulWidget{

  @override
  _AdicionarItemPage createState() => _AdicionarItemPage();

  static const ROUT_NAME = '/adicionar-item';

}

class _AdicionarItemPage extends State {

  final descricaoController = TextEditingController();
  final valorController = TextEditingController();
  final dataCadastroControler = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final NumberFormat _formatter = NumberFormat("#,##0.00", "pt_BR");

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
      title: const Text('Adicionar Item'),
    );
  }

  Widget _criarBody() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Codigo'),
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
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
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
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
              List<String> options = ["UN", "PCT", "KG"];

              if (textEditingValue.text.isEmpty) {
                return options;
              }

              return options.where((option) => option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()));
              },
              onSelected: (String selection) {

              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                return TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: "Unidade de Medida",
                    border: OutlineInputBorder(),
                  ),
                );
              },
            ),
          ),
          TextFormField(
            controller: valorController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              labelText: "Valor Unitário",
              prefixText: "R\$ ", // Prefixo de moeda
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              String formatted = formatarValor(value);
              valorController.value = TextEditingValue(
                text: formatted,
                selection: TextSelection.collapsed(offset: formatted.length),
              );
            },
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

  String formatarValor(String valor) {
    if (valor.isEmpty) return "";

    double? parsedValue = double.tryParse(valor.replaceAll('.', '').replaceAll(',', '.'));
    return parsedValue != null ? _formatter.format(parsedValue) : "";
  }
}
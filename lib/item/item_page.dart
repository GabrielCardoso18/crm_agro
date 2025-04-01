import 'package:crm_agro/item/adicionar_item_page.dart';
import 'package:crm_agro/item/item_filtro_page.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget{

  @override
  _ItemPageState createState() => _ItemPageState();

  static const ROUT_NAME = '/item';

}

class _ItemPageState extends State {

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final navigator = Navigator.of(context);
          navigator.pushNamed(AdicionarItemPage.ROUT_NAME);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  AppBar _criarAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      centerTitle: true,
      title: const Text('Itens'),
      actions: [
        IconButton(
            onPressed: _abrirFiltro,
            icon: Icon(Icons.filter_list)
        )
      ],
    );
  }

  Widget _criarBody() {
    return Container(
    );
  }

  void _abrirFiltro() {
    final navigator = Navigator.of(context);
    navigator.pushNamed(FiltroItemPage.ROUT_NAME).then((alterouValores){
      if(alterouValores == null) {
      }
    });
  }
}
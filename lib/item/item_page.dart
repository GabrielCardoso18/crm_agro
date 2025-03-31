import 'package:crm_agro/item/adicionar_item_page.dart';
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
    );
  }

  Widget _criarBody() {
    return Container(
    );
  }
}
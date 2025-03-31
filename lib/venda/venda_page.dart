import 'package:crm_agro/venda/adicionar_venda_page.dart';
import 'package:flutter/material.dart';

class VendaPage extends StatefulWidget{

  @override
  _VendaPageState createState() => _VendaPageState();

  static const ROUT_NAME = '/venda';

}

class _VendaPageState extends State {

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final navigator = Navigator.of(context);
          navigator.pushNamed(AdicionarVendaPage.ROUT_NAME);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  AppBar _criarAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      centerTitle: true,
      title: const Text('Vendas'),
    );
  }

  Widget _criarBody() {
    return Container(
    );
  }
}
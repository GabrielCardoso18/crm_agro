import 'package:crm_agro/cliente/adicionar_cliente_page.dart';
import 'package:crm_agro/cliente/cliente_filtro_page.dart';
import 'package:flutter/material.dart';

class ClientePage extends StatefulWidget{

  @override
  _ClientePageState createState() => _ClientePageState();

  static const ROUT_NAME = '/cliente';

}

class _ClientePageState extends State {

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            final navigator = Navigator.of(context);
              navigator.pushNamed(AdicionarClientePage.ROUT_NAME);
          },
        child: Icon(Icons.add),
      ),
    );
  }

  AppBar _criarAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      centerTitle: true,
      title: const Text('Clientes'),
      actions: [
        IconButton(
            onPressed: _abrirFiltro,
            icon: Icon(Icons.filter_list)
        )
      ],
    );
  }

  Widget _criarBody() {
    return ListView.separated(
      itemCount: 0,
      itemBuilder: (BuildContext context, int index) {
        return Card();
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }

  void _abrirFiltro() {
    final navigator = Navigator.of(context);
    navigator.pushNamed(FiltroClientePage.ROUT_NAME).then((alterouValores){
      if(alterouValores == null) {
      }
    });
  }

}
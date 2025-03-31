
import 'package:crm_agro/cliente/cliente_page.dart';
import 'package:crm_agro/item/item_page.dart';
import 'package:crm_agro/venda/venda_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();

  static const ROUT_NAME = '/home';

}

class _HomePageState extends State {

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
      title: const Text('CRM AGRO'),
    );
  }

  Widget _criarBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle_outlined, size: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text("Usuario logado", style: TextStyle(fontSize: 15),),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: const Card(
                color: Colors.teal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  child: Text("Clientes"),
                ),
              ),
              onTap: () {
                final navigator = Navigator.of(context);
                navigator.pushNamed(ClientePage.ROUT_NAME);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: const Card(
                color: Colors.teal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
                  child: Text("Itens"),
                ),
              ),
              onTap: () {
                final navigator = Navigator.of(context);
                navigator.pushNamed(ItemPage.ROUT_NAME);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: const Card(
                color: Colors.teal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  child: Text("Vendas"),
                ),
              ),
              onTap: () {
                final navigator = Navigator.of(context);
                navigator.pushNamed(VendaPage.ROUT_NAME);
              },
            ),
          ],
        ),
      ],
    );
  }
}
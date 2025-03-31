import 'package:crm_agro/cliente/cliente_page.dart';
import 'package:crm_agro/home/home_page.dart';
import 'package:crm_agro/item/adicionar_item_page.dart';
import 'package:crm_agro/item/item_page.dart';
import 'package:crm_agro/venda/adicionar_venda_page.dart';
import 'package:crm_agro/venda/venda_page.dart';
import 'package:flutter/material.dart';

import 'cliente/adicionar_cliente_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Gerenciador de Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: HomePage(),
      routes: {
        HomePage.ROUT_NAME: (BuildContext context) => HomePage(),
        ClientePage.ROUT_NAME:  (BuildContext context) => ClientePage(),
        AdicionarClientePage.ROUT_NAME:  (BuildContext context) => AdicionarClientePage(),
        ItemPage.ROUT_NAME: (BuildContext context) => ItemPage(),
        AdicionarItemPage.ROUT_NAME:  (BuildContext context) => AdicionarItemPage(),
        VendaPage.ROUT_NAME: (BuildContext context) => VendaPage(),
        AdicionarVendaPage.ROUT_NAME:  (BuildContext context) => AdicionarVendaPage(),
      },
    );
  }
}

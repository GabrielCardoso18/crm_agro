import 'package:crm_agro/cliente/cliente_filtro_page.dart';
import 'package:crm_agro/cliente/cliente_page.dart';
import 'package:crm_agro/home/home_page.dart';
import 'package:crm_agro/item/adicionar_item_page.dart';
import 'package:crm_agro/item/item_filtro_page.dart';
import 'package:crm_agro/item/item_page.dart';
import 'package:crm_agro/util/cores_app.dart';
import 'package:crm_agro/venda/adicionar_venda_page.dart';
import 'package:crm_agro/venda/filtro_venda_page.dart';
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
        primaryColor: CoresApp.verde,
        scaffoldBackgroundColor: CoresApp.branco,
        appBarTheme: AppBarTheme(
          backgroundColor: CoresApp.verde,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: CoresApp.amarelo,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: CoresApp.verde,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: HomePage(),
      routes: {
        HomePage.ROUT_NAME: (BuildContext context) => HomePage(),
        ClientePage.ROUT_NAME:  (BuildContext context) => ClientePage(),
        AdicionarClientePage.ROUT_NAME:  (BuildContext context) => AdicionarClientePage(),
        FiltroClientePage.ROUT_NAME: (BuildContext context) => FiltroClientePage(),
        ItemPage.ROUT_NAME: (BuildContext context) => ItemPage(),
        AdicionarItemPage.ROUT_NAME:  (BuildContext context) => AdicionarItemPage(),
        FiltroItemPage.ROUT_NAME: (BuildContext context) => FiltroItemPage(),
        VendaPage.ROUT_NAME: (BuildContext context) => VendaPage(),
        AdicionarVendaPage.ROUT_NAME:  (BuildContext context) => AdicionarVendaPage(),
        FiltroVendaPage.ROUT_NAME: (BuildContext context) => FiltroVendaPage(),
      },
    );
  }
}

import 'package:crm_agro/cliente/cliente_filtro_page.dart';
import 'package:crm_agro/cliente/cliente_page.dart';
import 'package:crm_agro/home/home_page.dart';
import 'package:crm_agro/util/cores_app.dart';
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
      },
    );
  }
}

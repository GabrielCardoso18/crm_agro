import 'package:crm_agro/cliente/adicionar_cliente_page.dart';
import 'package:crm_agro/cliente/cliente.dart';
import 'package:crm_agro/cliente/cliente_filtro_page.dart';
import 'package:crm_agro/dao/cliente_dao.dart';
import 'package:crm_agro/util/cores_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientePage extends StatefulWidget{
  static const ROUT_NAME = '/cliente';
  @override
  _ClientePage createState() => _ClientePage();
}

class _ClientePage extends State<ClientePage>{
  static const ACAO_EDITAR = 'editar';
  static const ACAO_EXCLUIR = 'excluir';

  final clientes = <Cliente>[];
  final _dao = ClienteDAO();
  var _carregando = false;

  @override
  void initState() {
    super.initState();
    _atualizarLista();
  }

  void _atualizarLista() async {
    final prefs = await SharedPreferences.getInstance();
    // Implementar lógica de carregamento
    setState(() {
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CoresApp.verde,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Clientes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _abrirFiltro,
            icon: Icon(Icons.filter_list),
            tooltip: 'Filtrar',
          )
        ],
      ),
      body: _carregando
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: CoresApp.verde,
            ),
            SizedBox(height: 16),
            Text(
              'Carregando clientes...',
              style: TextStyle(
                fontSize: 18,
                color: CoresApp.verde,
              ),
            ),
          ],
        ),
      )
          : clientes.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.group_off,
              size: 60,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'Nenhum cliente cadastrado',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: () async => _atualizarLista(),
        color: CoresApp.verde,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 8),
          itemCount: clientes.length,
          itemBuilder: (context, index) {
            final cliente = clientes[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: CoresApp.verde.withOpacity(0.2),
                  child: Icon(
                    Icons.person,
                    color: CoresApp.verde,
                  ),
                ),
                title: Text(
                  cliente.nomeFantasia ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: ACAO_EDITAR,
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: CoresApp.verde),
                          SizedBox(width: 8),
                          Text('Editar'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: ACAO_EXCLUIR,
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Excluir'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == ACAO_EDITAR) {
                      Navigator.pushNamed(context, AdicionarClientePage.ROUT_NAME);
                    } else if (value == ACAO_EXCLUIR) {
                    }
                  },
                ),
                onTap: () {
                  Navigator.pushNamed(context, AdicionarClientePage.ROUT_NAME);
                },
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 4),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AdicionarClientePage.ROUT_NAME);
        },
        backgroundColor: CoresApp.cinzaEscuro,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _abrirFiltro() {
    Navigator.pushNamed(context, FiltroClientePage.ROUT_NAME);
  }
}
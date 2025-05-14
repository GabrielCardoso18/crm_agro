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

  late var clientes = <Cliente>[];
  final _dao = ClienteDAO();
  var _carregando = false;

  @override
  void initState() {
    super.initState();
    _atualizarLista();
  }

  void _atualizarLista() async {
    final prefs = await SharedPreferences.getInstance();
    final campoOrdenacao = prefs.getString(FiltroClientePage.CHAVE_CAMPO_ORDENACAO) ?? Cliente.CAMPO_ID;
    final usarOrdemDescrecente = prefs.getBool(FiltroClientePage.USAR_ORDEM_DECRESCENTE) == true;
    final filtroNomeFantasia = prefs.getString(FiltroClientePage.CHAVE_FILTRO_NOME_FANTASIA ?? '');
    final filtroRazaoSocial = prefs.getString(FiltroClientePage.CHAVE_FILTRO_RAZAO_SOCIAL ?? '');
    final filtroCPFCNPJ = prefs.getString(FiltroClientePage.CHAVE_FILTRO_CPF_CNPJ ?? '');
    final buscarClientes = await _dao.listar(
        nomeFantasia: filtroNomeFantasia ?? "",
        cpfCnpj: filtroCPFCNPJ ?? "",
        razaoSocial: filtroRazaoSocial ?? "",
        campoOrdencao: campoOrdenacao,
        usarOrdemDecrescente: usarOrdemDescrecente
    );
    setState(() {
      clientes.clear();
      if(buscarClientes.isNotEmpty){
        clientes.addAll(buscarClientes);
      }
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
                  onSelected: (value) async {
                    if (value == ACAO_EDITAR) {
                       final resultado = await Navigator.pushNamed(
                        context,
                        AdicionarClientePage.ROUT_NAME,
                        arguments: cliente,
                      );

                       if (resultado == true) {
                         _atualizarLista();
                       }

                    } else if (value == ACAO_EXCLUIR) {
                      ClienteDAO().remover(cliente.id!);
                      _atualizarLista();
                    }
                  },
                ),
                onTap: () {
                },
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 4),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final resultado = await Navigator.pushNamed(context, AdicionarClientePage.ROUT_NAME);
          if (resultado == true) {
            _atualizarLista();
          }
        },
        backgroundColor: CoresApp.cinzaEscuro,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _abrirFiltro() async {
    final alterou = await Navigator.of(context).pushNamed(FiltroClientePage.ROUT_NAME);
    if (alterou == true) {
      _atualizarLista();
    }
  }
}
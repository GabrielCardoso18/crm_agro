import 'package:crm_agro/dao/item_dao.dart';
import 'package:crm_agro/item/adicionar_item_page.dart';
import 'package:crm_agro/item/item.dart';
import 'package:crm_agro/item/item_filtro_page.dart';
import 'package:crm_agro/util/cores_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemPage extends StatefulWidget{

  @override
  _ItemPageState createState() => _ItemPageState();

  static const ROUT_NAME = '/item';

}

class _ItemPageState extends State<ItemPage> {

  static const ACAO_EDITAR = 'editar';
  static const ACAO_EXCLUIR = 'excluir';

  final itens = <Item> [];
  final _dao = ItemDAO();
  var _carregando = false;

  @override
  void initState() {
    super.initState();
    _atualizarLista();
  }

  void _atualizarLista() async {
    final prefs = await SharedPreferences.getInstance();
    //final campoOrdenacao = prefs.getString(FiltroClientePage) ?? Cliente.CAMPO_ID;
    // final buscarTarefas = await _dao.listar();
    // setState(() {
    //   clientes.clear();
    //   if(buscarTarefas.isNotEmpty){
    //     clientes.addAll(buscarTarefas);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CoresApp.verde,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Itens',
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
          ),
        ],
        elevation: 4,
      ),
      body: _carregando
          ? _buildLoadingState()
          : itens.isEmpty
          ? _buildEmptyState()
          : _buildItemList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AdicionarItemPage.ROUT_NAME)
            .then((_) => _atualizarLista()),
        backgroundColor: CoresApp.cinzaEscuro,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: CoresApp.verde),
          SizedBox(height: 16),
          Text(
            'Carregando itens...',
            style: TextStyle(
              fontSize: 18,
              color: CoresApp.verde,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 60,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Nenhum item cadastrado',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Toque no botão + para adicionar',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemList() {
    return RefreshIndicator(
      onRefresh: () async => _atualizarLista(),
      color: CoresApp.verde,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: itens.length,
        itemBuilder: (context, index) {
          final item = itens[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: CoresApp.verde.withOpacity(0.2),
                child: Icon(
                  Icons.inventory_2,
                  color: CoresApp.verde,
                ),
              ),
              title: Text(
                item.descricao ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                '${item.unidade} • R\$ ${item.valorUnitario.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              trailing: PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: Colors.grey[600]),
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
                    Navigator.pushNamed(context, AdicionarItemPage.ROUT_NAME)
                        .then((_) => _atualizarLista());
                  } else if (value == ACAO_EXCLUIR) {
                  }
                },
              ),
              onTap: () {
                Navigator.pushNamed(context, AdicionarItemPage.ROUT_NAME)
                    .then((_) => _atualizarLista());
              },
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 4),
      ),
    );
  }

  void _abrirFiltro() {
    final navigator = Navigator.of(context);
    navigator.pushNamed(FiltroItemPage.ROUT_NAME).then((alterouValores){
      if(alterouValores == null) {
        _atualizarLista();
      }
    });
  }
}
import 'package:crm_agro/cliente/cliente.dart';
import 'package:crm_agro/dao/cliente_dao.dart';
import 'package:crm_agro/dao/item_dao.dart';
import 'package:crm_agro/item/item.dart';
import 'package:crm_agro/util/cores_app.dart';
import 'package:crm_agro/venda/venda.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FiltroVendaPage extends StatefulWidget {

  @override
  _FiltroVendaPageState createState() => _FiltroVendaPageState();

  static const ROUT_NAME = '/filtro-venda';

}

class _FiltroVendaPageState extends State {

  final camposParaOrdenacao = {
    Venda.CAMPO_ID: 'Código', Venda.CAMPO_NUMERO: 'Numero'
  };
  String campoOrdenacao = Item.CAMPO_ID;
  late final SharedPreferences prefs;
  bool usarOrdemDecrescente = false;
  final numeroController = TextEditingController();
  final observacaoController = TextEditingController();
  final itemController = TextEditingController();
  final clienteController = TextEditingController();

  bool _alterouValores = false;
  late Item itemSelecionadoFiltro;
  late Cliente clienteSelecionadoFiltro;

  @override
  void initState() {
    _carregarSharedPreferences();
  }

  void _carregarSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onVoltarClick,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CoresApp.verde,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Filtrar Vendas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 4,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _criarSecaoOrdenacao(),
              SizedBox(height: 16),
              _criarSecaoFiltros(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: CoresApp.cinzaEscuro,
          child: Icon(Icons.check, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(_alterouValores),
        ),
      ),
    );
  }

  Widget _criarSecaoOrdenacao() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ORDENAÇÃO",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: CoresApp.verde,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Ordenar por:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: campoOrdenacao,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              items: camposParaOrdenacao.keys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(camposParaOrdenacao[key] ?? ''),
                );
              }).toList(),
              onChanged: _onCheckCampoOrdenacao,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: usarOrdemDecrescente,
                  onChanged: _onCheckUsarOrdemDecrescente,
                  activeColor: CoresApp.verde,
                ),
                Text(
                  "Ordem decrescente",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _criarSecaoFiltros() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FILTROS',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: CoresApp.verde,
              ),
            ),
            SizedBox(height: 16),
            _criarCampoTexto(
              controller: numeroController,
              label: 'Número',
              icon: Icons.numbers,
            ),
            SizedBox(height: 16),
            _criarCampoTexto(
              controller: observacaoController,
              label: 'Observação',
              icon: Icons.note,
            ),
            SizedBox(height: 16),
            _criarAutocompleteItem(),
            SizedBox(height: 16),
            _criarAutocompleteCliente(),
          ],
        ),
      ),
    );
  }

  Widget _criarCampoTexto({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: CoresApp.verde),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CoresApp.verde),
        ),
      ),
      onChanged: _onCheckDescricao,
    );
  }

  Widget _criarAutocompleteItem() {
    return Autocomplete<Item>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        List<Item> itens = await ItemDAO().listar();
        if (textEditingValue.text.isEmpty) {
          return itens;
        }
        return itens.where((item) => item.descricao
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      displayStringForOption: (Item item) => item.descricao,
      onSelected: (Item selection) {
        itemController.text = selection.descricao;
        itemSelecionadoFiltro = selection;
        _alterouValores = true;
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Item',
            prefixIcon: Icon(Icons.inventory, color: CoresApp.verde),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CoresApp.verde),
            ),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = options.elementAt(index);
                  return ListTile(
                    title: Text(item.descricao),
                    onTap: () {
                      onSelected(item);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _criarAutocompleteCliente() {
    return Autocomplete<Cliente>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        List<Cliente> clientes = await ClienteDAO().listar();
        if (textEditingValue.text.isEmpty) {
          return clientes;
        }
        return clientes.where((cliente) => cliente.nomeFantasia!
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      displayStringForOption: (Cliente cliente) => cliente.nomeFantasia!,
      onSelected: (Cliente selection) {
        clienteController.text = selection.nomeFantasia!;
        clienteSelecionadoFiltro = selection;
        _alterouValores = true;
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Cliente',
            prefixIcon: Icon(Icons.person, color: CoresApp.verde),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CoresApp.verde),
            ),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final cliente = options.elementAt(index);
                  return ListTile(
                    title: Text(cliente.nomeFantasia ?? ""),
                    onTap: () {
                      onSelected(cliente);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _onCheckCampoOrdenacao(String? valor) {
    _alterouValores = true;
    setState(() {
      campoOrdenacao = valor!;
    });
  }

  void _onCheckUsarOrdemDecrescente(bool? valor) {

    _alterouValores = true;
    setState(() {
      usarOrdemDecrescente = valor == true;
    });
  }

  void _onCheckDescricao(String? valor) {

    _alterouValores = true;
  }


  Future<bool> _onVoltarClick() async {
    Navigator.of(context).pop(_alterouValores);
    return true;

  }


}

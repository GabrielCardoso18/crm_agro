import 'package:crm_agro/cliente/cliente.dart';
import 'package:crm_agro/dao/cliente_dao.dart';
import 'package:crm_agro/dao/item_dao.dart';
import 'package:crm_agro/dao/venda_dao.dart';
import 'package:crm_agro/item/item.dart';
import 'package:crm_agro/util/cores_app.dart';
import 'package:crm_agro/venda/venda.dart';
import 'package:crm_agro/venda_item/venda_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AdicionarVendaPage extends StatefulWidget{

  @override
  _AdicionarVendaPage createState() => _AdicionarVendaPage();

  static const ROUT_NAME = '/adicionar-venda';

}

class _AdicionarVendaPage extends State {

  static const ACAO_EDITAR = 'editar';

  final observacaoController = TextEditingController();
  final numeroController = TextEditingController();
  final valorController = TextEditingController();
  final dataCadastroControler = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final NumberFormat _formatter = NumberFormat("#,##0.00", "pt_BR");

  late Cliente clienteSelecionado;
  late Item itemSelecionado;
  List<VendaItem> itensVendidos = [];

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CoresApp.verde,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Nova Venda',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _buildCampoNumero(),
              SizedBox(height: 16),
              _buildAutocompleteCliente(),
              SizedBox(height: 16),
              _buildCardItens(),
              SizedBox(height: 16),
              _buildCampoObservacoes(),
              SizedBox(height: 24),
              _buildBotaoSalvar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampoNumero() {
    return TextFormField(
      controller: numeroController,
      decoration: InputDecoration(
        labelText: 'Número',
        prefixIcon: Icon(Icons.numbers, color: CoresApp.verde),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CoresApp.verde),
        ),
      ),
      validator: (valor) => valor?.isEmpty ?? true ? 'Campo obrigatório' : null,
    );
  }

  Widget _buildAutocompleteCliente() {
    return Autocomplete<Cliente>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        List<Cliente> clientes = await ClienteDAO().listar();
        if (textEditingValue.text.isEmpty) return clientes;
        return clientes.where((cliente) =>
            cliente.nomeFantasia!.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      displayStringForOption: (Cliente cliente) => cliente.nomeFantasia!,
      onSelected: (Cliente selection) {
        setState(() => clienteSelecionado = selection);
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: "Cliente",
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
                  final option = options.elementAt(index);
                  return ListTile(
                    title: Text(option.nomeFantasia!),
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardItens() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ITENS DA VENDA",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: CoresApp.verde,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: CoresApp.verde),
                  onPressed: () => _mostrarDialogAdicionarItem(context),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 200,
              child: itensVendidos.isEmpty
                  ? Center(
                child: Text(
                  'Nenhum item adicionado',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.separated(
                itemCount: itensVendidos.length,
                itemBuilder: (context, index) {
                  final item = itensVendidos[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: CoresApp.verde.withOpacity(0.2),
                      child: Icon(
                        Icons.inventory,
                        size: 20,
                        color: CoresApp.verde,
                      ),
                    ),
                    title: Text(item.item?.descricao ?? ''),
                    subtitle: Text(
                      '${item.quantidade} x R\$ ${item.valorUnitario?.toStringAsFixed(2)} = R\$ ${item.valorTotal?.toStringAsFixed(2)}',
                    ),
                    trailing: PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, size: 20),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'editar',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: CoresApp.verde, size: 20),
                              SizedBox(width: 8),
                              Text('Editar'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'excluir',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red, size: 20),
                              SizedBox(width: 8),
                              Text('Excluir'),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'editar') {
                          _mostrarDialogAdicionarItem(context, index: index);
                        } else if (value == 'excluir') {
                          setState(() => itensVendidos.removeAt(index));
                        }
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(height: 1),
              ),
            ),
            if (itensVendidos.isNotEmpty) ...[
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOTAL:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _formatter.format(_calcularTotal()),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: CoresApp.verde,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCampoObservacoes() {
    return TextFormField(
      controller: observacaoController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Observações',
        prefixIcon: Icon(Icons.note, color: CoresApp.verde),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CoresApp.verde),
        ),
      ),
    );
  }

  Widget _buildBotaoSalvar() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CoresApp.verde,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _salvarVenda,
        child: Text(
          'SALVAR VENDA',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _mostrarDialogAdicionarItem(BuildContext context, {int? index}) {
    final isEdicao = index != null;
    final item = isEdicao ? itensVendidos[index] : null;

    final quantidadeController = TextEditingController(text: isEdicao ? item?.quantidade.toString() : '');
    final valorUnitarioController = TextEditingController(text: isEdicao ? item?.valorUnitario.toString() : '');
    final itemController = TextEditingController(text: isEdicao ? item?.item?.descricao : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdicao ? 'Editar Item' : 'Adicionar Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Autocomplete<Item>(
                  optionsBuilder: (textEditingValue) async {
                    final itens = await ItemDAO().listar();
                    if (textEditingValue.text.isEmpty) return itens;
                    return itens.where((item) =>
                        item.descricao.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                  },
                  displayStringForOption: (item) => item.descricao,
                  onSelected: (selection) => itemSelecionado = selection,
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    return TextField(
                      controller: itemController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: "Item",
                        prefixIcon: Icon(Icons.inventory, color: CoresApp.verde),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: quantidadeController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: "Quantidade",
                          prefixIcon: Icon(Icons.format_list_numbered, color: CoresApp.verde),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: valorUnitarioController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        decoration: InputDecoration(
                          labelText: "Valor Unitário",
                          prefixIcon: Icon(Icons.attach_money, color: CoresApp.verde),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('CANCELAR'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CoresApp.verde,
              ),
              onPressed: () {
                final quantidade = double.tryParse(quantidadeController.text) ?? 0;
                final valorUnitario = double.tryParse(valorUnitarioController.text) ?? 0;
                final total = quantidade * valorUnitario;

                final novoItem = VendaItem(
                  item: itemSelecionado ?? item?.item,
                  quantidade: quantidade,
                  valorUnitario: valorUnitario,
                  valorTotal: total,
                );

                setState(() {
                  if (isEdicao) {
                    itensVendidos[index] = novoItem;
                  } else {
                    itensVendidos.add(novoItem);
                  }
                });

                Navigator.pop(context);
              },
              child: Text('SALVAR'),
            ),
          ],
        );
      },
    );
  }

  double _calcularTotal() {
    return itensVendidos.fold(0, (total, item) => total + (item.valorTotal ?? 0));
  }

  void _salvarVenda() {
    if (!formKey.currentState!.validate()) return;
    if (clienteSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selecione um cliente')),
      );
      return;
    }
    if (itensVendidos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Adicione pelo menos um item')),
      );
      return;
    }

    final venda = Venda(
      cliente: clienteSelecionado,
      itens: itensVendidos,
      dataCadastro: DateTime.now(),
      numero: numeroController.text,
      observacoes: observacaoController.text,
      valorTotal: _calcularTotal(),
    );

    VendaDAO().salvar(venda);
    Navigator.of(context).pop(venda);
  }
}
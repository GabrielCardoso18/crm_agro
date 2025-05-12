import 'package:crm_agro/dao/item_dao.dart';
import 'package:crm_agro/util/cores_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'item.dart';

class AdicionarItemPage extends StatefulWidget{

  @override
  _AdicionarItemPage createState() => _AdicionarItemPage();

  static const ROUT_NAME = '/adicionar-item';

}

class _AdicionarItemPage extends State {

  final descricaoController = TextEditingController();
  final unidadeController = TextEditingController();
  final codigoController = TextEditingController();
  final valorController = TextEditingController();
  final dataCadastroControler = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final NumberFormat _formatter = NumberFormat("#,##0.00", "pt_BR");

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
          'Adicionar Item',
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
              _buildInfoBasicaCard(),
              SizedBox(height: 24),
              _buildBotaoSalvar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBasicaCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(
              controller: codigoController,
              label: 'Código',
              icon: Icons.code,
              validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: descricaoController,
              label: 'Descrição',
              icon: Icons.description,
              validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            _buildUnidadeMedidaField(),
            SizedBox(height: 16),
            _buildValorUnitarioField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
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
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }

  Widget _buildUnidadeMedidaField() {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        List<String> options = ["UN", "PCT", "KG"];
        if (textEditingValue.text.isEmpty) {
          return options;
        }
        return options.where((option) => option
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (String selection) {
        setState(() {
          unidadeController.text = selection;
        });
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: "Unidade de Medida",
            prefixIcon: Icon(Icons.straighten, color: CoresApp.verde),
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
                    title: Text(option),
                    onTap: () {
                      onSelected(option);
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

  Widget _buildValorUnitarioField() {
    return TextFormField(
      controller: valorController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        labelText: "Valor Unitário",
        prefixIcon: Icon(Icons.attach_money, color: CoresApp.verde),
        prefixText: "R\$ ",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CoresApp.verde),
        ),
      ),
      validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
      onChanged: (value) {
        String formatted = formatarValor(value);
        valorController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      },
    );
  }

  Widget _buildBotaoSalvar() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CoresApp.cinzaEscuro,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _salvarItem,
        child: Text(
          'SALVAR ITEM',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _salvarItem() {
    if (!formKey.currentState!.validate()) return;

    final item = Item(
      unidade: unidadeController.text,
      descricao: descricaoController.text,
      codigo: codigoController.text,
      valorUnitario: double.tryParse(valorController.text.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0,
    );

    ItemDAO().salvar(item);
    Navigator.of(context).pop(item);
  }

  String formatarValor(String valor) {
    if (valor.isEmpty) return "";

    double? parsedValue = double.tryParse(valor.replaceAll('.', '').replaceAll(',', '.'));
    return parsedValue != null ? _formatter.format(parsedValue) : "";
  }
}
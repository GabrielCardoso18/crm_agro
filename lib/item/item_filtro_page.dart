import 'package:crm_agro/item/item.dart';
import 'package:crm_agro/util/cores_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FiltroItemPage extends StatefulWidget {

  @override
  _FiltroItemPageState createState() => _FiltroItemPageState();

  static const ROUT_NAME = '/filtro-item';

}

class _FiltroItemPageState extends State {

  final camposParaOrdenacao = {
    Item.CAMPO_ID: 'Código', Item.CAMPO_DESCRICAO: 'Nome Fantasia'
  };
  String campoOrdenacao = Item.CAMPO_ID;
  late final SharedPreferences prefs;
  bool usarOrdemDecrescente = false;
  final codigoController = TextEditingController();
  final descricaoController = TextEditingController();
  final unidadeController = TextEditingController();
  bool _alterouValores = false;


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
            'Filtrar Itens',
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
              "FILTROS",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: CoresApp.verde,
              ),
            ),
            SizedBox(height: 16),
            _criarCampoTexto(
              controller: descricaoController,
              label: "Descrição",
              icon: Icons.description,
            ),
            SizedBox(height: 16),
            _criarCampoTexto(
              controller: codigoController,
              label: "Código",
              icon: Icons.code,
            ),
            SizedBox(height: 16),
            _criarUnidadeMedidaField(),
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

  Widget _criarUnidadeMedidaField() {
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
          _alterouValores = true;
        });
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
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

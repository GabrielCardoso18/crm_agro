import 'dart:io';

import 'package:crm_agro/cliente/cliente_page.dart';
import 'package:crm_agro/util/cores_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  static const ROUT_NAME = '/home';
}

class _HomePageState extends State<HomePage> {
  bool _loadingLocation = true;
  WeatherData? _weatherData;
  bool _loadingWeather = true;

  @override
  void initState() {
    super.initState();
    solicitarPermissaoLocalizacao();
    _fetchWeatherData();
  }

  Future<void> solicitarPermissaoLocalizacao() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissão negada, você pode mostrar uma mensagem ou tomar ação
        print('Permissão de localização negada');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissão negada para sempre, o usuário precisa liberar manualmente
      print('Permissão negada para sempre. Vá nas configurações do app.');
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      print('Permissão concedida!');
      // Aqui você pode continuar a pegar a localização
    }
  }

  Future<void> _fetchWeatherData() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _weatherData = WeatherData(
        temperature: 25.5,
        condition: "Ensolarado",
        forecast: "Parcialmente nublado nos próximos dias",
        icon: Icons.wb_sunny,
      );
      _loadingWeather = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
      drawer: _criarDrawer(),
    );
  }

  AppBar _criarAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'CRM AGRO',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      elevation: 4,
    );
  }

  Widget _criarDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: CoresApp.verde,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Bem-vindo!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Menu Principal",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _criarItemDrawer(Icons.person, "Cliente", ClientePage.ROUT_NAME),
          Divider(height: 1, thickness: 1),
          _criarItemDrawer(Icons.exit_to_app, "Sair", null, isExit: true),
        ],
      ),
    );
  }

  ListTile _criarItemDrawer(IconData icon, String title, String? routeName, {bool isExit = false}) {
    return ListTile(
      leading: Icon(icon, color: CoresApp.verde),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[800],
        ),
      ),
      onTap: () {
        if (isExit) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        } else if (routeName != null) {
          Navigator.of(context).pushNamed(routeName);
        }
      },
    );
  }

  Widget _criarBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _criarCabecalhoUsuario(),
          _criarCardDataClima(),
          SizedBox(height: 16),
          _criarCardsMenu(),
          SizedBox(height: 16),
          _criarGraficoSoja(),

        ],
      ),
    );
  }

  Widget _criarCabecalhoUsuario() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CoresApp.verde.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: CoresApp.verde.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_circle,
            size: 28,
            color: CoresApp.verde,
          ),
          SizedBox(width: 10),
          Text(
            "Gabriel Cardoso",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _criarCardDataClima() {
    final now = DateTime.now();
    final monthNames = {
      1: 'Janeiro', 2: 'Fevereiro', 3: 'Março', 4: 'Abril',
      5: 'Maio', 6: 'Junho', 7: 'Julho', 8: 'Agosto',
      9: 'Setembro', 10: 'Outubro', 11: 'Novembro', 12: 'Dezembro'
    };

    final weekdayNames = {
      1: 'Segunda', 2: 'Terça', 3: 'Quarta', 4: 'Quinta',
      5: 'Sexta', 6: 'Sábado', 7: 'Domingo'
    };

    final formattedDate = '${weekdayNames[now.weekday]}, ${now.day} de ${monthNames[now.month]} de ${now.year}';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CoresApp.verde,
                ),
              ),
              SizedBox(height: 12),
              if (_loadingWeather)
                Center(child: CircularProgressIndicator())
              else if (_weatherData != null)
                Row(
                  children: [
                    Icon(
                      _weatherData!.icon,
                      size: 40,
                      color: CoresApp.amarelo,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_weatherData!.temperature}°C',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _weatherData!.condition,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Flexible(
                      child: Text(
                        _weatherData!.forecast,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _criarGraficoSoja() {
    final List<PriceData> priceData = [
      PriceData(DateTime(2023, 10, 1), 150.50),
      PriceData(DateTime(2023, 11, 1), 155.75),
      PriceData(DateTime(2023, 12, 1), 148.20),
    ];

    final monthNames = {
      1: 'Jan', 2: 'Fev', 3: 'Mar', 4: 'Abr', 5: 'Mai', 6: 'Jun',
      7: 'Jul', 8: 'Ago', 9: 'Set', 10: 'Out', 11: 'Nov', 12: 'Dez'
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Histórico de Preços da Soja (últimos 3 meses)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: CoresApp.verde,
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 250,
                child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    intervalType: DateTimeIntervalType.months,
                    dateFormat: DateFormat.MMM(),
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Preço (reais/sc)'),
                  ),
                  series: <LineSeries<PriceData, DateTime>>[
                    LineSeries<PriceData, DateTime>(
                      dataSource: priceData,
                      xValueMapper: (PriceData data, _) => data.date,
                      yValueMapper: (PriceData data, _) => data.price,
                      color: CoresApp.verde,
                      width: 3,
                      markerSettings: MarkerSettings(isVisible: true),
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.top,
                      ),
                    ),
                  ],
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
                      final date = point.x as DateTime;
                      final monthName = monthNames[date.month] ?? date.month.toString();
                      return Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${point.y.toStringAsFixed(2)} reais/sc em $monthName',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Fonte: Dados fictícios para demonstração',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _criarCardsMenu() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _criarCardMenu("Clientes", Icons.group, ClientePage.ROUT_NAME),
        ],
      ),
    );
  }

  Widget _criarCardMenu(String titulo, IconData icone, String rota) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).pushNamed(rota);
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  icone,
                  size: 28,
                  color: CoresApp.verde,
                ),
                SizedBox(width: 20),
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherData {
  final double temperature;
  final String condition;
  final String forecast;
  final IconData icon;

  WeatherData({
    required this.temperature,
    required this.condition,
    required this.forecast,
    required this.icon,
  });
}

class PriceData {
  final DateTime date;
  final double price;

  PriceData(this.date, this.price);
}
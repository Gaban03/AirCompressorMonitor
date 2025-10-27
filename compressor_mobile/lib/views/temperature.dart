part of '_views_lib.dart';

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  late final CompressorDadosViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = CompressorDadosViewModel();
    vm.startFetching();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth < 400 ? 11.0 : 13.0;

    return Scaffold(
      body: AnimatedBuilder(
        animation: vm,
        builder: (_, __) {
          if (vm.isLoading && vm.temperaturaSpots.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.temperaturaSpots.isEmpty) {
            return const Center(child: Text("Sem dados"));
          }

          final minX = vm.temperaturaSpots.first.x;
          final maxX = vm.temperaturaSpots.last.x;

          final minTemp = vm.temperaturaSpots
              .map((e) => e.y)
              .reduce((a, b) => a < b ? a : b);
          final maxTemp = vm.temperaturaSpots
              .map((e) => e.y)
              .reduce((a, b) => a > b ? a : b);
          final avgTemp =
              vm.temperaturaSpots.map((e) => e.y).reduce((a, b) => a + b) /
                  vm.temperaturaSpots.length;

          int labelInterval = 1;
          final maxLabels = (MediaQuery.of(context).size.width / 60).floor();
          if (vm.labels.length > maxLabels && maxLabels > 0) {
            labelInterval = (vm.labels.length / maxLabels).ceil();
          }

          DateTime dt = DateTime.tryParse(vm.dataHora) ?? DateTime.now();
          String dataFormatada = DateFormat('dd/MM/yyyy').format(dt);
          String horaFormatada = DateFormat('HH:mm:ss').format(dt);

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.thermostat,
                                color: Colors.redAccent, size: 30),
                            const SizedBox(width: 8),
                            Text(
                              'Temp. Ambiente',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey.shade800),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          dataFormatada,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            width: 8),
                        Text(
                          horaFormatada,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    '${vm.temperaturaAmbiente.toStringAsFixed(2)} °C',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent.shade700,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatCard(
                        label: 'Mínima',
                        value: minTemp,
                        color: Colors.blue,
                        unit: '°C'),
                    SizedBox(width: 8),
                    StatCard(
                        label: 'Média',
                        value: avgTemp,
                        color: Colors.orange,
                        unit: '°C'),
                    SizedBox(width: 8),
                    StatCard(
                        label: 'Máxima',
                        value: maxTemp,
                        color: Colors.red,
                        unit: '°C'),
                  ],
                ),
                const SizedBox(height: 24),
                // Gráfico
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 300,
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: vm.temperaturaSpots,
                          isCurved: true,
                          color: Colors.redAccent,
                          barWidth: 3,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.redAccent.withOpacity(0.2),
                          ),
                          dotData: FlDotData(show: true),
                        ),
                      ],
                      minX: minX,
                      maxX: maxX,
                      minY: 0,
                      maxY: 50,
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          axisNameWidget: const Text(
                            'Temperatura (°C)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          axisNameSize: 25,
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 20,
                            interval: 5,
                            getTitlesWidget: (value, meta) => Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                value.toStringAsFixed(0),
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          axisNameWidget: const Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text(
                              'Horário',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              final index = (value - minX).round();
                              if (index < 0 ||
                                  index >= vm.labels.length ||
                                  index % labelInterval != 0) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  vm.labels[index],
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: 5,
                        verticalInterval: 1,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.grey.shade300,
                          strokeWidth: 1,
                        ),
                        getDrawingVerticalLine: (value) => FlLine(
                          color: Colors.grey.shade200,
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          left:
                              BorderSide(color: Colors.grey.shade600, width: 1),
                          bottom:
                              BorderSide(color: Colors.grey.shade600, width: 1),
                        ),
                      ),
                      lineTouchData: LineTouchData(
                        enabled: true,
                        touchTooltipData: LineTouchTooltipData(
                          tooltipBgColor: Colors.redAccent,
                          tooltipRoundedRadius: 12,
                          tooltipPadding: const EdgeInsets.all(8),
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((spot) {
                              final index = (spot.x - minX).round();
                              final time =
                                  (index >= 0 && index < vm.labels.length)
                                      ? vm.labels[index]
                                      : '';
                              return LineTooltipItem(
                                'Hora: $time\nTemp: ${spot.y.toStringAsFixed(2)} °C',
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

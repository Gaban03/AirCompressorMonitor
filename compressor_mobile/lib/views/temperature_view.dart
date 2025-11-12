part of '_views_lib.dart';

class TemperatureView extends StatefulWidget {
  final String titulo;
  final TipoTemperatura tipo;
  final Color color;
  final double minY;
  final double maxY;

  const TemperatureView({
    super.key,
    required this.titulo,
    required this.tipo,
    required this.color,
    required this.minY,
    required this.maxY,
  });

  @override
  State<TemperatureView> createState() => _TemperatureViewState();
}

class _TemperatureViewState extends State<TemperatureView> {
  late final CompressorDadosViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = CompressorDadosViewModel();
    vm.startTemperature(widget.tipo);
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  double _currentTemp() {
    switch (widget.tipo) {
      case TipoTemperatura.ambiente:
        return vm.temperaturaAmbiente;
      case TipoTemperatura.arComprimido:
        return vm.temperaturaArComprimido;
      case TipoTemperatura.orvalho:
        return vm.temperaturaOrvalho;
      case TipoTemperatura.oleo:
        return vm.temperaturaOleo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth < 400 ? 11.0 : 13.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Content(
        title: "SENAI",
        body: AnimatedBuilder(
          animation: vm,
          builder: (_, __) {
            if (vm.isLoading && vm.temperaturaSpots.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.temperaturaSpots.isEmpty) {
              return const Center(
                child: Text(
                  "Sem dados",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            final minX = vm.temperaturaSpots.first.x;
            final maxX = vm.temperaturaSpots.last.x;

            final minTemp = vm.temperaturaSpots.map((e) => e.y).reduce(min);
            final maxTemp = vm.temperaturaSpots.map((e) => e.y).reduce(max);
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

            final color = widget.color;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.thermostat, color: color, size: 30),
                          const SizedBox(width: 8),
                          Text(
                            widget.titulo,
                            style: GoogleFonts.orbitron(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            dataFormatada,
                            style: GoogleFonts.orbitron(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            horaFormatada,
                            style: GoogleFonts.orbitron(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 32),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2B2B2B), Color(0xFF1A1A1A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      '${_currentTemp().toStringAsFixed(2)} °C',
                      style: GoogleFonts.orbitron(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: color,
                        letterSpacing: 1.2,
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
                          color: Colors.blueAccent,
                          unit: '°C'),
                      const SizedBox(width: 8),
                      StatCard(
                          label: 'Média',
                          value: avgTemp,
                          color: Colors.orangeAccent,
                          unit: '°C'),
                      const SizedBox(width: 8),
                      StatCard(
                          label: 'Máxima',
                          value: maxTemp,
                          color: Colors.redAccent,
                          unit: '°C'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2B2B2B), Color(0xFF1A1A1A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          offset: Offset(0, 4),
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
                            color: color,
                            barWidth: 3,
                            belowBarData: BarAreaData(
                                show: true, color: color.withOpacity(0.15)),
                            dotData: FlDotData(show: false),
                          ),
                        ],
                        minX: minX,
                        maxX: maxX,
                        minY: widget.minY,
                        maxY: widget.maxY,
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          horizontalInterval: 5,
                          verticalInterval: 1,
                          getDrawingHorizontalLine: (_) =>
                              FlLine(color: Colors.white10, strokeWidth: 1),
                          getDrawingVerticalLine: (_) =>
                              FlLine(color: Colors.white10, strokeWidth: 1),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            axisNameWidget: Text(
                              'Temperatura (°C)',
                              style: GoogleFonts.orbitron(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white70),
                            ),
                            axisNameSize: 25,
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              interval: 5,
                              getTitlesWidget: (value, _) => Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  value.toStringAsFixed(0),
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.white60),
                                ),
                              ),
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            axisNameWidget: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(
                                'Horário',
                                style: GoogleFonts.orbitron(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white70),
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
                                      color: Colors.white70,
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
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                              color: color.withOpacity(0.6), width: 1),
                        ),
                        lineTouchData: LineTouchData(
                          enabled: true,
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: color,
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
                                      fontWeight: FontWeight.bold),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

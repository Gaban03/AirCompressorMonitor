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

  @override
  Widget build(BuildContext context) {
    final color = widget.color;

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
              return Center(
                child: Text(
                  "Sem dados",
                  style: GoogleFonts.orbitron(
                      color: Colors.white70, fontSize: context.rf(14)),
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
            final maxLabels = (context.sw / 60).floor();
            if (vm.labels.length > maxLabels && maxLabels > 0) {
              labelInterval = (vm.labels.length / maxLabels).ceil();
            }

            DateTime dt = DateTime.now();
            String dataFormatada = DateFormat('dd/MM/yyyy').format(dt);
            String horaFormatada = vm.ultimaHora;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  vertical: context.hp(2.5), horizontal: context.wp(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.thermostat,
                              color: color, size: context.rf(22)),
                          SizedBox(width: context.wp(2)),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: context.wp(60)),
                            child: Text(
                              widget.titulo,
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontSize: context.rf(16),
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                              fontSize: context.rf(13),
                            ),
                          ),
                          SizedBox(height: context.hp(0.5)),
                          Text(
                            horaFormatada,
                            style: GoogleFonts.orbitron(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: context.rf(14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: context.hp(2)),

                  // Current temperature card
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: context.hp(1.6), horizontal: context.wp(6)),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2B2B2B), Color(0xFF1A1A1A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(context.wp(4)),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: context.wp(3),
                          offset: Offset(0, context.hp(0.4)),
                        ),
                      ],
                    ),
                    child: Text(
                      '${vm.ultimaTemperatura.toStringAsFixed(2)} °C',
                      style: GoogleFonts.orbitron(
                        fontSize: context.rf(28),
                        fontWeight: FontWeight.bold,
                        color: color,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  SizedBox(height: context.hp(2.5)),

                  // Stat cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: StatCard(
                            label: 'Mínima',
                            value: minTemp,
                            color: Colors.blueAccent,
                            unit: '°C'),
                      ),
                      SizedBox(width: context.wp(2)),
                      Flexible(
                        child: StatCard(
                            label: 'Média',
                            value: avgTemp,
                            color: Colors.orangeAccent,
                            unit: '°C'),
                      ),
                      SizedBox(width: context.wp(2)),
                      Flexible(
                        child: StatCard(
                            label: 'Máxima',
                            value: maxTemp,
                            color: Colors.redAccent,
                            unit: '°C'),
                      ),
                    ],
                  ),

                  SizedBox(height: context.hp(2.5)),

                  // Chart container
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2B2B2B), Color(0xFF1A1A1A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(context.wp(3)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(context.wp(4)),
                    width: double.infinity,
                    height: context.hp(38),
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: vm.temperaturaSpots,
                            isCurved: true,
                            color: color,
                            barWidth: context.wp(0.8),
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
                                fontSize: context.rf(14),
                                color: Colors.white70,
                              ),
                            ),
                            axisNameSize: context.rf(18),
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: context.wp(8),
                              interval: 10,
                              getTitlesWidget: (value, _) => Padding(
                                padding: EdgeInsets.only(right: context.wp(1)),
                                child: Text(
                                  value.toStringAsFixed(0),
                                  style: TextStyle(
                                    fontSize: context.rf(11),
                                    color: Colors.white60,
                                  ),
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
                                  fontSize: context.rf(14),
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: context.wp(10),
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                final index = (value - minX).round();
                                if (index < 0 ||
                                    index >= vm.labels.length ||
                                    index % labelInterval != 0) {
                                  return const SizedBox.shrink();
                                }
                                return Padding(
                                  padding:
                                      EdgeInsets.only(top: context.hp(0.5)),
                                  child: Text(
                                    vm.labels[index],
                                    style: TextStyle(
                                      fontSize: context.rf(11),
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
                              color: color.withOpacity(0.6),
                              width: context.wp(0.3)),
                        ),
                        lineTouchData: LineTouchData(
                          enabled: true,
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: color,
                            tooltipRoundedRadius: context.wp(2),
                            tooltipPadding: EdgeInsets.all(context.wp(2)),
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                final index = (spot.x - minX).round();
                                final time =
                                    (index >= 0 && index < vm.labels.length)
                                        ? vm.labels[index]
                                        : '';
                                return LineTooltipItem(
                                  'Hora: $time\nTemp: ${spot.y.toStringAsFixed(2)} °C',
                                  TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.rf(11),
                                  ),
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

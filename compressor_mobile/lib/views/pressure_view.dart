part of '_views_lib.dart';

class PressureView extends StatefulWidget {
  final String titulo;
  final TipoPressao tipo;
  final Color color;

  const PressureView({
    super.key,
    required this.titulo,
    required this.tipo,
    required this.color,
  });

  @override
  State<PressureView> createState() => _PressureViewState();
}

class _PressureViewState extends State<PressureView> {
  late final CompressorDadosViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = CompressorDadosViewModel();
    vm.startPressure(widget.tipo);
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  double _currentPressure() {
    switch (widget.tipo) {
      case TipoPressao.arComprimido:
        return vm.pressaoArComprimido;
      case TipoPressao.carga:
        return vm.pressaoCarga;
      case TipoPressao.alivio:
        return vm.pressaoAlivio;
    }
  }

  double _maxY() {
    switch (widget.tipo) {
      case TipoPressao.arComprimido:
        return 12; 
      case TipoPressao.carga:
        return 12;
      case TipoPressao.alivio:
        return 10;
    }
  }

  String _unit() => 'bar';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth < 400 ? 11.0 : 13.0;
    final color = widget.color;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Content(
        title: "SENAI",
        body: AnimatedBuilder(
          animation: vm,
          builder: (_, __) {
            if (vm.isLoading && vm.pressaoSpots.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.pressaoSpots.isEmpty) {
              return const Center(
                child: Text(
                  "Sem dados",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            final spots = vm.pressaoSpots;
            final minX = spots.first.x;
            final maxX = spots.last.x;

            final minPressao = spots.map((e) => e.y).reduce(min);
            final maxPressao = spots.map((e) => e.y).reduce(max);
            final avgPressao =
                spots.map((e) => e.y).reduce((a, b) => a + b) / spots.length;

            final currentPressure = _currentPressure();

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.speed, color: color, size: 30),
                          const SizedBox(width: 8),
                          Text(
                            widget.titulo,
                            style: GoogleFonts.poppins(
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
                            style: GoogleFonts.poppins(
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
                      '${currentPressure.toStringAsFixed(2)} ${_unit()}',
                      style: GoogleFonts.orbitron(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: color,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: _maxY(),
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0,
                              endValue: _maxY() * 0.45,
                              color: Colors.orange),
                          GaugeRange(
                              startValue: _maxY() * 0.45,
                              endValue: _maxY() * 0.75,
                              color: Colors.green),
                          GaugeRange(
                              startValue: _maxY() * 0.75,
                              endValue: _maxY(),
                              color: Colors.red),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(
                            value: currentPressure,
                            needleColor: color,
                          ),
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Text(
                              '${currentPressure.toStringAsFixed(1)} ${_unit()}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                            angle: 90,
                            positionFactor: 0.8,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StatCard(
                          label: 'Mínima',
                          value: minPressao,
                          color: Colors.blueAccent,
                          unit: _unit()),
                      const SizedBox(width: 8),
                      StatCard(
                          label: 'Média',
                          value: avgPressao,
                          color: Colors.orangeAccent,
                          unit: _unit()),
                      const SizedBox(width: 8),
                      StatCard(
                          label: 'Máxima',
                          value: maxPressao,
                          color: Colors.redAccent,
                          unit: _unit()),
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
                            spots: spots,
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
                        minY: 0,
                        maxY: _maxY(),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          horizontalInterval: (_maxY() / 4),
                          getDrawingHorizontalLine: (_) =>
                              FlLine(color: Colors.white10, strokeWidth: 1),
                          getDrawingVerticalLine: (_) =>
                              FlLine(color: Colors.white10, strokeWidth: 1),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            axisNameWidget: const Text(
                              'Pressão (bar)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white70),
                            ),
                            axisNameSize: 25,
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              interval: (_maxY() / 4),
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
                            axisNameWidget: const Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(
                                'Horário',
                                style: TextStyle(
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

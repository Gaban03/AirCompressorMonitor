part of '_views_lib.dart';

class CompressorFalhasView extends StatefulWidget {
  const CompressorFalhasView({super.key});

  @override
  State<CompressorFalhasView> createState() => _CompressorFalhasViewState();
}

class _CompressorFalhasViewState extends State<CompressorFalhasView> {
  late final CompressorFalhasViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = CompressorFalhasViewModel();
    vm.loadPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Content(
        title: "SENAI",
        body: AnimatedBuilder(
          animation: vm,
          builder: (_, __) {
            if (vm.isLoading && vm.falhas.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.error != null) {
              return Center(
                child: Text(
                  "Erro: ${vm.error}",
                  style: GoogleFonts.orbitron(color: Colors.redAccent),
                ),
              );
            }

            return Column(
              children: [
                Paginator(
                  page: vm.page,
                  totalPages: vm.totalPages,
                  onNext: vm.nextPage,
                  onPrev: vm.previousPage,
                  onFirst: vm.firstPage,
                  onLast: vm.lastPageCall,
                ),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => vm.loadPage(vm.page),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: vm.falhas.length,
                      itemBuilder: (context, index) {
                        return FalhaCard(falha: vm.falhas[index]);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

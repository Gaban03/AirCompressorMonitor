part of '_views_lib.dart';

class ConfigIpView extends StatefulWidget {
  const ConfigIpView({super.key});

  @override
  State<ConfigIpView> createState() => _ConfigIpViewState();
}

class _ConfigIpViewState extends State<ConfigIpView> {
  late final ConfigIPViewModel vm;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    vm = ConfigIPViewModel();
    vm.init();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: vm,
      builder: (_, __) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: const Color(0xFF101010),
            body: Content(
              title: "SENAI",
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: vm.ipController,
                        label: "Endereço IP",
                        hint: "Ex: 192.168.0.1",
                        prefixIcon: Icons.language,
                        validator: vm.validarIP,
                      ),
                      const SizedBox(height: 22),
                      CustomTextField(
                        controller: vm.portAPIController,
                        label: "Porta da API",
                        hint: "Ex: 5000",
                        prefixIcon: Icons.api,
                        validator: vm.validarPorta,
                      ),
                      const SizedBox(height: 36),
                      SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD32F2F),
                            foregroundColor: Colors.white,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            shadowColor: Colors.redAccent.withOpacity(0.4),
                          ),
                          onPressed: vm.isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState?.validate() != true)
                                    return;

                                  await vm.salvarDados();

                                  if (!vm.hasError) {
                                    AppSnackBar.show(
                                      context,
                                      message:
                                          "Configurações salvas com sucesso!",
                                      type: SnackType.success,
                                    );
                                  } else {
                                    AppSnackBar.show(
                                      context,
                                      message: vm.errorMessage ??
                                          "Falha ao salvar as configurações",
                                      type: SnackType.error,
                                    );
                                  }
                                },
                          child: vm.isLoading
                              ? const SizedBox(
                                  width: 26,
                                  height: 26,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : Text(
                                  'Salvar Configurações',
                                  style: GoogleFonts.orbitron(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      NetworkInfoCard(
                        connectionType: vm.connectionType,
                        ssid: vm.ssid,
                        localIP: vm.localIP,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

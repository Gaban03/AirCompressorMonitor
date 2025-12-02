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
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;
    final rf = context.rf;

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
                padding: EdgeInsets.symmetric(
                  horizontal: wp(5),
                  vertical: hp(3),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: hp(2)),
                      CustomTextField(
                        controller: vm.ipController,
                        label: "Endereço IP",
                        hint: "Ex: 192.168.0.1",
                        prefixIcon: Icons.language,
                        validator: vm.validarIP,
                      ),
                      SizedBox(height: hp(2.5)),
                      CustomTextField(
                        controller: vm.portAPIController,
                        label: "Porta da API",
                        hint: "Ex: 5000",
                        prefixIcon: Icons.api,
                        validator: vm.validarPorta,
                      ),
                      SizedBox(height: hp(4)),
                      SizedBox(
                        height: hp(7),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD32F2F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: vm.isLoading
                              ? null
                              : () async {
                                  if (!_formKey.currentState!.validate())
                                    return;

                                  await vm.salvarDados();

                                  AppSnackBar.show(
                                    context,
                                    message: vm.hasError
                                        ? vm.errorMessage ?? "Erro ao salvar"
                                        : "Configurações salvas!",
                                    type: vm.hasError
                                        ? SnackType.error
                                        : SnackType.success,
                                  );
                                },
                          child: vm.isLoading
                              ? SizedBox(
                                  width: wp(7),
                                  height: wp(7),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : Text(
                                  "Salvar Configurações",
                                  style: GoogleFonts.orbitron(
                                    fontSize: rf(18),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: hp(5)),
                      NetworkInfoCard(
                        connectionType: vm.connectionType,
                        ssid: vm.ssid,
                        localIP: vm.localIP,
                      ),
                      SizedBox(height: hp(2)),
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

part of "_view_model_lib.dart";

class CompressorFalhasViewModel extends ChangeNotifier {
  final CompressorService _service = getIt<CompressorService>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<CompressorFalhasDto> falhas = [];

  String? error;
  int page = 0;
  int size = 5;

  int totalPages = 1;
  int totalElements = 0;
  bool first = true;
  bool last = false;

  Future<void> loadPage(int newPage, {int idCompressor = 1}) async {
    _isLoading = true;
    error = null;
    notifyListeners();

    try {
      final p = await _service.fetchFalhas(
        idCompressor: idCompressor,
        page: newPage,
        size: size,
      );

      falhas = p.content;
      totalPages = p.totalPages;
      totalElements = p.totalElements;
      page = p.page;
      first = p.first;
      last = p.last;
    } catch (e) {
      error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> nextPage() => loadPage(page + 1);
  Future<void> previousPage() => loadPage(page - 1);
  Future<void> firstPage() => loadPage(0);
  Future<void> lastPageCall() => loadPage(totalPages - 1);
}

part of '_dto_lib.dart';

class PageDTO<T> {
  final List<T> content;
  final int totalPages;
  final int totalElements;
  final int page;
  final int size;
  final bool first;
  final bool last;

  PageDTO({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.page,
    required this.size,
    required this.first,
    required this.last,
  });

  factory PageDTO.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PageDTO<T>(
      content:
          (json['content'] as List).map((item) => fromJsonT(item)).toList(),
      totalPages: json['totalPages'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
      page: json['number'] ?? 0,
      size: json['size'] ?? 0,
      first: json['first'] ?? true,
      last: json['last'] ?? true,
    );
  }
}

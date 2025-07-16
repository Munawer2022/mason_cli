class Pagination {
  Pagination({
    required this.page,
    required this.limit,
    required this.currentRecords,
    required this.totalRecords,
    required this.totalPages,
  });

  final int page;
  final int limit;
  final int currentRecords;
  final int totalRecords;
  final int totalPages;

  Pagination copyWith({
    int? page,
    int? limit,
    int? currentRecords,
    int? totalRecords,
    int? totalPages,
  }) {
    return Pagination(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      currentRecords: currentRecords ?? this.currentRecords,
      totalRecords: totalRecords ?? this.totalRecords,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json["page"] ?? 0,
      limit: json["limit"] ?? 0,
      currentRecords: json["currentRecords"] ?? 0,
      totalRecords: json["totalRecords"] ?? 0,
      totalPages: json["totalPages"] ?? 0,
    );
  }
}

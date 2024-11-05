class Pagination {
  final int currentPage;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  Pagination({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'],
      pageSize: json['page_size'],
      totalItems: json['total_items'],
      totalPages: json['total_pages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'page_size': pageSize,
      'total_items': totalItems,
      'total_pages': totalPages,
    };
  }

  @override
  String toString() {
    return 'Pagination(currentPage: $currentPage, pageSize: $pageSize, totalItems: $totalItems, totalPages: $totalPages)';
  }
}

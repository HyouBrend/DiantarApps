import 'package:diantar_jarak/data/models/history_perjalanan_model/history_perjalanan_model.dart';

abstract class HistoryPengantaranState {
  const HistoryPengantaranState();
  Map<String, String> get currentFilters => {};
}

class HistoryLoading extends HistoryPengantaranState {}

class HistoryLoaded extends HistoryPengantaranState {
  final List<HistoryPengantaranModel> histories;
  final bool hasReachedMax;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  @override
  final Map<String, String> currentFilters; // Ensure this field exists
  final double? totalJarak;

  HistoryLoaded({
    required this.histories,
    required this.hasReachedMax,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.currentFilters,
    this.totalJarak,
  });

  List<Object?> get props => [
        histories,
        hasReachedMax,
        currentPage,
        totalPages,
        totalItems,
        currentFilters,
        totalJarak,
      ];

  HistoryLoaded copyWith({
    List<HistoryPengantaranModel>? histories,
    bool? hasReachedMax,
    int? currentPage,
    int? totalPages,
    int? totalItems,
    Map<String, String>? currentFilters,
    double? totalJarak,
  }) {
    return HistoryLoaded(
      histories: histories ?? this.histories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      currentFilters: currentFilters ?? this.currentFilters,
      totalJarak: totalJarak ?? this.totalJarak,
    );
  }
}

class HistoryError extends HistoryPengantaranState {
  final String message;

  const HistoryError(this.message);
}

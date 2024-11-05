// events.dart
abstract class HistoryPengantaranEvent {
  const HistoryPengantaranEvent();
}

class FetchHistoryPengantaran extends HistoryPengantaranEvent {
  final int page;
  final int pageSize;
  final Map<String, String> filters;

  const FetchHistoryPengantaran({
    required this.page,
    required this.pageSize,
    required this.filters,
  });
}

class UpdateFilters extends HistoryPengantaranEvent {
  final Map<String, String> filters;

  const UpdateFilters(this.filters);
}

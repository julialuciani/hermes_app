class FetchMovementsFilters {
  final int? movementTypeId;
  final DateTime dateStart;
  final DateTime dateEnd;
  final int? categoryId;

  FetchMovementsFilters({
    this.movementTypeId,
    required this.dateStart,
    required this.dateEnd,
    this.categoryId,
  });
}

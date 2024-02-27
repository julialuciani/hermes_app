import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';
import 'package:intl/intl.dart';

class MovementTypeModel extends BaseModel<MovementTypeModel> {
  final String name;
  final String? totalValue;
  final List<MovementModel> movements;

  const MovementTypeModel({
    required int? id,
    required this.name,
    this.totalValue,
    this.movements = const [],
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory MovementTypeModel.fromMap(Map<String, dynamic> map) {
    return MovementTypeModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      totalValue: map['total_value'] as String?,
    );
  }

  MovementTypeModel copyWith({
    String? name,
    String? totalValue,
    List<MovementModel>? movements,
  }) {
    return MovementTypeModel(
      id: id,
      name: name ?? this.name,
      totalValue: totalValue ?? this.totalValue,
      movements: movements ?? this.movements,
    );
  }

  String get getSumOfAllmovements {
    double sum = 0;
    for (var movement in movements) {
      sum += movement.value ?? 0.0;
    }

    final locale = Intl.systemLocale;
    final formatter = CurrencyTextInputFormatter(locale: locale);

    return formatter.formatDouble(sum);
  }
}

import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String indastry;

  const CompanyEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.indastry,
  });

  @override
  List<Object?> get props => [id, name, description, indastry];
}

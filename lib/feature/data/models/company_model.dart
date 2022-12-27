import 'package:job_aggregator/feature/domain/entities/company_entity.dart';

class CompanyModel extends CompanyEntity {
  const CompanyModel({
    required id,
    required name,
    required description,
    required indastry,
  }) : super(
          id: id,
          name: name,
          description: description,
          indastry: indastry,
        );

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        indastry: json['indastry']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'indastry': indastry,
    };
  }
}

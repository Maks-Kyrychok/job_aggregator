import 'package:equatable/equatable.dart';
import 'package:job_aggregator/feature/domain/entities/company_entity.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object?> get props => [];
}

class CompanyEmpty extends CompanyState {
  @override
  List<Object?> get props => [];
}

class CompanyLoading extends CompanyState {
  final List<CompanyEntity> oldCompaniesList;

  const CompanyLoading(
    this.oldCompaniesList,
  );
  @override
  List<Object?> get props => [oldCompaniesList];
}

class CompanyLoaded extends CompanyState {
  final List<CompanyEntity> companiesList;

  const CompanyLoaded(this.companiesList);

  @override
  List<Object?> get props => [companiesList];
}

class CompanyError extends CompanyState {
  final String message;

  const CompanyError({required this.message});

  @override
  List<Object?> get props => [message];
}

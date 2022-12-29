import 'package:equatable/equatable.dart';

abstract class CompaniesSearchEvent extends Equatable {
  const CompaniesSearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchCompanies extends CompaniesSearchEvent {
  // final String companyQuery;

  // const SearchCompanies({required this.companyQuery});
}

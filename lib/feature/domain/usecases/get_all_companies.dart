import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:job_aggregator/core/error/failure.dart';
import 'package:job_aggregator/core/usecases/usecase.dart';
import 'package:job_aggregator/feature/domain/entities/company_entity.dart';

import '../repositories/company_repository.dart';

class GetAllCompanies extends UseCase<List<CompanyEntity>, PageCompanyParams> {
  final CompanyRepository companyRepository;

  GetAllCompanies(this.companyRepository);

  @override
  Future<Either<Failure, List<CompanyEntity>>> call(
      PageCompanyParams params) async {
    return await companyRepository.getAllCompanies();
  }
}

class PageCompanyParams extends Equatable {
  @override
  List<Object?> get props => [];
}

import 'package:dartz/dartz.dart';
import 'package:job_aggregator/feature/domain/entities/company_entity.dart';
import '../../../core/error/failure.dart';

abstract class JobCompany {
  Future<Either<Failure, List<CompanyEntity>>> getAllCompanies();
  Either<Failure, CompanyEntity> postCompany();
}

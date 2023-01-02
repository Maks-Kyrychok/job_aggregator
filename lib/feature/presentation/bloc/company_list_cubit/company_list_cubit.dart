import 'package:bloc/bloc.dart';
import 'package:job_aggregator/core/error/failure.dart';
import 'package:job_aggregator/feature/domain/usecases/get_all_companies.dart';

import '../../../domain/entities/company_entity.dart';
import 'company_list_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cached Failure';

class CompanyListCubit extends Cubit<CompanyState> {
  final GetAllCompanies getAllCompanies;
  CompanyListCubit({required this.getAllCompanies}) : super(CompanyEmpty());

  void loadCompany() async {
    if (state is CompanyLoading) return;
    final currentState = state;
    var oldCompanies = <CompanyEntity>[];
    if (currentState is CompanyLoaded) {
      oldCompanies = currentState.companiesList;
    }

    emit(CompanyLoading(
      oldCompanies,
    ));

    final failureOrCompany = await getAllCompanies(PageCompanyParams());
    failureOrCompany.fold(
        (error) => emit(CompanyError(message: _mapFailureToMessage(error))),
        (company) {
      final companies = (state as CompanyLoading).oldCompaniesList;
      companies.addAll(company);
      emit(CompanyLoaded(company));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}

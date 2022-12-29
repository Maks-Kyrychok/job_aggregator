import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:job_aggregator/feature/presentation/bloc/search_bloc/search_companies/search_companies_event.dart';
import 'package:job_aggregator/feature/presentation/bloc/search_bloc/search_companies/search_companies_state.dart';

import '../../../../../core/error/failure.dart';
import '../../../../domain/usecases/get_all_companies.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cached Failure';

class CompaniesSearchBloc
    extends Bloc<CompaniesSearchEvent, CompaniesSearchState> {
  final GetAllCompanies getAllCompanies;

  CompaniesSearchBloc({required this.getAllCompanies})
      : super(CompaniesSearchEmpty()) {
    on<SearchCompanies>(_onEvent);
  }

  FutureOr<void> _onEvent(
      SearchCompanies event, Emitter<CompaniesSearchState> emit) async {
    emit(CompaniesSearchLoading());
    final failureOrCompany = await getAllCompanies.call(PageCompanyParams());
    emit(failureOrCompany.fold(
        (failure) =>
            CompaniesSearchError(message: _mapFailureToMessage(failure)),
        (companies) => CompaniesSearchLoaded(companies: companies)));
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

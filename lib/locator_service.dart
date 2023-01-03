import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:job_aggregator/core/platform/network_info.dart';
import 'package:job_aggregator/feature/data/datasources/company_local_data_source.dart';
import 'package:job_aggregator/feature/data/datasources/company_remote_data_source.dart';
import 'package:job_aggregator/feature/data/repositories/company_repository_impl.dart';
import 'package:job_aggregator/feature/domain/repositories/company_repository.dart';
import 'package:job_aggregator/feature/domain/usecases/get_all_companies.dart';
import 'package:job_aggregator/feature/domain/usecases/get_all_jobs.dart';
import 'package:job_aggregator/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/presentation/bloc/search_bloc/search_companies/search_companies_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc / cubit
  sl.registerFactory(() => CompanyListCubit(getAllCompanies: sl()));
  sl.registerFactory(() => CompaniesSearchBloc(getAllCompanies: sl()));
  //UseCases
  sl.registerLazySingleton(() => GetAllCompanies(sl()));
  sl.registerLazySingleton(() => GetAllJobs(sl()));
  //Repository
  sl.registerLazySingleton<CompanyRepository>(() => CompanyRepositoryImpl(
        localDataSource: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));
  sl.registerLazySingleton<CompanyRemoteDataSource>(
      () => CompanyRemoteDataSourceImpl(
            client: http.Client(),
          ));

  sl.registerLazySingleton<CompanyLocalDataSource>(
      () => CompanyLocalDataSourceImpl(
            sharedPreferences: sl(),
          ));
  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworInfoImpl(sl()),
  );
  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

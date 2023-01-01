import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_aggregator/common/app_colors.dart';
import 'package:job_aggregator/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:job_aggregator/locator_service.dart' as di;

import 'feature/presentation/bloc/search_bloc/search_companies/search_companies_bloc.dart';
import 'feature/presentation/pages/companies_page.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CompanyListCubit>(
          create: (context) => sl<CompanyListCubit>()..loadCompany(),
        ),
        BlocProvider<CompaniesSearchBloc>(
          create: (context) => sl<CompaniesSearchBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: const HomePage(),
      ),
    );
  }
}

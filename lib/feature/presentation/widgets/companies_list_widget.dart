import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_aggregator/feature/presentation/bloc/company_list_cubit/company_list_state.dart';

import '../../domain/entities/company_entity.dart';
import '../bloc/company_list_cubit/company_list_cubit.dart';

class CompaniesList extends StatelessWidget {
  const CompaniesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyListCubit, CompanyState>(
      builder: (context, state) {
        List<CompanyEntity> companies = [];
        if (state is CompanyLoading) {
          return _loadingIndicator();
        } else if (state is CompanyLoaded) {
          companies = state.companiesList;
        }
        return ListView.separated(
            itemBuilder: (context, index) {
              return Text('${companies[index]}');
            },
            separatorBuilder: (context, index) {
              return Divider(color: Colors.grey[400]);
            },
            itemCount: companies.length);
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

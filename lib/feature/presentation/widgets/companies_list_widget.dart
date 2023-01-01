import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_aggregator/feature/presentation/bloc/company_list_cubit/company_list_state.dart';

import '../../domain/entities/company_entity.dart';
import '../bloc/company_list_cubit/company_list_cubit.dart';
import 'company_card_widget.dart';

class CompaniesList extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<CompanyListCubit>().loadCompany();
        }
      }
    });
  }

  CompaniesList({super.key});

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<CompanyListCubit, CompanyState>(
      builder: (context, state) {
        List<CompanyEntity> companies = [];
        bool isLoading = false;
        if (state is CompanyLoading) {
          return _loadingIndicator();
        } else if (state is CompanyLoading) {
          companies = state.oldCompaniesList;
          isLoading == true;
        } else if (state is CompanyLoaded) {
          companies = state.companiesList;
        }
        return ListView.separated(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < companies.length) {
                return CompanyCard(company: companies[index]);
              } else {
                Timer(Duration(milliseconds: 30), () {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                });
                return _loadingIndicator();
              }
            },
            separatorBuilder: (context, index) {
              return Divider(color: Colors.grey[400]);
            },
            // ignore: dead_code
            itemCount: companies.length + (isLoading ? 1 : 0));
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

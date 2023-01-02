import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_aggregator/feature/presentation/widgets/job_card_widget.dart';

import '../../domain/entities/job_entity.dart';
import '../bloc/job_list_cubit/job_list_cubit.dart';
import '../bloc/job_list_cubit/job_list_state.dart';

class JobsList extends StatelessWidget {
  final scrollController = ScrollController();

  JobsList({super.key});

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<JobListCubit>().loadJob();
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<JobListCubit, JobState>(
      builder: (context, state) {
        List<JobEntity> jobs = [];
        bool isLoading = false;
        if (state is JobLoading) {
          return _loadingIndicator();
        } else if (state is JobLoading) {
          jobs = state.oldJobList;
          isLoading == true;
        } else if (state is JobLoaded) {
          jobs = state.jobsList;
        }
        return ListView.separated(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < jobs.length) {
                return JobCard(jobs: jobs[index]);
              } else {
                Timer(const Duration(milliseconds: 30), () {
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
            itemCount: jobs.length + (isLoading ? 1 : 0));
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

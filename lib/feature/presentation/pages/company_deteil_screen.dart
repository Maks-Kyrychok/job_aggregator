import 'package:flutter/material.dart';
import 'package:job_aggregator/feature/domain/entities/company_entity.dart';

import '../widgets/jobs_list.dart';

class CompanyDeteilScreen extends StatelessWidget {
  final CompanyEntity company;

  const CompanyDeteilScreen({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company.name),
        centerTitle: true,
      ),
      body: JobsList(),
    );
  }
}

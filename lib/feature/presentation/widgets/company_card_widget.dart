import 'package:flutter/material.dart';
import 'package:job_aggregator/common/app_colors.dart';
import 'package:job_aggregator/feature/domain/entities/company_entity.dart';
import 'package:job_aggregator/feature/presentation/pages/company_deteil_screen.dart';

class CompanyCard extends StatelessWidget {
  final CompanyEntity company;
  const CompanyCard({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => CompanyDeteilScreen(company: company)),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.cellBackground,
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                company.name,
                style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Id: ${company.id}',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Company description: ${company.description}',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Industry: ${company.industry}',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

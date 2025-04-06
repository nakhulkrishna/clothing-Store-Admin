import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/table/data_table.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/widgets/dashboard_card.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/widgets/order_status_pie_chart.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/widgets/weekly_sales.dart';


class DashboardMobile extends StatelessWidget {
  const DashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Text(
                "Dashboard",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              TDhasboardCard(
                title: 'Sales total',
                subtitle: '\$365.6',
                status: 25,
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              TDhasboardCard(
                title: 'Sales total',
                subtitle: '\$365.6',
                status: 25,
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              TDhasboardCard(
                title: 'Sales total',
                subtitle: '\$365.6',
                status: 25,
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              TDhasboardCard(
                title: 'Sales total',
                subtitle: '\$365.6',
                status: 25,
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              WeeklySales(),
              SizedBox(height: TSizes.spaceBtwSections),
              // Orders
              TRoundedContainer(
                child: Column(
                  children: [
                    Text(
                      "Recent Orders",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    const DashboardDataTable(),
                  ],
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              OrderStatusPieChart(),
            ],
          ),
        ),
      ),
    );
  }
}

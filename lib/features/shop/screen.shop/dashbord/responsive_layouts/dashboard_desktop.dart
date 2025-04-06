import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/product_images_controller.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/table/data_table.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/widgets/dashboard_card.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/widgets/order_status_pie_chart.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/widgets/weekly_sales.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // heading
              Text(
                "Dashboard",
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              ElevatedButton(
                onPressed: () => controller.selectedThumbnailImages(),
                child: Text("Select single image"),
              ),
              ElevatedButton(
                onPressed: () => controller.selectedMultipleProductsImages(),
                child: Text("Select mutilple image"),
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              // dashBoard card
              Row(
                children: [
                  Expanded(
                    child: TDhasboardCard(
                      title: 'Sales total',
                      subtitle: '\$365.6',
                      status: 25,
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDhasboardCard(
                      title: 'Sales total',
                      subtitle: '\$365.6',
                      status: 25,
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDhasboardCard(
                      title: 'Sales total',
                      subtitle: '\$365.6',
                      status: 25,
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDhasboardCard(
                      title: 'Sales total',
                      subtitle: '\$365.6',
                      status: 25,
                    ),
                  ),
                ],
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              // GRAPHS
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Bar Graph
                        WeeklySales(),
                        SizedBox(height: TSizes.spaceBtwSections),

                        // Orders
                        TRoundedContainer(
                          child: Column(
                            children: [
                              Text(
                                "Recent Orders",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: TSizes.spaceBtwSections),
                              const DashboardDataTable(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwSections),
                  Expanded(child: OrderStatusPieChart()),
                ],
              ),

              //Pie chart
            ],
          ),
        ),
      ),
    );
  }
}

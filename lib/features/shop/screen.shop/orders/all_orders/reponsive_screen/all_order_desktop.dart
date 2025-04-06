import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/table_header.dart';
import 'package:thestyldclubadmin/common/widgets/loaders/loader_animation.dart';
import 'package:thestyldclubadmin/features/shop/controller/order/order_controller.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/all_orders/table/order_table.dart';

class AllOrderDesktop extends StatelessWidget {
  const AllOrderDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreadcrumsWithHeading(
                heading: "Orders",
                breadcrumitem: ['Orders'],
              ),

              SizedBox(height: TSizes.spaceBtwSections),

              TRoundedContainer(
                child: Column(
                  children: [
                    TableHeader(
                      showLeftWidgets: false,
                      searchOnchanged: (q) => controller.seacrhQuery(q),
                      searchController: controller.searchTextController,
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Obx(() {
                      if (controller.isLoading.value) return TLoaderAnimation();
                      return OrderTable();
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

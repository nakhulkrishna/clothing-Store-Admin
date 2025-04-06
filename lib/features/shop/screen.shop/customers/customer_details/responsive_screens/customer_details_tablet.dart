import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/customer_details/widgets/customer_info.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/customer_details/widgets/customer_orders.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/customer_details/widgets/shpping_addres.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class CustomerDetailsTablet extends StatelessWidget {
  const CustomerDetailsTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreadcrumsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Nakhul Krishna',
                breadcrumitem: ["Details", Routes.customers],
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              CustomerInfo(),
              SizedBox(height: TSizes.spaceBtwSections),
              ShppingAddres(),
              SizedBox(height: TSizes.spaceBtwSections),
              CustomerOrders(),
            ],
          ),
        ),
      ),
    );
  }
}

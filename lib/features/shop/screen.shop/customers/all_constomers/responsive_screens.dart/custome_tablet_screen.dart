import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/table_header.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/all_constomers/table/customer_table.dart';

class CustomeTabletScreen extends StatelessWidget {
  const CustomeTabletScreen({super.key});

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
                heading: "Customers",
                breadcrumitem: ["Customers"],
              ),

              SizedBox(height: TSizes.spaceBtwSections),

              TRoundedContainer(
                child: Column(
                  children: [
                    TableHeader(showLeftWidgets: false),
                    SizedBox(height: TSizes.spaceBtwItems),

                    CustomerTable(),
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

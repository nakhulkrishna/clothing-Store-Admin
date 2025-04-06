import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/customer_details/table/customer_order_table.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Orders", style: Theme.of(context).textTheme.headlineMedium),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Total Spent"),
                    TextSpan(
                      text: "\$500.35",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.apply(color: TColors.primary),
                    ),
                    TextSpan(
                      text: 'on ${5} orders',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: TSizes.spaceBtwItems),

          TextFormField(
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: 'Search Orders',
              prefixIcon: Icon(Iconsax.search_normal),
            ),
          ),

          SizedBox(height: TSizes.spaceBtwSections),
          CustomerOrderTable(),
        ],
      ),
    );
  }
}

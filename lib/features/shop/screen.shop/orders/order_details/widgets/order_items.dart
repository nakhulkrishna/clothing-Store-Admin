import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/utils/helpers/pricing_calculator.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:thestyldclubadmin/features/shop/models/orderModel.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});
  final Ordermodel order;
  @override
  Widget build(BuildContext context) {
    final subtotal = order.item.fold(
      0.0,
      (previous, elemet) => previous + (elemet.price * elemet.quantity),
    );
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Items", style: Theme.of(context).textTheme.headlineMedium),
          SizedBox(height: TSizes.spaceBtwSections),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final item = order.item[index];

              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        TRoundedImage(
                          backgroundColor: TColors.primaryBackground,
                          image: item.image ?? TImages.defaultImage,
                          imageType:
                              item.image != null
                                  ? ImageType.network
                                  : ImageType.network,
                        ),

                        SizedBox(width: TSizes.spaceBtwItems),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),

                              if (item.selectedvariation != null)
                                Text(
                                  item.selectedvariation!.entries
                                      .map((e) => ('${e.key} : ${e.value}'))
                                      .toString(),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: TSizes.spaceBtwItems),

                  SizedBox(
                    width: TSizes.xl * 2,
                    child: Text(
                      '\$${item.price.toStringAsFixed(1)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    width:
                        TDeviceUtils.isMobileScreen(context)
                            ? TSizes.xl * 1.4
                            : TSizes.xl * 2,
                    child: Text(
                      '\$${item.quantity.toStringAsFixed(1)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    width:
                        TDeviceUtils.isMobileScreen(context)
                            ? TSizes.xl * 1.4
                            : TSizes.xl * 2,
                    child: Text(
                      '\$${item.price.toStringAsFixed(1)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: TSizes.spaceBtwItems),
            itemCount: order.item.length,
          ),

          SizedBox(height: TSizes.spaceBtwSections),

          TRoundedContainer(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            backgroundColor: TColors.primaryBackground,
            child: Column(
              children: [
                SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$$subtotal',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$0.0',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shpping',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${TPricingCalculator.calculateShippingCost(subtotal, "")}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${TPricingCalculator.calculateTax(subtotal, "")}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),

                SizedBox(height: TSizes.spaceBtwItems),
                Divider(),
                SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${TPricingCalculator.calculateTotalPrice(subtotal, "")}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

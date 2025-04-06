import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:thestyldclubadmin/features/shop/models/orderModel.dart';

class TransactionInfo extends StatelessWidget {
  const TransactionInfo({super.key, required this.order});

  final Ordermodel order;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transactions",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: TSizes.spaceBtwSections),
          Row(
            children: [
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Row(
                  children: [
                    TRoundedImage(
                      imageType: ImageType.asset,
                      image: TImages.paypal,
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment Via ${order.paymentMethod.capitalize}",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "${order.paymentMethod.capitalize} fee \$25",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "April 21, 2025",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "${order.totalAmount} fee \$25",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

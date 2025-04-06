import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          SizedBox(height: TSizes.spaceBtwSections),

          Row(
            children: [
              TRoundedImage(
                imageType: ImageType.asset,
                image: TImages.user,
                backgroundColor: TColors.primaryBackground,
                padding: 0,
              ),
              SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Coding with t ",
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "support@codingwitht.com",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: TSizes.spaceBtwSections),

          Row(
            children: [
              SizedBox(width: 120, child: Text('Username')),
              Text(":"),
              SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  "cwt ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          SizedBox(width: TSizes.spaceBtwItems),
          Row(
            children: [
              SizedBox(width: 120, child: Text('Country')),
              Text(":"),
              SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  "India ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          SizedBox(width: TSizes.spaceBtwItems),
          Row(
            children: [
              SizedBox(width: 120, child: Text('Phone Number')),
              Text(":"),
              SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  "89398232 ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          SizedBox(width: TSizes.spaceBtwItems),

          Divider(),
          SizedBox(width: TSizes.spaceBtwItems),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last Order :",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    Text("7 days Ago "),
                  ],
                ),
              ),
              // SizedBox(height: TSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Average Order Value",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text("\$899"),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: TSizes.spaceBtwItems / 2),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Registered",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text("customer.formattedDate"),
                  ],
                ),
              ),
              // SizedBox(height: TSizes.spaceBtwItems * 1),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email Marketing",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text("Subscribed"),
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

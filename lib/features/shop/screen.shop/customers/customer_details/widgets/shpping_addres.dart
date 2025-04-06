import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';

class ShppingAddres extends StatelessWidget {
  const ShppingAddres({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shipping Address",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: TSizes.spaceBtwSections),

          Row(
            children: [
              SizedBox(width: 120, child: Text("Name")),
              Text(":"),
              SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  "Coding With t",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 120, child: Text("Country")),
              Text(":"),
              SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  "India",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 120, child: Text("Phone Number")),
              Text(":"),
              SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  "8273313",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 120, child: Text("Address")),
              Text(":"),
              SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  "Kerala , Malappuram , Tirurangadi PO , Paroli House",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

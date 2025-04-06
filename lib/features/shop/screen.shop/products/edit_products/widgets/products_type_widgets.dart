import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';

class ProductsTypeWidgets extends StatelessWidget {
  const ProductsTypeWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Products Type", style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(width: TSizes.spaceBtwItems),

        RadioMenuButton(
          value: ProductType.single,
          groupValue: ProductType.single,
          onChanged: (value) {},
          child: Text('Single'),
        ),
        RadioMenuButton(
          value: ProductType.variable,
          groupValue: ProductType.variable,
          onChanged: (value) {},
          child: Text('Single'),
        ),
      ],
    );
  }
}

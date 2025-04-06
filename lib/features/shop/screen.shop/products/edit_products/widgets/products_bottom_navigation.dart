import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';

class ProductsBottomNavigation extends StatelessWidget {
  const ProductsBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(onPressed: () {}, child: Text("Discard")),
          SizedBox(width: TSizes.spaceBtwItems / 2),
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Save Changes"),
            ),
          ),
        ],
      ),
    );
  }
}

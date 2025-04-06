import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

class ProductsCategorys extends StatelessWidget {
  const ProductsCategorys({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text("Categories", style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: TSizes.spaceBtwItems),
          MultiSelectDialogField(
            title: Text("Categories"),
            buttonText: Text("Select Categories"),
            items: [
              MultiSelectItem(
                CategoryModel(
                  name: "Shoes",
                  id: "id",
                  image: "image",
                
                ),
                "Shoes",
              ),

              MultiSelectItem(
                CategoryModel(
                  name: "Shoes",
                  id: "id",
                  image: "image",

                ),
                "Shoes",
              ),
            ],
            listType: MultiSelectListType.CHIP,
            onConfirm: (onConfirm) {},
          ),
        ],
      ),
    );
  }
}

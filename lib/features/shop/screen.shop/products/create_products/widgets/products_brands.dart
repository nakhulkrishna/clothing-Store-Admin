import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/shimmers/shimmer.dart';
import 'package:thestyldclubadmin/features/shop/controller/brand/brand_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/create_product_controller.dart';


class ProductsBrands extends StatelessWidget {
  const ProductsBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(CreateProductController());
    final brandController = Get.put(BrandController());

    if (brandController.allItems.isEmpty) {
      brandController.fecthItems();
    }
    return TRoundedContainer(
      child: Column(
        children: [
          Text("Brand", style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: TSizes.spaceBtwItems),

          Obx(
            () =>
                brandController.isLoading.value
                    ? const TShimmerEffect(width: double.infinity, height: 50)
                    : TypeAheadField(
                      builder: (context, ctr, focusNode) {
                        return TextFormField(
                          focusNode: focusNode,
                          controller: controllers.brandTextField = ctr,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Select Brand',
                            suffixIcon: Icon(Iconsax.box),
                          ),
                        );
                      },
                      itemBuilder: (context, value) {
                        return ListTile(title: Text(value.name));
                      },
                      onSelected: (onSelected) {
                        controllers.selectedBrand.value = onSelected;
                        controllers.brandTextField.text = onSelected.name;
                      },
                      suggestionsCallback: (pattern) {
                        return brandController.allItems
                            .where((brand) => brand.name.contains(pattern))
                            .toList();
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

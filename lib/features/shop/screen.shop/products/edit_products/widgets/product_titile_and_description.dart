import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/validators/validation.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/edit_products_controller.dart';

class ProductTitileAndDescription extends StatelessWidget {
  const ProductTitileAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    return TRoundedContainer(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Basic Information",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: TSizes.spaceBtwItems),

            TextFormField(
              controller: controller.title,
              decoration: InputDecoration(labelText: "Product Title"),
              validator:
                  (value) =>
                      TValidator.validateEmptyText("Product Title", value),
            ),

            SizedBox(height: TSizes.spaceBtwInputFields),
            SizedBox(
              height: 300,
              child: TextFormField(
                controller: controller.description,
                expands: true,
                maxLines: null,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                validator:
                    (value) => TValidator.validateEmptyText(
                      "Product Desciprion",
                      value,
                    ),

                decoration: InputDecoration(
                  labelText: 'Product Description',
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

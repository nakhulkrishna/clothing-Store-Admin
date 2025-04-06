import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/validators/validation.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/create_product_controller.dart';

class ProductsStockAndPricing extends StatelessWidget {
  const ProductsStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

    return Obx(
      () =>
          controller.productType.value == ProductType.single
              ? Form(
                key: controller.stockPriceFromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.45,
                      child: TextFormField(
                        controller: controller.stock,
                        decoration: InputDecoration(
                          labelText: "Stock",
                          hintText: "Add Stock, only numbers are allowed",
                        ),
                        validator:
                            (value) =>
                                TValidator.validateEmptyText("Stock", value),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(height: TSizes.spaceBtwInputFields),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.price,
                            decoration: InputDecoration(
                              labelText: "Price",
                              hintText: "Price with up-to 2 decimals",
                            ),
                            validator:
                                (value) => TValidator.validateEmptyText(
                                  "Price",
                                  value,
                                ),
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?d{0,2}$'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: TSizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            controller: controller.salePrice,
                            decoration: InputDecoration(
                              labelText: "Discounted Price",
                              hintText: "Price with up-to 2 decimals",
                            ),

                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?d{0,2}$'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              : SizedBox.shrink(),
    );
  }
}

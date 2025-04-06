import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:thestyldclubadmin/features/shop/controller/order/order_details_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/orderModel.dart';

class CustomerInformation extends StatelessWidget {
  const CustomerInformation({super.key, required this.order});
  final Ordermodel order;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TRoundedContainer(
          padding: EdgeInsets.all(TSizes.defaultSpace),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              Row(
                children: [
                  TRoundedImage(
                    padding: 0,
                    backgroundColor: TColors.primaryBackground,
                    imageType:
                        controller.customer.value.profilePicture.isNotEmpty
                            ? ImageType.network
                            : ImageType.asset,
                    image:
                        controller.customer.value.profilePicture.isNotEmpty
                            ? controller.customer.value.profilePicture
                            : TImages.user,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.customer.value.fullname,
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          controller.customer.value.email,
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: TSizes.spaceBtwSections),

        Obx(
          () => SizedBox(
            width: double.infinity,
            child: TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Person",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    controller.customer.value.fullname,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text(
                    controller.customer.value.email,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text(
                    controller.customer.value.phoneNumber,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: TSizes.spaceBtwSections),

        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shipping Address",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: TSizes.spaceBtwSections),
                Text(
                  "${order.addressModel!.flat} ${order.addressModel!.landmark} ",
                  style: Theme.of(context).textTheme.titleSmall,
                ),

                SizedBox(height: TSizes.spaceBtwItems / 2),
                Text(
                  "${order.addressModel!.state} ${order.addressModel!.city} ${order.addressModel!.street} ${order.addressModel!.pincode} ",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: TSizes.spaceBtwSections),

        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Billing Address",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(height: TSizes.spaceBtwSections),
                Text(
                  "${order.addressModel!.flat} ${order.addressModel!.landmark} ",
                  style: Theme.of(context).textTheme.titleSmall,
                ),

                SizedBox(height: TSizes.spaceBtwItems / 2),
                Text(
                  "${order.addressModel!.state} ${order.addressModel!.city} ${order.addressModel!.street} ${order.addressModel!.pincode} ",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}

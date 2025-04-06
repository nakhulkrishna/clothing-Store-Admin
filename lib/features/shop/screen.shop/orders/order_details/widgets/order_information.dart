import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/utils/helpers/helper_functions.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/shimmers/shimmer.dart';
import 'package:thestyldclubadmin/features/shop/controller/order/order_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/orderModel.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});

  final Ordermodel order;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    controller.orderStatus.value = order.status;
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Text(
            "Order Information",
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          SizedBox(height: TSizes.spaceBtwSections),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date"),
                    Text(
                      order.formattedOrderDate,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("items"),
                    Text(
                      '${order.item.length} Items',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Status"),
                    Obx(() {
                      if (controller.statusLoader.value)
                        return TShimmerEffect(
                          width: double.infinity,
                          height: 55,
                        );
                      return TRoundedContainer(
                        radius: TSizes.cardRadiusSm,
                        backgroundColor: THelperFunctions.getOrderStatusColor(
                          controller.orderStatus.value,
                        ).withOpacity(0.1),
                        child: DropdownButton<OrderStatus>(
                          padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: TSizes.sm,
                          ),
                          value: controller.orderStatus.value,

                          items:
                              OrderStatus.values.map((OrderStatus s) {
                                return DropdownMenuItem(
                                  value: s,
                                  child: Text(
                                    s.name.capitalize.toString(),
                                    style: TextStyle(
                                      color:
                                          THelperFunctions.getOrderStatusColor(
                                            controller.orderStatus.value,
                                          ),
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (OrderStatus? value) {
                            if (value != null) {
                              controller.updateOrderStatus(order, value);
                            }
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total"),
                    Text(
                      '${order.totalAmount} Items',
                      style: Theme.of(context).textTheme.bodyLarge,
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

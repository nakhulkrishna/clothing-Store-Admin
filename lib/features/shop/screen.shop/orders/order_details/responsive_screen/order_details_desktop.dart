import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/utils/helpers/helper_functions.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/features/shop/models/orderModel.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/customer_details/widgets/customer_info.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/order_details/widgets/customer_info.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/order_details/widgets/order_information.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/order_details/widgets/order_items.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/order_details/widgets/transaction_info.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class OrderDetailsDesktop extends StatelessWidget {
  const OrderDetailsDesktop({super.key, required this.order});
  final Ordermodel order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreadcrumsWithHeading(
                returnToPreviousScreen: true,
                heading: order.id,
                breadcrumitem: [Routes.allOrder, 'Details'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        OrderInfo(order: order),
                        SizedBox(height: TSizes.spaceBtwSections),
                        OrderItems(order: order),
                        SizedBox(height: TSizes.spaceBtwSections),
                        TransactionInfo(order: order),
                      ],
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwSections),

                  Expanded(
                    child: Column(
                      children: [
                        CustomerInformation(order: order,),
                        SizedBox(height: TSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/helpers/helper_functions.dart';

import 'package:thestyldclubadmin/features/shop/models/orderModel.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weekSales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmount = <OrderStatus, double>{}.obs;

  static final List<Ordermodel> orders = [
    Ordermodel(
      deliveyDate: DateTime(2025, 3, 23),
      status: OrderStatus.delivered,
      id: 'CWT0013', // Unique ID
      userId: "1",
      totalAmount: 799,
      orderDate: DateTime(2025, 3, 23),
    ),
    Ordermodel(
      deliveyDate: DateTime(2025, 3, 24),
      status: OrderStatus.delivered,
      id: 'CWT0025', // Unique ID
      userId: "1",
      totalAmount: 799,
      orderDate: DateTime(2025, 3, 24),
    ),
    Ordermodel(
      deliveyDate: DateTime(2025, 3, 25),
      status: OrderStatus.delivered,
      id: 'CWT00256', // Unique ID
      userId: "1",
      totalAmount: 1299,
      orderDate: DateTime(2025, 3, 25),
    ),
    Ordermodel(
      deliveyDate: DateTime(2025, 3, 28),
      status: OrderStatus.shipped,
      id: 'CWT00152', // Unique ID
      userId: "1",
      totalAmount: 899,
      orderDate: DateTime(2025, 3, 28),
    ),
    Ordermodel(
      deliveyDate: DateTime(2025, 3, 27),
      status: OrderStatus.delivered,
      id: 'CWT1536', // Unique ID
      userId: "1",
      totalAmount: 599,
      orderDate: DateTime(2025, 3, 27),
    ),

    Ordermodel(
      deliveyDate: DateTime(2025, 3, 23),
      status: OrderStatus.delivered,
      id: 'CWT0013', // Unique ID
      userId: "1",
      totalAmount: 799,
      orderDate: DateTime(2025, 3, 23),
    ),
    Ordermodel(
      deliveyDate: DateTime(2025, 3, 24),
      status: OrderStatus.delivered,
      id: 'CWT0025', // Unique ID
      userId: "1",
      totalAmount: 799,
      orderDate: DateTime(2025, 3, 24),
    ),
    Ordermodel(
      deliveyDate: DateTime(2025, 3, 25),
      status: OrderStatus.delivered,
      id: 'CWT00256', // Unique ID
      userId: "1",
      totalAmount: 1299,
      orderDate: DateTime(2025, 3, 25),
    ),
    Ordermodel(
      deliveyDate: DateTime(2025, 3, 28),
      status: OrderStatus.shipped,
      id: 'CWT00152', // Unique ID
      userId: "1",
      totalAmount: 899,
      orderDate: DateTime(2025, 3, 28),
    ),
    Ordermodel(
      deliveyDate: DateTime(2025, 3, 27),
      status: OrderStatus.delivered,
      id: 'CWT1536', // Unique ID
      userId: "1",
      totalAmount: 599,
      orderDate: DateTime(2025, 3, 27),
    ),

    // More orders...
  ];

  @override
  void onInit() {
    _calculateWeekSales();
    _calculateOrderStatusData();

    super.onInit();
  }

  void _calculateWeekSales() {
    //Rest week sales to zero
    weekSales.value = List<double>.filled(7, 0.0);
    for (var order in orders) {
      final DateTime orderWeekStart = THelperFunctions.getStartOfWeek(
        order.orderDate,
      );

      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;
        index = index < 0 ? index + 7 : index;
        weekSales[index] += order.totalAmount;
      }
    }
    log(
      "Week sales after calculation: $weekSales",
    ); // Add this to ensure the values are being set.
  }

  void _calculateOrderStatusData() {
    // Reset status data
    orderStatusData.clear();

    // Map to store total amounts for each status
    totalAmount.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orders) {
      final status = order.status;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;
      totalAmount[status] = (totalAmount[status] ?? 0) + order.totalAmount;
    }
  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.shipped:
        return 'Shipped';
      default:
        return 'unknown';
    }
  }
}

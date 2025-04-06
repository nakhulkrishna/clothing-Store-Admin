import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/helpers/helper_functions.dart';
import 'package:thestyldclubadmin/data/services.cloud_storage/addressmodel.dart';


// import 'cart_item_model.dart'; // Uncomment if you have a CartItemModel class

class Ordermodel {
  final String id;
  final String userId;
  final double totalAmount;
  final DateTime orderDate;
  final OrderStatus status;
  final String paymentMethod;
  final Addressmodel? addressModel;
  final DateTime? deliveyDate;
  // final List<CartItemModel>? items; // List of cart items

  Ordermodel({
    required this.status,
    this.paymentMethod = 'COD',
    this.addressModel,
    this.deliveyDate,
    required this.id,
    this.userId = '',
    required this.totalAmount,
    required this.orderDate,
    // this.items,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate =>
      deliveyDate != null
          ? THelperFunctions.getFormattedDate(deliveyDate!)
          : '';

  String get orderStatusText {
    switch (status) {
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.shipped:
        return 'Shipment on the way';
      case OrderStatus.processing:
        return 'Processing';
      default:
        return 'Unknown';
    }
  }

  // Convert Ordermodel to JSON format for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'totalAmount': totalAmount,
      'orderDate': Timestamp.fromDate(orderDate),
      'status': status.name,
      'paymentMethod': paymentMethod,
      'addressModel': addressModel?.toMap(),
      'deliveyDate':
          deliveyDate != null ? Timestamp.fromDate(deliveyDate!) : null,
      // 'items': items?.map((item) => item.toMap()).toList(),
    };
  }

  // Create Ordermodel from Firestore snapshot
  factory Ordermodel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return Ordermodel(
      id: document.id,
      userId: data['userId'] ?? '',
      totalAmount: (data['totalAmount'] as num?)?.toDouble() ?? 0.0,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      status: OrderStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => OrderStatus.processing,
      ),
      paymentMethod: data['paymentMethod'] ?? 'COD',
      addressModel:
          data['addressModel'] != null
              ? Addressmodel.fromMap(data['addressModel'])
              : null,
      deliveyDate:
          data['deliveyDate'] != null
              ? (data['deliveyDate'] as Timestamp).toDate()
              : null,
      // items:
      //     data['items'] != null
      //         ? (data['items'] as List)
      //             .map((item) => CartItemModel.fromMap(item))
      //             .toList()
      //         : null,
    );
  }
}

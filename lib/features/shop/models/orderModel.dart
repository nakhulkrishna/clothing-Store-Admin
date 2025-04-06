import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/helpers/helper_functions.dart';
import 'package:thestyldclubadmin/data/services.cloud_storage/addressmodel.dart';
import 'package:thestyldclubadmin/features/shop/models/cart_model.dart';

class Ordermodel {
  final String id;
  final String docId;
  final String userId;
  final double totalAmount;
  final DateTime orderDate;
  final String shippingCost;
  final double taxCost;
   OrderStatus status;
  final String paymentMethod;
  final Addressmodel? addressModel;
  final Addressmodel? billingAddress;
  final DateTime? deliveyDate;
  final bool billingAddressSameAsShipping;
  final List<CartModel> item;

  Ordermodel({
    required this.id,
    required this.docId,
    required this.userId,
    required this.totalAmount,
    required this.orderDate,
    required this.shippingCost,
    required this.taxCost,
    required this.status,
    this.paymentMethod = 'cash on delivery',
    this.addressModel,
    this.billingAddress,
    this.deliveyDate,
    required this.billingAddressSameAsShipping,
    required this.item,
  });


  /// Empty instance for defaults
  factory Ordermodel.empty() => Ordermodel(
    id: '',
    docId: '',
    userId: '',
    totalAmount: 0.0,
    orderDate: DateTime.now(),
    shippingCost: '0',
    taxCost: 0.0,
    status: OrderStatus.processing,
    paymentMethod: 'cash on delivery',
    addressModel: null,
    billingAddress: null,
    deliveyDate: null,
    billingAddressSameAsShipping: true,
    item: [],
  );

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

  /// Convert Ordermodel to JSON format for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'docId': docId,
      'userId': userId,
      'totalAmount': totalAmount,
      'orderDate': Timestamp.fromDate(orderDate),
      'shippingCost': shippingCost,
      'taxCost': taxCost,
      'status': status.name,
      'paymentMethod': paymentMethod,
      'addressModel': addressModel?.toMap(),
      'billingAddress': billingAddress?.toMap(),
      'deliveyDate':
          deliveyDate != null ? Timestamp.fromDate(deliveyDate!) : null,
      'billingAddressSameAsShipping': billingAddressSameAsShipping,
      'item': item.map((cartItem) => cartItem.toJson()).toList(),
    };
  }

  /// Create Ordermodel from Firestore snapshot
  factory Ordermodel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return Ordermodel(
      id: data['id'] ?? '',
      docId: document.id,
      userId: data['userId'] ?? '',
      totalAmount: (data['totalAmount'] as num?)?.toDouble() ?? 0.0,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      shippingCost: data['shippingCost'] ?? '',
      taxCost: (data['taxCost'] as num?)?.toDouble() ?? 0.0,
      status: OrderStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => OrderStatus.processing,
      ),
      paymentMethod: data['paymentMethod'] ?? 'COD',
      addressModel:
          data['addressModel'] != null
              ? Addressmodel.fromMap(
                Map<String, dynamic>.from(data['addressModel']),
              )
              : null,
      billingAddress:
          data['billingAddress'] != null
              ? Addressmodel.fromMap(
                Map<String, dynamic>.from(data['billingAddress']),
              )
              : null,
      deliveyDate:
          data['deliveyDate'] != null
              ? (data['deliveyDate'] as Timestamp).toDate()
              : null,
      billingAddressSameAsShipping:
          data['billingAddressSameAsShipping'] ?? false,
      item:
          data['item'] != null
              ? (data['item'] as List)
                  .map(
                    (item) =>
                        CartModel.fromJson(Map<String, dynamic>.from(item)),
                  )
                  .toList()
              : [],
    );
  }
}

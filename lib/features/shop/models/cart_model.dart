// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedvariation;

  CartModel({
    required this.productId,
    required this.quantity,
    this.title = '',
    this.price = 0.0,
    this.image,
    this.variationId = '',
    this.brandName,
    this.selectedvariation,
  });

  static CartModel empty() => CartModel(productId: '', quantity: 0);

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'selectedvariation': selectedvariation,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'] ?? '',
      title: json['title'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      image: json['image'],
      quantity: json['quantity'] ?? 0,
      variationId: json['variationId'] ?? '',
      brandName: json['brandName'],
      selectedvariation:
          json['selectedvariation'] != null
              ? Map<String, String>.from(json['selectedvariation'])
              : null,
    );
  }
}

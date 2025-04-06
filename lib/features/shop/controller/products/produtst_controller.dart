import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/data/abstract/base_data_controller.dart';
import 'package:thestyldclubadmin/data/repositorys/products_repository/products_repository.dart';
import 'package:thestyldclubadmin/features/media/models/products_model.dart';

class ProductController extends BaseDataController<ProductModel> {
  static ProductController get instance => Get.find();

  final _productRepository = Get.put(ProductsRepository());

  @override
  bool containsSeacrhQuery(ProductModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.brand!.name.toLowerCase().contains(query.toLowerCase()) ||
        item.stock.toString().contains(query) ||
        item.price.toString().contains(query);
  }

  @override
  Future<void> deleteItem(ProductModel item) async {
    await _productRepository.deleteProduct(item);
  }

  @override
  Future<List<ProductModel>> fecthItems() async {
    return await _productRepository.getAllProducts();
  }

  void sortbyName(int sortColumnindex, bool ascending) {
    sortByProperty(
      sortColumnindex,
      ascending,
      (ProductModel product) => product.title.toLowerCase(),
    );
  }

  void sortbyPrice(int sortColumnindex, bool ascending) {
    sortByProperty(
      sortColumnindex,
      ascending,
      (ProductModel product) => product.price,
    );
  }

  void sortbyStock(int sortColumnindex, bool ascending) {
    sortByProperty(
      sortColumnindex,
      ascending,
      (ProductModel product) => product.stock,
    );
  }

  void sortbySoldItems(int sortColumnindex, bool ascending) {
    sortByProperty(
      sortColumnindex,
      ascending,
      (ProductModel product) => product.soldQuantity,
    );
  }

  String getProductPrice(ProductModel product) {
    if (product.productsType == ProductType.single.toString() ||
        product.prodcutsVariations!.isEmpty) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price)
          .toString();
    } else {
      double smallestPrice = double.infinity;
      double largestPrice = 0.0;

      for (var variation in product.prodcutsVariations!) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        return "$smallestPrice - $largestPrice";
      }
    }
  }

  String? calculateSalePrecentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double precentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return precentage.toStringAsFixed(0);
  }

  String getProductStockTotal(ProductModel product) {
    return product.productsType == ProductType.single.toString()
        ? product.stock.toString()
        : product.prodcutsVariations!
            .fold<int>(
              0,
              (previousValues, element) => previousValues + element.stock,
            )
            .toString();
  }

  String getProductSoldQuantity(ProductModel product) {
    return product.productsType == ProductType.single.toString()
        ? product.soldQuantity.toString()
        : product.prodcutsVariations!
            .fold<int>(
              0,
              (previousValues, element) =>
                  previousValues + element.soldQuantity,
            )
            .toString();
  }

  String getProductStockStatus(ProductModel product) {
    return product.stock > 0 ? 'In Stock' : 'out of stock';
  }
}

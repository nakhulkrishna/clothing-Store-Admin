import 'package:get/get.dart';
import 'package:thestyldclubadmin/data/abstract/base_data_controller.dart';
import 'package:thestyldclubadmin/data/repositorys/brands/brands_repositories.dart';
import 'package:thestyldclubadmin/features/shop/models/brandmodel.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';

class BrandController extends BaseDataController<Brandmodel> {
  static BrandController get instance => Get.find();
  final _brandRepository = Get.put(BrandsRepositorie());

  final categoriesController = Get.put(CategorysController());

  @override
  bool containsSeacrhQuery(Brandmodel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(Brandmodel item) async {
    await _brandRepository.deleteBrands(item);
  }

  @override
  Future<List<Brandmodel>> fecthItems() async {
    final fetchedBrands = await _brandRepository.getAllBrands();

    final fetchedBrandsCategories =
        await _brandRepository.getAllBrandsCategories();

    if (categoriesController.allItems.isEmpty) {
      await categoriesController.fecthData();
    }

    for (var brand in fetchedBrands) {
      List<String> categoroyIds =
          fetchedBrandsCategories
              .where((brandCategory) => brandCategory.brandId == brand.id)
              .map((brandCategory) => brandCategory.categoryid)
              .toList();

      brand.brandCategories =
          categoriesController.allItems
              .where((item) => categoroyIds.contains(item.id))
              .toList();
    }

    return fetchedBrands;
  }

  // SORTING
  sortByName(int sortColumnIndex, bool ascending) async {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (Brandmodel category) => category.name.toLowerCase(),
    );
  }
  // @override
  // Future<void> deleteItem(Brandmodel item) {
  //   // TODO: implement deleteItem
  //   throw UnimplementedError();
  // }

  // @override
  // Future<List<Brandmodel>> fecthItems() async {
  //   try {
  //     final fetchBrands = await _brandRepository.getAllBrands();
  //     final fetchBrandsCategories =
  //         await _brandRepository.getAllBrandsCategories();

  //     if (categoriesController.allItems.isEmpty) {
  //       await categoriesController.fecthData();
  //     }

  //     for (var brand in fetchBrands) {
  //       List<String> categoriesIds =
  //           fetchBrandsCategories
  //               .where((bc) => bc.brandId == brand.id)
  //               .map((bc) => bc.categoryid)
  //               .toList();

  //       brand.brandCategories =
  //           categoriesController.allItems
  //               .where((item) => categoriesIds.contains(item.id))
  //               .toList();
  //     }

  //     return fetchBrands;
  //   } catch (e, stackTrace) {
  //     print('❌ Error in fetchItems: $e');
  //     print('🧾 StackTrace: $stackTrace');
  //     return []; // Return empty list on failure
  //   }
  // }

  // @override
  // bool containsSeacrhQuery(Brandmodel ietms, String query) {
  //   // TODO: implement containsSeacrhQuery
  //   throw UnimplementedError();
  // }

  // // @override
  // // Future<List<Brandmodel>> fecthItems() async {
  // //   final fecthBrands = await _brandRepository.getAllBrands();

  // //   final fecthBrandsCategories =
  // //       await _brandRepository.getAllBrandsCategories();

  // //   if (categoriesController.allItems.isNotEmpty)
  // //     await categoriesController.fectData();

  // //   for (var brand in fecthBrands) {
  // //     List<String> categoriesIds =
  // //         fecthBrandsCategories
  // //             .where((brandCategories) => brandCategories.brandId == brand.id)
  // //             .map((brandCategories) => brandCategories.categoryid)
  // //             .toList();

  // //     brand.brandCategories =
  // //         categoriesController.allItems
  // //             .where((items) => categoriesIds.contains(items.id))
  // //             .toList();
  // //   }
  // //   return fecthBrands;
  // // }
}

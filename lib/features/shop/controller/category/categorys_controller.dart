import 'package:get/get.dart';
import 'package:thestyldclubadmin/data/abstract/base_data_controller.dart';
import 'package:thestyldclubadmin/data/repositorys/categorys/category_repositories.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

class CategorysController extends BaseDataController<CategoryModel> {
  
 // GETTER AND VAERIBELS
  static CategorysController get instance => Get.find();
  final _categoryRepository = Get.put(CategoryRepositories());

  // SERCHING
  @override
  bool containsSeacrhQuery(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  // DELETING
  @override
  Future<void> deleteItem(CategoryModel item) async {
    await _categoryRepository.deleteCategories(item.id);
  }

  // FETCHING CATEGORIES
  @override
  Future<List<CategoryModel>> fecthItems() async {
    return await _categoryRepository.getALlCategories();
  }

  // SORTING
  sortByName(int sortColumnIndex, bool ascending) async {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (CategoryModel category) => category.name.toLowerCase(),
    );
  }
}

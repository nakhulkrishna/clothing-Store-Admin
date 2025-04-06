import 'package:get/get.dart';
import 'package:thestyldclubadmin/data/abstract/base_data_controller.dart';
import 'package:thestyldclubadmin/data/repositorys/banner_repositorys/banner_repositories.dart';
import 'package:thestyldclubadmin/features/shop/models/banner_model.dart';

class BannerController extends BaseDataController<BannerModel> {
  // INSTANCE
  static BannerController get instance => Get.find();

  final _bannerRepositorys = Get.put(BannerRepositories());

  @override
  bool containsSeacrhQuery(ietms, String query) {
    // TODO: implement containsSeacrhQuery
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItem(item) async {
    await _bannerRepositorys.deleteBanner(item);
  }

  @override
  Future<List<BannerModel>> fecthItems() async {
    return await _bannerRepositorys.getAllBanners();
  }

   String formatRoute(String route) {
    if (route.isEmpty) return "";

    String formatted = route.substring(1);

    formatted = formatted[0].toUpperCase() + formatted.substring(1);

    return formatted;
  }


  // final isLoading = false.obs;

  // Future<void> deleteItem(BannerModel item) async {
  //   await _bannerRepositorys.deleteBanner(item);
  // }

  // Future<List<BannerModel>> fecthItem() async {
  //   return await _bannerRepositorys.getAllBanners();
  // }

  // String formatRoute(String route) {
  //   if (route.isEmpty) return "";

  //   String formatted = route.substring(1);

  //   formatted = formatted[0].toUpperCase() + formatted.substring(1);

  //   return formatted;
  // }

  // void addItemsToList(BannerModel newRecord) {}
}

import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/data/repositorys/user_repository/user_repository.dart';
import 'package:thestyldclubadmin/features/authentication/models/models.dart';
import 'package:thestyldclubadmin/features/shop/models/orderModel.dart';

class OrderDetailsController extends GetxController {
  static OrderDetailsController get instance => Get.find();

  RxBool loading = true.obs;
  Rx<Ordermodel> order = Ordermodel.empty().obs;
  Rx<UserModels> customer = UserModels.empty().obs;

  Future<void> getCustomerOfCurrentOrder() async {
    try {
      loading.value = true;

      final user = await UserRepository.instance.fecthUserDetails(
        order.value.userId,
      );
      customer.value = user;
    } catch (e) {
      TLoaders.errorSnackBar(title: "oh Snap", message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}

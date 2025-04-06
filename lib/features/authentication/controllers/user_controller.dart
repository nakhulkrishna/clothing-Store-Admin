import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/features/authentication/models/models.dart';
import 'package:thestyldclubadmin/data/repositorys/user_repository/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  RxBool loading = false.obs;

  Rx<UserModels> user = UserModels.empty().obs;

  final userRepository = Get.put(UserRepository());
  @override
  void onInit() {
    fecthUserDetails();
    super.onInit();
  }

  //FECTH USER DETAILS FROM THE REPOSITORY
  Future<UserModels> fecthUserDetails() async {
    try {
      loading.value = true;
      final user = await userRepository.fecthAdminDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
        title: 'Something went wrong',
        message: e.toString(),
      );
      return UserModels.empty();
    }
  }
}

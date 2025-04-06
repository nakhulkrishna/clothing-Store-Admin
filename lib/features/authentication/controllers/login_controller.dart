import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/text_strings.dart';
import 'package:thestyldclubadmin/common/utils/helpers/network_manager.dart';
import 'package:thestyldclubadmin/common/utils/popups/full_screen_loader.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/features/authentication/models/models.dart';
import 'package:thestyldclubadmin/data/repositorys/authentication_repository/authentication_repository.dart';
import 'package:thestyldclubadmin/data/repositorys/user_repository/user_repository.dart';
import 'package:thestyldclubadmin/features/authentication/controllers/user_controller.dart';


class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //VARIBLES
  final hidePassword = true.obs;
  final remeberMe = false.obs;
  final localStorage = GetStorage();

  // TextedingControlls
  final email = TextEditingController();
  final password = TextEditingController();

  // Global key
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEBER_ME_EMIL') ?? "";
    password.text = localStorage.read('REMEBER_ME_PASSWORD') ?? "";
    super.onInit();
  }

  // Hnadles email and password sign in proces
  Future<void> emailAndPasswordSignIn() async {
    try {
      log("email and password sign in");
      // start loading
      TFullScreenLoader.openLoadingDialog(
        "Logging You in....",
        TImages.docerAnimation,
      );

      //check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save data if remeber me is selected
      if (remeberMe.value) {
        localStorage.write('REMEBER_ME_EMIL', email.text.trim());
        localStorage.write('REMEBER_ME_PASSWORD', password.text.trim());
      }
      //register user using email and password

      await AuthenticationRepository.instance.loginWithEmailandPassword(
        email.text.trim(),
        password.text.trim(),
      );
      //Fecth user details and assing to userController
      final user = await UserController.instance.fecthUserDetails();

      // remove loader

      TFullScreenLoader.stopLoading();

      if (user.role != AppRole.admin) {
        await AuthenticationRepository.instance.logout();
        TLoaders.errorSnackBar(
          title: 'Not Autherized',
          message: 'You are not autherized or do have access. Contact Admin',
        );
        log("email and password sign in done");
      } else {
        AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  //Handle registraion of admin user
  Future<void> registerAdmin() async {
    try {
      log("registaering");
      // start loading
      TFullScreenLoader.openLoadingDialog(
        "Registering Admin Account....",
        TImages.docerAnimation,
      );

      //check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //register user using email and password

      await AuthenticationRepository.instance.registerWithEmailAndPassword(
        TTexts.adminEmail,
        TTexts.adminPassword,
      );

      // create admin record in the firebase
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModels(
          firstName: 'nakhul',
          lastName: 'krishna',
          role: AppRole.admin,
          createdAt: DateTime.now(),
          id: AuthenticationRepository.instance.authUser!.uid,
          email: TTexts.adminEmail,
        ),
      );
      log("registaering............");
      // remove loader
      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}

import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:thestyldclubadmin/data/repositorys/authentication_repository/authentication_repository.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class RouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthenticationRepository.instance.isAuthernticated
        ? null
        : RouteSettings(name: Routes.login);
  }
}

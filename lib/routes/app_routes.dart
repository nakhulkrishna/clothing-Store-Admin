import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/forget_password/forget_password.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/login/login.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/reset_password/reset_password.dart';
import 'package:thestyldclubadmin/features/media/screens.media/media.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/all_banner/all_banners.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/create_banner/create_banner.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/edit_banner/edit_banner.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/allbrands/brands.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/create_brands/create_brands.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/edit_brands/edit_brands.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/allcategorys/categorys.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/create_category/create_categorys.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/edit_category/edit_categorys.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/all_constomers/costomer.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/customer_details/customer_details.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/dashboard_screen.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/all_orders/all_orders.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/order_details/order_details.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/all_products/products.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/create_products.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/edit_products/edit_products.dart';
import 'package:thestyldclubadmin/features/persnalizations/screens/profile/profile.dart';
import 'package:thestyldclubadmin/features/persnalizations/screens/settings/settings.dart';
import 'package:thestyldclubadmin/routes/route_middleware.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: Routes.login, page: () => LoginScreen()),
    GetPage(name: Routes.forgetPassword, page: () => ForgetPassword()),
    GetPage(name: Routes.resetPassword, page: () => ResetPassword()),
    GetPage(
      name: Routes.dashboard,
      page: () => DashboardScreen(),
      middlewares: [RouteMiddleware()],
    ),

    GetPage(
      name: Routes.media,
      page: () => MediaScreen(),
      middlewares: [RouteMiddleware()],
    ),

    GetPage(
      name: Routes.categorys,
      page: () => const CategorysScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.createCategories,
      page: () => const CreateCategorys(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.editCategories,
      page: () => const EditCategorys(),
      middlewares: [RouteMiddleware()],
    ),

    GetPage(
      name: Routes.brands,
      page: () => BrandsScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.createBrands,
      page: () => const CreateBrands(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.editBrands,
      page: () => const EditBrands(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.banners,
      page: () => const AllBanners(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.createBanner,
      page: () => const CreateBanner(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.editBanner,
      page: () => EditBanner(),

      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.products,
      page: () => const Products(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.editProducts,
      page: () => const EditProducts(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.createProducts,
      page: () => const CreateProducts(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.customers,
      page: () => const Customer(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.detailsCustomers,
      page: () => const CustomerDetails(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.allOrder,
      page: () => const AllOrders(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.orderDetails,
      page: () => const OrderDetails(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.profile,
      page: () => const Profile(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.settings,
      page: () => const Settings(),
      middlewares: [RouteMiddleware()],
    ),
    // GetPage(name: Routes.login ,page: ()=> const LoginScreen()),
    // GetPage(name: Routes.forgetPassword, page: () => const ForgetPasswordScreen()),
    // GetPage(name: Routes.resetPassword, page: () => const ResetPasswordScreen()),
    // GetPage(name: Routes.dashboard, page: ()=> const DashBoardScreen() ,middlewares:  [RouteMiddleware()]),
    // GetPage(name: Routes.media ,page: ()=> const MediaScreen(),middlewares:  [RouteMiddleware()]),

    // GetPage(
    //   name: Routes.categorys,
    //   page: () => const CategorysScreen(),
    //   middlewares: [RouteMiddleware()],
    // ),
    // GetPage(
    //   name: Routes.createCategories,
    //   page: () => const CreateCategoriesScreen(),
    //   middlewares: [RouteMiddleware()],
    // ),
    // GetPage(
    //   name: Routes.editCategories,
    //   page: () => const EditCategoriesScreen(),
    //   middlewares: [RouteMiddleware()],
    // ),
    // GetPage(
    //   name: Routes.brands,
    //   page: () => const BrandsScreen(),
    //   middlewares: [RouteMiddleware()],
    // ),
    // GetPage(
    //   name: Routes.editBrands,
    //   page: () => const EditBrandsScreen(),
    //   middlewares: [RouteMiddleware()],
    // ),
    // GetPage(
    //   name: Routes.createBrands,
    //   page: () => const CreateBrandsScreen(),
    //   middlewares: [RouteMiddleware()],
    // ),
    // GetPage(
    //   name: Routes.banners,
    //   page: () => const BannersScreen(),
    //   middlewares: [RouteMiddleware()],
    // ),
    // GetPage(
    //   name: Routes.banners,
    //   page: () => const BannersScreen(),
    //   middlewares: [RouteMiddleware()],
    // ),
    // GetPage(
    //   name: Routes.banners,
    //   page: () => const BannersScreen(),
    //   middlewares: [RouteMiddleware()],
    // ),
    // GetPage(
    //   name: Routes.sideMenuItems,
    //   page: () => const BannersScreen(),
    //   middlewares: [RouteMiddleware()],
    // ),
  ];
}

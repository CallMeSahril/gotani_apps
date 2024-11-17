import 'package:get/get.dart';

import '../modules/category_admin/category_form/bindings/category_form_binding.dart';
import '../modules/category_admin/category_form/views/category_form_view.dart';
import '../modules/category_admin/category_list/bindings/category_list_binding.dart';
import '../modules/category_admin/category_list/views/category_list_view.dart';
import '../modules/components/bindings/components_binding.dart';
import '../modules/components/views/components_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail.product/bindings/detail_product_binding.dart';
import '../modules/detail.product/views/detail_product_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/product_admin/detail_product_admin/bindings/detail_product_admin_binding.dart';
import '../modules/product_admin/detail_product_admin/views/detail_product_admin_view.dart';
import '../modules/product_admin/form_product/bindings/form_product_binding.dart';
import '../modules/product_admin/form_product/views/form_product_view.dart';
import '../modules/product_admin/product/bindings/product_binding.dart';
import '../modules/product_admin/product/views/product_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/splashhome/bindings/splashhome_binding.dart';
import '../modules/splashhome/views/splashhome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHHOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.COMPONENTS,
      page: () => const ComponentsView(),
      binding: ComponentsBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHHOME,
      page: () => const SplashhomeView(),
      binding: SplashhomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUCT,
      page: () => const DetailProductView(),
      binding: DetailProductBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.FORM_PRODUCT,
      page: () => const FormProductView(),
      binding: FormProductBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUCT_ADMIN,
      page: () => const DetailProductAdminView(),
      binding: DetailProductAdminBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_LIST,
      page: () => const CategoryListView(),
      binding: CategoryListBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_FORM,
      page: () => const CategoryFormView(),
      binding: CategoryFormBinding(),
    ),
  ];
}

import 'package:get/get.dart';

import '../modules/address/bindings/address_binding.dart';
import '../modules/address/bindings/address_binding.dart';
import '../modules/address/views/address_view.dart';
import '../modules/address/views/address_view.dart';
import '../modules/admin_category/category_form/bindings/category_form_binding.dart';
import '../modules/admin_category/category_form/views/category_form_view.dart';
import '../modules/admin_category/category_list/bindings/category_list_binding.dart';
import '../modules/admin_category/category_list/views/category_list_view.dart';
import '../modules/admin_notification/admin_detail_notifications/bindings/admin_detail_notifications_binding.dart';
import '../modules/admin_notification/admin_detail_notifications/views/admin_detail_notifications_view.dart';
import '../modules/admin_notification/admin_notifications/bindings/admin_notifications_binding.dart';
import '../modules/admin_notification/admin_notifications/views/admin_notifications_view.dart';
import '../modules/admin_product/detail_product_admin/bindings/detail_product_admin_binding.dart';
import '../modules/admin_product/detail_product_admin/views/detail_product_admin_view.dart';
import '../modules/admin_product/form_product/bindings/form_product_binding.dart';
import '../modules/admin_product/form_product/views/form_product_view.dart';
import '../modules/admin_product/product/bindings/product_binding.dart';
import '../modules/admin_product/product/views/product_view.dart';
import '../modules/category_products/bindings/category_products_binding.dart';
import '../modules/category_products/views/category_products_view.dart';
import '../modules/components/bindings/components_binding.dart';
import '../modules/components/views/components_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/dashboardpenjual/bindings/dashboardpenjual_binding.dart';
import '../modules/dashboardpenjual/views/dashboardpenjual_view.dart';
import '../modules/delivery/bindings/delivery_binding.dart';
import '../modules/delivery/views/delivery_view.dart';
import '../modules/detail.product/bindings/detail_product_binding.dart';
import '../modules/detail.product/views/detail_product_view.dart';
import '../modules/detail_product/bindings/detail_product_binding.dart';
import '../modules/detail_product/views/detail_product_view.dart';
import '../modules/detail_product_seller/bindings/detail_product_seller_binding.dart';
import '../modules/detail_product_seller/views/detail_product_seller_view.dart';
import '../modules/detail_transaction/bindings/detail_transaction_binding.dart';
import '../modules/detail_transaction/views/detail_transaction_view.dart';
import '../modules/edit_account/bindings/edit_account_binding.dart';
import '../modules/edit_account/views/edit_account_view.dart';
import '../modules/edit_produk/bindings/edit_produk_binding.dart';
import '../modules/edit_produk/views/edit_produk_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/register_penjual/bindings/register_penjual_binding.dart';
import '../modules/register_penjual/views/register_penjual_view.dart';
import '../modules/search_products/bindings/search_products_binding.dart';
import '../modules/search_products/views/search_products_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/splashhome/bindings/splashhome_binding.dart';
import '../modules/splashhome/views/splashhome_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';
import '../modules/transaction_success/bindings/transaction_success_binding.dart';
import '../modules/transaction_success/views/transaction_success_view.dart';

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
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHHOME,
      page: () => const SplashhomeView(),
      binding: SplashhomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
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
    // GetPage(
    //   name: _Paths.DETAIL_PRODUCT_PENJUAL,
    //   page: () => const DetailProductPenjualView(),
    //   binding: DetailProductPenjualBinding(),
    // ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY,
      page: () => const DeliveryView(),
      binding: DeliveryBinding(),
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
    GetPage(
      name: _Paths.ADMIN_NOTIFICATIONS,
      page: () => const AdminNotificationsView(),
      binding: AdminNotificationsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DETAIL_NOTIFICATIONS,
      page: () => const AdminDetailNotificationsView(),
      binding: AdminDetailNotificationsBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARDPENJUAL,
      page: () => const DashboardpenjualView(),
      binding: DashboardpenjualBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUCT_SELLER,
      page: () => const DetailProductSellerView(),
      binding: DetailProductSellerBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_SUCCESS,
      page: () => const TransactionSuccessView(),
      binding: TransactionSuccessBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PRODUCTS,
      page: () => const SearchProductsView(),
      binding: SearchProductsBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_PRODUCTS,
      page: () => const CategoryProductsView(),
      binding: CategoryProductsBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_TRANSACTION,
      page: () => const DetailTransactionView(),
      binding: DetailTransactionBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ACCOUNT,
      page: () => const EditAccountView(),
      binding: EditAccountBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PRODUK,
      page: () => const EditProdukView(),
      binding: EditProdukBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PENJUAL,
      page: () => RegisterPenjualView(),
      binding: RegisterPenjualBinding(),
    ),
  ];
}

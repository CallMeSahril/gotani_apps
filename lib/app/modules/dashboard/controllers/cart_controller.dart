import 'package:get/get.dart';
import 'package:gotani_apps/app/data/model/cart_item.dart';

import '../model/model_address.dart';
import '../model/model_kabupaten.dart';
import '../model/model_province.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[
    CartItem(
      imageUrl:
          'https://smexpo.pertamina.com/data-smexpo/images/products/3282/galleries/2023051413095776932_1715080735.jpg',
      name: 'Pembasmi Rumput',
      price: 36000,
    ),
    CartItem(
      imageUrl:
          'https://smexpo.pertamina.com/data-smexpo/images/products/3282/galleries/2023051413095776932_1715080735.jpg',
      name: 'Arit',
      price: 50000,
    ),
    CartItem(
      imageUrl:
          'https://smexpo.pertamina.com/data-smexpo/images/products/3282/galleries/2023051413095776932_1715080735.jpg',
      name: 'Cangkul',
      price: 30000,
    ),
    CartItem(
      imageUrl:
          'https://smexpo.pertamina.com/data-smexpo/images/products/3282/galleries/2023051413095776932_1715080735.jpg',
      name: 'Racun Keong',
      price: 50000,
    ),
  ].obs;

  int get shippingFee => 0;
  ModelAddress get address => ModelAddress();

  int get subtotal => cartItems
      .where((item) => item.isSelected)
      .fold(0, (sum, item) => sum + (item.price * item.quantity));

  int get total => subtotal + shippingFee;

  void toggleSelection(int index) {
    cartItems[index].isSelected = !cartItems[index].isSelected;
    cartItems.refresh();
  }

  void incrementQuantity(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }
}

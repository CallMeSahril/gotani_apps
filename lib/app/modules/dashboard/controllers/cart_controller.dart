import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/model_address.dart';
import '../model/model_cart.dart';
import '../model/model_delivery_type.dart';

class CartController extends GetxController {
  var cartItems = <ModelCart>[].obs;
  Timer? _debounce;

  Rx<ModelDeliveryType> deliveryType = ModelDeliveryType().obs;

  int get shippingFee => 0;
  Rx<ModelAddress> address = ModelAddress().obs;

  int get subtotal => cartItems
      .where((item) => item.isSelected)
      .fold(0, (sum, item) => sum + (item.price ?? 0 * item.quantity!));

  int get total => subtotal + shippingFee;

  void toggleSelection(int index) {
    cartItems[index].isSelected = !cartItems[index].isSelected;
    cartItems.refresh();
  }

  void incrementQuantity(int index, VoidCallback onTap) {
    cartItems[index].quantity = cartItems[index].quantity! + 1;
    cartItems.refresh();
    _updateQuantityToAPI(index, onTap);
  }

  void decrementQuantity(int index, VoidCallback onTap) {
    if (cartItems[index].quantity! > 1) {
      cartItems[index].quantity = cartItems[index].quantity! - 1;
      cartItems.refresh();
      _updateQuantityToAPI(index, onTap);
    }
  }

  void _updateQuantityToAPI(int index, VoidCallback onTap) {
    _debounce?.cancel();

    _debounce = Timer(Duration(seconds: 1), () async {
      final item = cartItems[index];
      print("Sending to API: ${item.id}, quantity: ${item.quantity}");
      try {
        await onTap;
      } catch (e) {
        print("Failed to update quantity: $e");
      }
    });
  }

  Future<void> fetchCart() async {
    await ModelCart.fetchCarts().then((value) {
      cartItems.value = value;
      cartItems.refresh();
    });
  }

  void updateAddress() {}

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }
}

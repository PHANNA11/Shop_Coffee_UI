import 'dart:developer';

import 'package:get/state_manager.dart';
import 'package:shop_up/model/product_model.dart';

class ListCartController extends GetxController {
  RxList<ProductModel> listProducts = <ProductModel>[].obs;
  RxInt qty = 1.obs;
  Future<bool> addToCart({required ProductModel pro}) async {
    listProducts.add(pro);
    update();

    return true;
  }

  void increaseQty({required int index}) async {
    if (listProducts.isNotEmpty) {
      listProducts[index].qty = listProducts[index].qty! + 1;
      update();
    }
  }

  void decreaseQty({required int index}) async {
    if (listProducts.isNotEmpty) {
      if (listProducts[index].qty! > 1) {
        listProducts[index].qty = listProducts[index].qty! - 1;
        update();
      }
    }
  }
}

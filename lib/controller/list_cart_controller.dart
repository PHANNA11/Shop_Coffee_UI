import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shop_up/model/product_model.dart';

class ListCartController extends GetxController {
  RxList<ProductModel> listProducts = <ProductModel>[].obs;
  Future<bool> addToCart({required ProductModel pro}) async {
    if (listProducts.isEmpty ||
        listProducts.where((p0) => p0.id == pro.id).isEmpty) {
      listProducts.add(pro);
      update();
    } else {
      var index = listProducts.indexWhere((element) => element.id == pro.id);
      pro.qty = pro.qty! + listProducts[index].qty!;
      listProducts[index] = pro;
      // listProducts.replaceRange(
      //   (element) => element.id == pro.id,
      // );
      update();
    }

    return true;
  }
}

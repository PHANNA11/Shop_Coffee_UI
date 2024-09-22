import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_up/model/product_model.dart';

import '../controller/list_cart_controller.dart';

class DetailProductScreen extends StatefulWidget {
  DetailProductScreen({super.key, required this.pro});
  ProductModel? pro;
  // Data member

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final listCartController = Get.put(ListCartController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listCartController.qty.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListCartController>(builder: (context) {
      return Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.pro!.id.toString(),
                  child: Image(
                      height: 300,
                      width: Get.width,
                      image: NetworkImage(widget.pro!.image.toString())),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.pro!.name.toString(),
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$ ${widget.pro!.price}',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ],
                ),
                Text(
                  widget.pro!.desription.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                Column(
                  children: List.generate(
                    widget.pro!.varraints!.length,
                    (index) => Card(
                      elevation: 0,
                      child: CheckboxListTile(
                        value: false,
                        onChanged: (value) {},
                        title: Text(widget.pro!.varraints![index]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (listCartController.qty.value > 1) {
                            listCartController.qty.value =
                                listCartController.qty.value - 1;
                            listCartController.update();
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: const Center(
                            child: Icon(Icons.remove),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            listCartController.qty.toString(),
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          listCartController.qty.value =
                              listCartController.qty.value + 1;
                          listCartController.update();
                        },
                        child: Container(
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: const Center(
                            child: Icon(Icons.add),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
                top: 40,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                    )))
          ],
        ),
        // bottomSheet: CupertinoButton(
        //   color: Colors.blue,
        //   child: const Text('Buy now'),
        //   onPressed: () {},
        // ),
        bottomNavigationBar: Container(
          height: 60,
          width: Get.width,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  Icons.favorite,
                  size: 30,
                  color: widget.pro!.favorite! ? Colors.red : Colors.white,
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () async {
                    int index = listCartController.listProducts
                        .indexWhere((element) => element.id == widget.pro!.id);
                    if (index == -1) {
                      widget.pro!.qty = listCartController.qty.value;
                      listCartController
                          .addToCart(pro: widget.pro!)
                          .then((value) {
                        Get.defaultDialog(
                            titlePadding: const EdgeInsets.all(10),
                            title: 'PRODUCT',
                            middleText: 'Product was add to cart sucees',
                            confirm: CupertinoButton(
                              color: Colors.blue,
                              child: const Text('OK'),
                              onPressed: () {
                                Get.back();
                              },
                            ));
                      });
                    } else {
                      if (index >= 0) {
                        for (int i = 1;
                            i <= listCartController.qty.value;
                            i++) {
                          listCartController.increaseQty(index: index);
                          if (i == listCartController.qty.value) {
                            listCartController.qty.value = 0;
                            Get.defaultDialog(
                                titlePadding: const EdgeInsets.all(10),
                                title: 'PRODUCT',
                                middleText: 'Product was add to cart sucees',
                                confirm: CupertinoButton(
                                  color: Colors.blue,
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ));
                          }
                        }
                      }
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 30,
                      ),
                      Text(
                        'add to cart',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

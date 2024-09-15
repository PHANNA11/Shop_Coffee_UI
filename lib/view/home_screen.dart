import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:shop_up/controller/list_cart_controller.dart';
import 'package:shop_up/model/product_model.dart';
import 'package:shop_up/view/detail_product_screen.dart';
import 'package:shop_up/view/list_cart_screen.dart';

List<ProductModel> listCart = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFav = false;
  final listProducts = ProductModel().products;
  List<ProductModel> filterList = [];
  final listCartController = Get.put(ListCartController());
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('C o f f e e'.toUpperCase()),
        actions: [
          Center(
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListCartScreen(),
                      ));
                },
                child: Obx(
                  () => badges.Badge(
                    showBadge:
                        listCartController.listProducts.isEmpty ? false : true,
                    badgeContent:
                        Text(listCartController.listProducts.length.toString()),
                    child: const Icon(
                      Icons.shopping_cart,
                      size: 30,
                    ),
                  ),
                )),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'search'),
                onChanged: (value) {
                  setState(() {
                    filterList = listProducts
                        .where((element) => element.name!
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: searchController.text.isEmpty
                    ? listProducts.length
                    : filterList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                    childAspectRatio: 10 / 14),
                itemBuilder: (context, index) => productCard(
                    pro: searchController.text.isEmpty
                        ? listProducts[index]
                        : filterList[index]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget productCard({required ProductModel pro}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailProductScreen(pro: pro),
            ));
      },
      child: Stack(
        children: [
          Hero(
            tag: pro.id.toString(),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(pro.image.toString()))),
            ),
          ),
          Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    pro.favorite = !pro.favorite!;
                  });
                },
                child: Icon(
                  Icons.favorite,
                  size: 30,
                  color: pro.favorite! ? Colors.red : Colors.white,
                ),
              )),
          Positioned(
              bottom: 0,
              height: 50,
              width: MediaQuery.of(context).size.width / 2 - 14,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          pro.name.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '\$ ${pro.price}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_up/model/product_model.dart';
import 'package:shop_up/view/home_screen.dart';

class ListCartScreen extends StatefulWidget {
  const ListCartScreen({super.key});

  @override
  State<ListCartScreen> createState() => _ListCartScreenState();
}

class _ListCartScreenState extends State<ListCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: listCart.length,
        itemBuilder: (context, index) =>
            buildCardProduct(pro: listCart[index], index: index),
      ),
    );
  }

  Widget buildCardProduct({required ProductModel pro, required int index}) {
    int qty = pro.qty!;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(pro.image.toString()))),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      pro.name.toString(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$ ${pro.price}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        if ((listCart[index].qty!) > 1) {
                          setState(() {
                            listCart[index].qty! - 1;
                          });
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey),
                        child: const Center(
                          child: Icon(Icons.remove),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey),
                      child: Center(
                        child: Text(
                          qty.toString(),
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          listCart[index].qty! + 1;
                        });
                        log(qty.toString());
                      },
                      child: Container(
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey),
                        child: const Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

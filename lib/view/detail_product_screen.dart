import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_up/model/product_model.dart';
import 'package:shop_up/view/home_screen.dart';

class DetailProductScreen extends StatefulWidget {
  DetailProductScreen({super.key, required this.pro});
  ProductModel? pro; 
  // Data member

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: widget.pro!.id.toString(),
                child: Image(
                    // height: 200,
                    // width: 200,
                    image: NetworkImage(widget.pro!.image.toString())),
              ),
              SafeArea(
                child: Positioned(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios))),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.pro!.name.toString(),
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
          Wrap(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  if (qty > 1) {
                    setState(() {
                      qty--;
                    });
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
                    qty.toString(),
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    qty++;
                  });
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
          )
        ],
      ),
      floatingActionButton: CupertinoButton(
        color: Colors.blue,
        child: const Text('Buy now'),
        onPressed: () {},
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
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
                onTap: () {
                  setState(() {
                    widget.pro!.qty = qty;
                    listCart.add(widget.pro!);
                  });
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
  }
}

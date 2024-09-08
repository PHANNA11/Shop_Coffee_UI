class ProductModel {
  int? id;
  String? name;
  double? price;
  String? desription;
  String? image;
  bool? favorite;
  int? qty;
  List<String>? varraints;
  ProductModel(
      {this.id,
      this.name,
      this.favorite,
      this.desription,
      this.price,
      this.image,
      this.qty,
      this.varraints});

  List<ProductModel> get products => [
        ProductModel(
            id: 1,
            name: 'Ice Late',
            image:
                'https://media.gettyimages.com/id/182717746/photo/espresso-coffee-cup-color-image.jpg?s=612x612&w=0&k=20&c=LGeYlM0h31rbQdFgYdt88386lw71pU-6I8_y5XDNXv4=',
            price: 2,
            desription: 'espresso coffee cup.color image - coffee stock pictures, royalty-free photos & images',
            favorite: false,
            qty: 0,
            varraints: ['Size S', 'Size M', 'Size L']),
        ProductModel(
            id: 2,
            name: 'Hot Late',
            image:
                'https://t3.ftcdn.net/jpg/01/31/05/30/360_F_131053005_61aYiIU3MbSJU2lU5uSBbU6qdX87rXLn.jpg',
            price: 2.5,
            desription: 'coffee latte in coffee shop cafe',
            favorite: true,
            qty: 0,
            varraints: ['Sugar 20%', 'Sugar 50%', 'Sugar 100%']),
        ProductModel(
            id: 3,
            name: 'Hot Espreso',
            image:
                'https://media.istockphoto.com/id/1143290013/photo/coffee-cup-isolated.jpg?s=612x612&w=0&k=20&c=fEsmHH_kDh-vPxukZuaMs54D0kg2BTEDgS8lnWu8bBs=',
            price: 2,
            desription: 'espresso coffee cup.color image - coffee stock pictures, royalty-free photos & images',
            favorite: false,
            qty: 0,
            varraints: ['Sugar 20%', 'Sugar 50%', 'Sugar 100%'])
      ];
  
}

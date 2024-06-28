import 'package:flutter/material.dart';

import '../models/product_model.dart';

class Cart extends ChangeNotifier {
  double price = 0;
  List selectedProduct = [];
  void addProduct(ProductModel product) {
    selectedProduct.add(product);
    price += product.price;
    notifyListeners();
  }
  void removeProduct(ProductModel product) {
    selectedProduct.remove(product);
    price -= product.price;
    notifyListeners();
  }
}

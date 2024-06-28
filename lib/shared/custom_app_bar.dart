import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storely/constant.dart';
import 'package:storely/provider/cart.dart';
import 'package:storely/screens/check_out.dart';


class ItemAndPrice extends StatelessWidget {
  const ItemAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cartProvider, child) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              IconButton(
                  onPressed: () => Navigator.pushNamed(context, CheckOut.id),
                  style: IconButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  icon: const Icon(
                    Icons.add_shopping_cart,
                    size: 25.0,
                    color: kPrimaryColor,
                  )),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(211, 164, 255, 193),
                    shape: BoxShape.circle),
                child: Text(
                  '${cartProvider.selectedProduct.length}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14.0),
                ),
              ),
            ],
          ),
          Text(
            '\$${cartProvider.price.ceil()}',
            style: const TextStyle(fontSize: 18.0, color: kPrimaryColor),
          ),
          const SizedBox(
            width: 20.0,
          )
        ],
      ),
    );
  }
}

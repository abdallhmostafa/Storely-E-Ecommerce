import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storely/components/custom_text.dart';

import '../components/custom_buttom.dart';
import '../constant.dart';
import '../provider/cart.dart';
import '../shared/custom_app_bar.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});
  static const String id = 'checkout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Check Out ',
          style: TextStyle(fontSize: 22.0, color: kPrimaryColor),
        ),
        iconTheme: const IconThemeData(color: kPrimaryColor),
        backgroundColor: kAppBarColor,
        actions: const [ItemAndPrice()],
      ),
      body: Consumer<Cart>(
        builder: (context, cartProvider, child) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: cartProvider.selectedProduct.length,
                  addRepaintBoundaries: true,
                  addAutomaticKeepAlives: true,
                  addSemanticIndexes: true,
                  itemBuilder: (context, index) {
                    var provider = cartProvider.selectedProduct[index];
                    return Card(
                      borderOnForeground: true,
                      surfaceTintColor: Colors.cyan,
                      child: ListTile(
                        subtitle: Text(
                          "\$ ${provider.price.ceil()}  -  Laptops  ",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                        // onTap: () => cartProvider.removeProduct(provider),
                        trailing: IconButton(
                            onPressed: () =>
                                cartProvider.removeProduct(provider),
                            icon: const Icon(
                              Icons.remove,
                              size: 30.0,
                              color: Colors.black,
                            )),
                        enableFeedback: true,
                        dense: true,
                        // contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        title: Text(
                          provider.title,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14.0),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            provider.path,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Column(
              children: [
                CustomButtom(
                    widget:
                        CustomText(text: 'Pay \$${cartProvider.price.ceil()}'),
                    backgroundColor: kSecondBtColor,
                    onpressed: () {}),
                const SizedBox(
                  height: 15.0,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

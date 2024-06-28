import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/product_model.dart';
import '../shared/custom_app_bar.dart';


class  Details extends StatefulWidget {
 const Details({this.productData, super.key});
  static const id = 'details';
 final ProductModel? productData;
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Details ',
          style: TextStyle(fontSize: 22.0, color: kPrimaryColor),
        ),
        iconTheme: const IconThemeData(color: kPrimaryColor),
        backgroundColor: kAppBarColor,
        actions: const [
           ItemAndPrice()
        ],
      ),
   
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              widget.productData!.path,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Divider(
                  endIndent: 20.0,
                  indent: 20.0,
                  color: Colors.grey.shade300,
                  height: 2.0,
                  thickness: 1.2,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  "\$${widget.productData!.price.ceil()}",
                  style: const TextStyle(
                      fontSize: 22.0,
                      color: kPrimaryBtColor,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 129, 129),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: const Text("New",
                              style: TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 25.0,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 25.0,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 25.0,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 25.0,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 25.0,
                        ),
                      ],
                    ),
                    const Row(
                      children: <Widget>[
                        Icon(
                          Icons.edit_location,
                          color: kAppBarColor,
                          size: 25.0,
                        ),
                        Text(
                          'Laptops',
                          style: TextStyle(),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productData!.title,
                        style: const TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.productData!.details,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        maxLines: showMore ? null : 3,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                showMore = !showMore;
                              });
                            },
                            child: Text(
                              showMore ? "Show Less" : "Show More",
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blueAccent,
                                  letterSpacing: 4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

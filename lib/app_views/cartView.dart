import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sovtech_ecommerce/app_models/products_model.dart';
import 'package:sovtech_ecommerce/app_providers/cart_provider.dart';
import 'package:collection/collection.dart';
import 'package:sovtech_ecommerce/app_widgets/customWidgets.dart.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: ((context) => CartProvider()),
        builder: (context, child) {
          return cartVieww();
        },
      ),
    );
  }

  cartVieww() {
    SnackBar snackBar = const SnackBar(
      content: Text('Order Succesfully placed'),
    );

    return Consumer<CartProvider>(
      builder: (context, value, child) {
        if (value.items.isEmpty) {
          value.getData();
        }
        getTotalPrice() {
          int sum = 0;
          if (value.items.isNotEmpty) {
            for (var i = 0; i < value.items.length; i++) {
              var ele = value.items[i].price;
              sum = sum + ele!;
            }
            log(sum.toString());
            return sum;
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('AppBar'),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.blue,
                  height: 100,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Total Amount is :",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              value.items.isEmpty
                                  ? "0 Rupees"
                                  : "${getTotalPrice()} Rupees",
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red)),
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  
                                },
                                child: Text("Place Order"))),
                      ],
                    ),
                  ),
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 100,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListTile(
                      title: Text(value.items[index].title.toString()),
                      subtitle: Text(value.items[index].description.toString()),
                      trailing: IconButton(
                          onPressed: () {
                            value.removeItem(value.items[index],
                                value.items[index].docid.toString());
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    );
                  },
                  childCount: value.items.length,
                ),
              ),
            ],
          ),
        );

        // return SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Column(
        //           children: [
        //             const SizedBox(
        //               height: 20,
        //             ),
        //             Container(
        //               height: 50,
        //               color: Colors.green,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   Text("Dishes"),
        //                   const SizedBox(
        //                     width: 10,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 Flexible(
        //                   child: ListView.builder(
        //                     itemCount: value.items.length,
        //                     shrinkWrap: true,
        //                     itemBuilder: (context, index) {
        //                       return Card(
        //                         child: Padding(
        //                           padding: const EdgeInsets.all(10),
        //                           child: Column(
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.start,
        //                             children: [
        //                               Row(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.spaceBetween,
        //                                 children: [
        //                                   Text(
        //                                     value.items[index].title.toString(),
        //                                     style: const TextStyle(
        //                                         fontSize: 15,
        //                                         fontWeight: FontWeight.w500),
        //                                   ),
        //                                   Text("${value.items[index].price}"
        //                                       " INR"),
        //                                   Text(
        //                                       "${value.items[index].discountPercentage}"
        //                                       "Discount")
        //                                 ],
        //                               ),
        //                               const SizedBox(
        //                                 height: 20,
        //                               ),
        //                               Text(
        //                                 value.items[index].description
        //                                     .toString(),
        //                                 style: const TextStyle(
        //                                     fontSize: 15,
        //                                     fontWeight: FontWeight.w500),
        //                               ),
        //                               const SizedBox(
        //                                 height: 10,
        //                               ),
        //                               IconButton(
        //                                   onPressed: () {
        //                                     value
        //                                         .removeItem(value.items[index]);
        //                                   },
        //                                   icon: Icon(Icons.delete))
        //                             ],
        //                           ),
        //                         ),
        //                       );
        //                     },
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(10),
        //               child: Column(
        //                 children: [
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                     children: [
        //                       const Text(
        //                         "Total Amount",
        //                         style: TextStyle(fontSize: 17),
        //                       ),
        //                       Text(
        //                         "${getTotalPrice()}  INR",
        //                         style: const TextStyle(fontSize: 17),
        //                       )
        //                     ],
        //                   )
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //             getTotalPrice();
        //           },
        //           child: SizedBox(
        //             height: 50.0,
        //             child: Material(
        //               borderRadius: BorderRadius.circular(20),
        //               shadowColor: Colors.green,
        //               color: Colors.green,
        //               elevation: 0,
        //               child: Center(
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: const [
        //                     Text(
        //                       'Place Order',
        //                       style: TextStyle(
        //                         fontSize: 14.0,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
      },
    );
  }
}

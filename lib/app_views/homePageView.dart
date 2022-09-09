import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sovtech_ecommerce/app_providers/cart_provider.dart';
import 'package:sovtech_ecommerce/app_views/cartView.dart';
import 'package:sovtech_ecommerce/app_widgets/customWidgets.dart.dart';

import '../app_providers/product_provider.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    final productmodel = Provider.of<productProvider>(context, listen: false);
    productmodel.getPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productmodel = Provider.of<productProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartView()));
                  },
                  icon: const Icon(Icons.shopping_cart))
            ],
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            title: const Text(
              "E-Commerce",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19),
            )),
        body: homePageBody());
  }

  homePageBody() {
    final productmodel = Provider.of<productProvider>(context);

    return Consumer<CartProvider>(builder: (context, value, child) {
      return ListView.builder(
        itemCount: productmodel.products?.products?.length,
        itemBuilder: (context, int index) {
          bool hasData = false;

          if (productmodel.products != null) {
            hasData = true;
          }
          String? price =
              productmodel.products?.products![index].price.toString();

          return Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productmodel.products?.products![index].title ?? "",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("$price" " Rupees"),
                      hasData
                          ? Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                  imageUrl: productmodel
                                      .products!.products![index].thumbnail
                                      .toString()),
                            )
                          : CircularProgressIndicator()
                    ],
                  ),
                  Text(productmodel.products?.products![index].description
                          .toString() ??
                      ""),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        log("added");
                        value.addNewTask(
                            productmodel.products!.products![index]);
                      },
                      child: custom_Buttom("Add To Cart", Colors.blue, 1.0))
                ],
              )),
            ),
          );
        },
      );
    });
  }
}

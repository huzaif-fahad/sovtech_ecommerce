import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sovtech_ecommerce/app_models/products_model.dart';
import 'package:collection/collection.dart';

class CartProvider with ChangeNotifier {


  List<Product> items = List<Product>.empty(growable: true);


  final collection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('cart');

  getData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('cart')
        .get();
    for (var i = 0; i < snapshot.docs.length; i++) {
      items = snapshot.docs
          .map((d) => Product.fromJson(d.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }



  void removeItem(Product item, String? id) async {
    await collection.doc(id).delete();
    items.remove(item);
    notifyListeners();
  }



  void addNewTask(Product item) async {
    if (item != '') {
      await collection.add({
        'title': item.title,
        'description': item.description,
        'image': item.thumbnail,
        'price': item.price,
        'discountPercentage': item.discountPercentage,
        'docid': item.docid
      }).then((value) async {
        updateId(value.id);
        items.add(item);
      });
      notifyListeners();
    }
  }

  void updateId(id) async {
    await collection.doc(id).update({"docid": id});
  }
}

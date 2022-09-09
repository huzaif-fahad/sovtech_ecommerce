import 'package:flutter/material.dart';

import '../app_models/products_model.dart';
import '../app_services/remote_service.dart';

class productProvider with ChangeNotifier {
  Products? products;
  Future getPostData() async {
    products = (await getData());
    notifyListeners();
  }
}

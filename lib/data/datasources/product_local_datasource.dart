import 'package:hive/hive.dart';
import '../../../core/utils/constants.dart';
import '../models/product_model.dart';

class ProductLocalDataSource {
  final Box box = Hive.box(AppConstants.productBox);

  void cacheProducts(List<ProductModel> products) {
    box.put('products', products.map((e) => {
      'id': e.id,
      'title': e.title,
      'price': e.price,
      'image': e.image,
    }).toList());
  }

  List<ProductModel> getCachedProducts() {
    final data = box.get('products', defaultValue: []);

    return (data as List)
        .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
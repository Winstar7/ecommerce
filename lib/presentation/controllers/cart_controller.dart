import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../data/models/product_model.dart';
import '../../core/utils/constants.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel, int>{}.obs;

  final box = Hive.box(AppConstants.cartBox);

  @override
  void onInit() {
    loadCart();
    super.onInit();
  }


  void addToCart(ProductModel product) {
    int currentQty = cartItems[product] ?? 0;


    if (currentQty >= 5) {
      Get.snackbar("Limit Reached", "Max 5 items allowed");
      return;
    }

    cartItems[product] = currentQty + 1;

    saveCart(); // persist
  }


  void removeFromCart(ProductModel product) {
    if (!cartItems.containsKey(product)) return;

    int currentQty = cartItems[product]!;

    if (currentQty <= 1) {
      cartItems.remove(product);
    } else {
      cartItems[product] = currentQty - 1;
    }

    saveCart();
  }


  double get totalPrice {
    return cartItems.entries.fold(
      0,
          (sum, item) => sum + item.key.price * item.value,
    );
  }


  void saveCart() {
    final data = cartItems.map((key, value) => MapEntry(
      key.id.toString(),
      {
        "id": key.id,
        "title": key.title,
        "price": key.price,
        "image": key.image,
        "category": key.category,
        "qty": value,

      },
    ));

    box.put('cart', data);
  }


  void loadCart() {
    final data = box.get('cart', defaultValue: {});

    final Map<ProductModel, int> loaded = {};

    data.forEach((key, value) {
      final product = ProductModel(
        id: value['id'],
        title: value['title'],
        price: value['price'],
        image: value['image'], category: value['category'],
      );

      loaded[product] = value['qty'];
    });

    cartItems.assignAll(loaded);
  }
}
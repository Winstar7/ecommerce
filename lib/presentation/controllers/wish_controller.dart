import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class WishlistController extends GetxController {
  var wishlist = <int>{}.obs;

  void toggleWishlist(int productId) {
    if (wishlist.contains(productId)) {
      wishlist.remove(productId);
    } else {
      wishlist.add(productId);
    }
  }

  bool isWishlisted(int id) => wishlist.contains(id);
}
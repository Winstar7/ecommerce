import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../data/datasources/product_local_datasource.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/respositories/product_repository.dart';
import '../../domain/usecases/get_products.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/wish_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiClient());

    Get.lazyPut(() => ProductRemoteDataSource(Get.find()));
    Get.lazyPut(() => ProductLocalDataSource());

    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl(
      Get.find(),
      Get.find(),
    ));

    Get.lazyPut(() => GetProducts(Get.find()));

    Get.lazyPut(() => ProductController(Get.find()));
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => WishlistController());
  }
}
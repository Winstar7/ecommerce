import 'package:get/get.dart';
import '../../domain/usecases/get_products.dart';
import '../../data/models/product_model.dart';

class ProductController extends GetxController {
  final GetProducts getProducts;

  ProductController(this.getProducts);

  var products = <ProductModel>[].obs;          // original
  var filteredProducts = <ProductModel>[].obs;  // filtered list

  var isLoading = false.obs;


  var selectedCategory = ''.obs;
  var minPrice = 0.0.obs;
  var maxPrice = 1000.0.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }


  void fetchProducts() async {
    isLoading.value = true;

    final result = await getProducts();

    products.assignAll(result);
    filteredProducts.assignAll(result);

    isLoading.value = false;
  }


  void applyFilters() {
    print("Min: ${minPrice.value}, Max: ${maxPrice.value}");

    final filtered = products.where((product) {
      return product.price >= minPrice.value &&
          product.price <= maxPrice.value;
    }).toList();

    print("Filtered count: ${filtered.length}");

    filteredProducts.assignAll(filtered);
  }


  void resetFilters() {
    selectedCategory.value = '';
    minPrice.value = 0;
    maxPrice.value = 1000;

    filteredProducts.assignAll(products);
  }


  List<String> get categories {
    return products.map((e) => e.category).toSet().toList();
  }
}
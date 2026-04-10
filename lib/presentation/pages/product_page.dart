import 'package:ecommerce/presentation/pages/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/wish_controller.dart';
import 'cart_screen.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final wishlistController = Get.find<WishlistController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text(
          "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Obx(() {
            final count = cartController.cartItems.length;

            return Row(
              children: [
            IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
            showPriceFilter(context);
            },),
                IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    Get.to(() => const WishlistPage());
                  },
                ),


                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {
                          Get.to(() => const CartPage());
                        },
                      ),

                      if (count > 0)
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              count.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.black,));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.68,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (_, index) {
            //final product = controller.products[index];
            final product = controller.filteredProducts[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black12,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🖼 IMAGE + BADGES
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                          child: Image.network(
                            product.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // ❤️ Wishlist
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Obx(() => GestureDetector(
                            onTap: () {
                              wishlistController
                                  .toggleWishlist(product.id);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4)
                                ],
                              ),
                              child: Icon(
                                wishlistController
                                    .isWishlisted(product.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                            ),
                          )),
                        ),


                        Positioned(
                          left: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              "SALE",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(height: 5),

                        Row(
                          children: const [
                            Icon(Icons.star,
                                size: 14, color: Colors.orange),
                            SizedBox(width: 4),
                            Text("4.5",
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "₹ ${product.price}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // 🛒 BUTTON
                        GestureDetector(
                          onTap: () {
                            cartController.addToCart(product);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.black, Colors.grey],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      }),
    );


  }

  void showPriceFilter(BuildContext context) {
    final controller = Get.find<ProductController>();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Filter by Price",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            RangeSlider(
              values: RangeValues(
                controller.minPrice.value,
                controller.maxPrice.value,
              ),
              min: 0,
              max: 1000,
              divisions: 20,
              labels: RangeLabels(
                "₹${controller.minPrice.value.toStringAsFixed(0)}",
                "₹${controller.maxPrice.value.toStringAsFixed(0)}",
              ),
              onChanged: (values) {
                controller.minPrice.value = values.start;
                controller.maxPrice.value = values.end;
              },
            ),

            const SizedBox(height: 10),


            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      controller.resetFilters();
                      Get.back();
                    },
                    child: const Text("Reset",style: TextStyle(color: Colors.black),),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      controller.applyFilters();
                      Get.back();
                    },
                    child: const Text("Apply"),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
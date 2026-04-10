import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../../data/models/product_model.dart';
import '../controllers/product_controller.dart';
import '../controllers/wish_controller.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();
    final productController = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title:  const Text("Wishlist ️",style:TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold,) ),
        centerTitle: true,
      ),

      body: Obx(() {
        final wishlistIds = wishlistController.wishlist;

        if (wishlistIds.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border,
                    size: 80, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  "Your wishlist is empty",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }


        final List<ProductModel> products = productController.products
            .where((p) => wishlistIds.contains(p.id))
            .toList();

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          itemBuilder: (_, index) {
            final product = products[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6)
                ],
              ),
              child: Row(
                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.image,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image),
                    ),
                  ),

                  const SizedBox(width: 10),


                  Expanded(
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

                        Text(
                          "₹ ${product.price}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),


                  Column(
                    children: [

                      IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.red),
                        onPressed: () {
                          wishlistController
                              .toggleWishlist(product.id);
                        },
                      ),

                    ],
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/product_model.dart';

class ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSource(this.apiClient);

  Future<List<ProductModel>> getProducts() async {
    final response = await apiClient.dio.get('/products');


    final List list = response.data['products'];

    return list.map((e) => ProductModel.fromJson(e)).toList();
  }
}
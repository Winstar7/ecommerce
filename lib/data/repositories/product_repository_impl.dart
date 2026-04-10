import '../../domain/respositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  final ProductLocalDataSource local;

  ProductRepositoryImpl(this.remote, this.local);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final products = await remote.getProducts();
      local.cacheProducts(products);
      return products;
    } catch (e) {
      return local.getCachedProducts();
    }
  }
}
import '../../data/models/product_model.dart';
import '../respositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<ProductModel>> call() {
    return repository.getProducts();
  }
}
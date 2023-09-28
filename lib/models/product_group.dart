import 'package:sqlite_order_app/models/product.dart';

class ProductGroup {
  final String name;
  final List<Product> products;

  ProductGroup({
    required this.name,
    required this.products,
  });
}
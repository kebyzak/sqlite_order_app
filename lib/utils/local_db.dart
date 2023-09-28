import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/order.dart';

Database? _db;
List<Map<String, dynamic>> dataList = [];

class LocalDatabase {
  Future get db async {
    if (_db != null) return _db;
    _db = await _initDB('localthree.db');
    return _db;
  }

  Future _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ProductGroups (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE Products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      groupId INTEGER,
      name TEXT,
      stockAmount INTEGER,
      price REAL,
      FOREIGN KEY (groupId) REFERENCES ProductGroups (id)
    )
  ''');

    await db.execute('''
    CREATE TABLE Orders (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      room TEXT,
      cost INTEGER
    )
  ''');

    await db.execute('''
    CREATE TABLE OrderItems (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      orderId INTEGER,
      productName TEXT,
      productPrice REAL,
      productQuantity INTEGER,
      FOREIGN KEY (orderId) REFERENCES Orders (id)
    )
  ''');
  }

  Future addData({groupId, name, stockAmount, price}) async {
    final database = await db;
    await database.insert(
      "Products",
      {
        "groupId": groupId,
        "name": name,
        "stockAmount": stockAmount,
        "price": price
      },
    );
    return 'added';
  }

  Future readProducts() async {
    final database = await db;
    final data = await database!.query("Products");
    dataList = data;
    return 'read';
  }

  Future<int> updateData({
    required int id,
    required String name,
    required int stockAmount,
    required double price,
  }) async {
    final database = await db;
    final args = [name, stockAmount, price, id];

    final updateFields = [
      if (name.isNotEmpty) 'name = ?',
      'stockAmount = ?',
      'price = ?',
    ];

    final updateId = await database.rawUpdate(
      'UPDATE Products SET ${updateFields.join(', ')} WHERE id = ?',
      args,
    );

    return updateId;
  }

  Future deleteData({id}) async {
    final database = await db;
    await database!.delete("Products", where: 'id=?', whereArgs: [id]);
    return "deleted";
  }

  Future<void> addOrder(Order order) async {
    final database = await db;
    final orderId = await database.insert(
      "Orders",
      {"room": order.room, "cost": order.cost},
    );

    for (final orderItem in order.orderItems) {
      orderItem["orderId"] = orderId; // Add orderId to each order item
      await database.insert(
        "OrderItems",
        orderItem, // Insert the order item as a Map
      );
    }
  }

  Future<void> addOrderItem({
    required int orderId,
    required String productName,
    required double productPrice,
    required int productQuantity,
  }) async {
    final database = await db;
    await database.insert(
      "OrderItems",
      {
        "orderId": orderId,
        "productName": productName,
        "productPrice": productPrice,
        "productQuantity": productQuantity,
      },
    );
  }

  Future<void> updateStockAmount(String productName, int quantity) async {
    final database = await db;
    await database.rawUpdate('''
    UPDATE Products
    SET stockAmount = stockAmount - ?
    WHERE name = ?
  ''', [quantity, productName]);
  }


  Future<List<Map<String, dynamic>>> readOrders() async {
    final database = await db;
    final results = await database.rawQuery('''
    SELECT Orders.room, Orders.cost, 
           GROUP_CONCAT(OrderItems.productName, ', ') as productName,
           GROUP_CONCAT(OrderItems.productQuantity, ', ') as productQuantity
    FROM Orders
    JOIN OrderItems ON Orders.id = OrderItems.orderId
    GROUP BY Orders.id, Orders.room, Orders.cost
  ''');

    final List<Map<String, dynamic>> processedResults = [];
    for (final result in results) {
      final productName = (result['productName'] as String).split(', ');
      final productQuantity = (result['productQuantity'] as String)
          .split(', ')
          .map((quantity) => int.tryParse(quantity) ?? 0)
          .toList();

      final parsedResult = {
        'room': result['room'],
        'cost': result['cost'],
        'productName': productName,
        'productQuantity': productQuantity,
      };

      processedResults.add(parsedResult);
    }

    return processedResults;
  }
}

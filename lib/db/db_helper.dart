import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin/models/category_model.dart';
import 'package:ecom_admin/models/product_model.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionAdmin = 'Admins';
  static const String collectionCategory = 'Categories';
  static const String collectionProduct = 'Products';

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addCategory(CategoryModel category) {
    final doc = _db.collection(collectionCategory).doc();
    category.id = doc.id;
    return doc.set(category.toJson());
  }

  static Future<void> addProduct(ProductModel product) {
    final doc = _db.collection(collectionProduct).doc();
    product.id = doc.id;
    return doc.set(product.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(collectionCategory)
          .orderBy('name',)
          .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(collectionProduct).snapshots();

  static Future<void> updateProductField(String id, Map<String, dynamic> map) {
     return _db.collection(collectionProduct)
         .doc(id)
         .update(map);
   }
}
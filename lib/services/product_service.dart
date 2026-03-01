import 'package:kharid_le/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch all products (Buyer Mode)
  Future<List<ProductModel>> fetchAllProducts() async {
    final snapshot = await _firestore
        .collection('products')
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  /// Fetch products by category (Seller Mode)
  Future<List<ProductModel>> fetchCategoryProducts(String category) async {
    final snapshot = await _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  /// Fetch seller's own inventory
  Future<List<ProductModel>> fetchSellerProducts(String sellerId) async {
    final snapshot = await _firestore
        .collection('products')
        .where('sellerId', isEqualTo: sellerId)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  /// Watch seller's own inventory (Real-time)
  Stream<List<ProductModel>> watchSellerProducts(String sellerId) {
    return _firestore
        .collection('products')
        .where('sellerId', isEqualTo: sellerId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  /// Add a new product
  Future<void> addProduct(ProductModel product) async {
    await _firestore.collection('products').add(product.toMap());
  }

  /// Delete a product
  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  /// Update a product
  Future<void> updateProduct(ProductModel product) async {
    await _firestore.collection('products').doc(product.id).update(product.toMap());
  }

  /// Fetch seller statistics (Seller Dashboard)
  Stream<Map<String, dynamic>> watchSellerStats(String sellerId) {
    return _firestore
        .collection('products')
        .where('sellerId', isEqualTo: sellerId)
        .snapshots()
        .map((snapshot) {
      double totalStuckValue = 0;
      int slowCount = 0;
      int criticalCount = 0;
      int activeDeals = 0;
      List<ProductModel> priorityProducts = [];

      final now = DateTime.now();

      for (var doc in snapshot.docs) {
        final product = ProductModel.fromMap(doc.id, doc.data());
        
        // Active deals
        if (product.discountedPrice != null) {
          activeDeals++;
        }

        // Stock health and stuck value
        if (product.purchaseDate != null) {
          final daysDiff = now.difference(product.purchaseDate!).inDays;
          
          if (daysDiff > 45) {
            criticalCount++;
            totalStuckValue += (product.costPrice ?? 0) * product.quantity;
            priorityProducts.add(product);
          } else if (daysDiff > 30) {
            slowCount++;
            totalStuckValue += (product.costPrice ?? 0) * product.quantity;
            priorityProducts.add(product);
          }
        }
      }

      // Sort priority products by oldest purchase date first
      priorityProducts.sort((a, b) => (a.purchaseDate ?? now).compareTo(b.purchaseDate ?? now));

      return {
        'totalStuckValue': totalStuckValue,
        'slowMovingCount': slowCount,
        'criticalStockCount': criticalCount,
        'activeDealsCount': activeDeals,
        'needsAttentionCount': slowCount + criticalCount,
        'priorityProducts': priorityProducts,
        'inventoryHealth': (snapshot.docs.isEmpty) ? 100 : ((snapshot.docs.length - criticalCount - slowCount) / snapshot.docs.length * 100).round(),
      };
    });
  }

  /// Toggle save status of a product (Buyer Mode)
  Future<void> toggleSaveProduct(String userId, ProductModel product) async {
    final savedRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('saved_deals')
        .doc(product.id);

    final doc = await savedRef.get();
    if (doc.exists) {
      await savedRef.delete();
    } else {
      await savedRef.set({
        ...product.toMap(),
        'savedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Fetch saved products (Buyer Mode)
  Stream<List<ProductModel>> watchSavedProducts(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('saved_deals')
        .orderBy('savedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  /// Check if product is saved
  Stream<bool> isProductSaved(String userId, String productId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('saved_deals')
        .doc(productId)
        .snapshots()
        .map((snapshot) => snapshot.exists);
  }

  /// Fetch buyer statistics (Buyer Mode)
  Stream<Map<String, dynamic>> watchUserStats(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('saved_deals')
        .snapshots()
        .map((snapshot) {
      double totalSavings = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final price = (data['price'] as num?)?.toDouble() ?? 0;
        final discountedPrice = (data['discountedPrice'] as num?)?.toDouble() ?? price;
        totalSavings += (price - discountedPrice);
      }
      
      return {
        'dealsSaved': snapshot.docs.length,
        'totalSavings': totalSavings,
        'redeemed': 0, // Placeholder as redemption logic isn't implemented yet
      };
    });
  }
}
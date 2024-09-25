import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In-App Subscription',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SubscriptionPage(),
    );
  }
}

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    purchaseUpdated.listen((purchases) {
      _listenToPurchaseUpdated(purchases);
    });
    _initializeStore();
    super.initState();
  }

  Future<void> _initializeStore() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      setState(() {
        _isAvailable = false;
        _products = [];
        _loading = false;
      });
      return;
    }

    const Set<String> _kIds = {'my_coach_100_month'};
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_kIds);
    if (response.error != null) {
      setState(() {
        _isAvailable = false;
        _products = [];
        _loading = false;
      });
      return;
    }

    setState(() {
      _isAvailable = true;
      _products = response.productDetails;
      _loading = false;
    });
  }

  void _buyProduct(ProductDetails productDetails) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchases) {
    setState(() {
      _purchases.addAll(purchases);
    });
    for (var purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased) {
        // Handle successful purchase here
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text('Subscription')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Subscription')),
      body: _isAvailable
          ? ListView(
        children: _products.map((product) {
          return ListTile(
            title: Text(product.title),
            subtitle: Text(product.price),
            trailing: ElevatedButton(
              child: Text('Buy'),
              onPressed: () => _buyProduct(product),
            ),
          );
        }).toList(),
      )
          : Center(child: Text('Store not available')),
    );
  }
}

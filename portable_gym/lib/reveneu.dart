import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RevenueCat Subscription Example',
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
  List<Package> availablePackages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initRevenueCat();
  }


  Future<void> initRevenueCat() async {
    // Initialize RevenueCat with the API key
    await Purchases.configure(PurchasesConfiguration("goog_clchvQMblHCiNCFMRioHcptUNRP"));

    try {
      // Fetch available offerings (subscription options)

      // Fetch offerings
      Offerings offerings = await Purchases.getOfferings();
      // print(offerings.all.toString());
      if (offerings.current != null && offerings.current!.availablePackages.isNotEmpty) {
        setState(() {
          availablePackages = offerings.current!.availablePackages;
          isLoading = false;
        });
      } else {
        print('No offerings available.');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching products or offerings: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> purchasePackage(Package package) async {
  //   try {
  //     // Make a purchase
  //     CustomerInfo customerInfo = await Purchases.purchasePackage(package);
  //     bool isProUser = customerInfo.entitlements.all["premium_access"]?.isActive ?? false;
  //
  //     if (isProUser) {
  //       // User has successfully subscribed
  //       print("Subscription successful!");
  //     } else {
  //       // Handle subscription failure
  //       print("Subscription not active.");
  //     }
  //   } catch (e) {
  //     print("Error making purchase: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscriptions'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: availablePackages.length,
        itemBuilder: (context, index) {
          Package package = availablePackages[index];
          // Use storeProduct for the product title and price
          return ListTile(
            title: Text(package.storeProduct.title), // Get the product title
            subtitle: Text(package.storeProduct.priceString), // Get the price
            trailing: ElevatedButton(
              onPressed: () {
                // purchasePackage(package);
              },
              child: Text('Buy'),
            ),
          );
        },
      ),
    );
  }
}

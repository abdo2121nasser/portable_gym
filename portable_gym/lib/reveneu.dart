// import 'package:amazon_iap/amazon_iap.dart';
// import 'package:amazon_iap/generated/pigeon.dart';
// import 'package:flutter/material.dart';
// // import 'package:my_coach/resourses/managers_files/secret_api_key_manager.dart';
// // import 'package:purchases_flutter/purchases_flutter.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'RevenueCat Subscription Example',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: SubscriptionPage(),
// //     );
// //   }
// // }
//
// // class SubscriptionPage extends StatefulWidget {
// //   @override
// //   _SubscriptionPageState createState() => _SubscriptionPageState();
// // }
// //
// // class _SubscriptionPageState extends State<SubscriptionPage> {
// //   List<Package> availablePackages = [];
// //   bool isLoading = true;
// //   @override
// //   void initState() {
// //     super.initState();
// //    // initRevenueCat();
// //   }
// //
// //   // Future<void> initRevenueCat() async {
// //   //   // Initialize RevenueCat with the API key
// //   //   // await Purchases.setProxyURL("https://api.rc-backup.com/");
// //   //   try{
// //   //     await Purchases.configure(AmazonConfiguration(SecretApiKeyManager.reveneuCatPublicKey));
// //   //
// //   //   }catch(e)
// //   //   {
// //   //     print(e);
// //   //     print('--------------------------------------------------------------------');
// //   //   }
// //   //   return;
// //   //   try {
// //   //     // Fetch offerings
// //   //     Offerings offerings = await Purchases.getOfferings();
// //   //     if (offerings.current != null && offerings.current!.availablePackages.isNotEmpty) {
// //   //       setState(() {
// //   //         availablePackages = offerings.current!.availablePackages;
// //   //         isLoading = false;
// //   //       });
// //   //     } else {
// //   //       print('No offerings available.');
// //   //       setState(() {
// //   //         isLoading = false;
// //   //       });
// //   //     }
// //   //   } catch (e) {
// //   //     print("Error fetching products or offerings: $e");
// //   //     setState(() {
// //   //       isLoading = false;
// //   //     });
// //   //   }
// //   // }
// //   //
// //   // Future<void> purchasePackage(Package package) async {
// //   //   try {
// //   //
// //   //     // Make a purchase
// //   //     await Purchases.purchasePackage(package);
// //   //   } catch (e) {
// //   //     print("Error making purchase: $e");
// //   //   }
// //   // }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Subscriptions'),
// //       ),
// //       body: isLoading
// //           ? Center(child: CircularProgressIndicator())
// //           : ListView.builder(
// //         itemCount: availablePackages.length,
// //         itemBuilder: (context, index) {
// //           Package package = availablePackages[index];
// //           // Use storeProduct for the product title and price
// //           return ListTile(
// //             title: Text(package.storeProduct.title), // Get the product title
// //             subtitle: Text(package.storeProduct.priceString), // Get the price
// //             trailing: ElevatedButton(
// //               onPressed: () {
// //                // purchasePackage(package);
// //               },
// //               child: Text('Buy'),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   UserData? userData;
//   InstallDetails? installDetails;
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     await AmazonIAP.instance.setup();
//
//     AmazonIAP.instance.onUserDataResponse.listen((event) {
//       if (event.requestStatus == RequestStatus.successful) {
//         setState(() {
//           userData = event.userData;
//         });
//       }
//     });
//     AmazonIAP.instance.getUserData();
//
//     installDetails = await AmazonIAP.instance.getInstallDetails();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Amazon IAP example'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Amazon appstore installed: ${installDetails?.isAmazonStoreInstalled ?? "pending"}'),
//               Text(
//                 'User id: ${userData?.userId ?? "pending"}',
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Text('Marketplace: ${userData?.marketplace ?? "pending"}'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
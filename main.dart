import 'package:afristore/app/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/product_provider.dart';
import 'providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialize
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDecTnuO05kCmVc5_s5TkR3vTx2EVb_hc4",
        appId: "1:603888248786:web:4b14b4adc6d3fb05094a0b",
        messagingSenderId: "603888248786",
        projectId: "afristore-b815e",
        storageBucket: "afristore-b815e.firebasestorage.app",
        authDomain: "afristore-b815e.firebaseapp.com",
      ),
    );

    print("FIREBASE CONNECTED SUCCESSFULLY");
  }

  runApp(const AfriStoreApp());
}

class AfriStoreApp extends StatelessWidget {
  const AfriStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const App(),
    );
  }
}

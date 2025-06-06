import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/firebase_options.dart';
import 'package:gamraka/screens/ask/cubit/asks_cubit.dart';
import 'package:gamraka/screens/auth/login/cubit/login_cubit.dart';
import 'package:gamraka/screens/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:gamraka/screens/calculator/cubit/order_cubit.dart';
import 'package:gamraka/screens/home/cubit/home_cubit.dart';
import 'package:gamraka/screens/orders/cubit/my_orders_cubit.dart';
import 'package:gamraka/screens/welcome/splash_screen.dart';

import 'core/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => AsksCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => MyOrdersCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

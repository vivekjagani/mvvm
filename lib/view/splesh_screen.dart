import 'package:flutter/material.dart';
import 'package:mvvm/view_model/service/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    SplashService splashService = SplashService();

  @override
  void initState() {
    splashService.checkAuthentication(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Splesh screen")),
    );
  }
}

import 'package:collar/FirstScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCcsldgmmIdZRRbzmRAbzwiiK2qe5yVIp4",
          appId: "1:76532800618:android:1d9b52ea6d5efc5332be13",
          messagingSenderId: "",
          projectId: "collar-ab0d0"));
  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: width,
              height: height,
              color: Colors.redAccent,
              child: Image.asset(
                "images/splashScreen.jpg",
                fit: BoxFit.fill,
              )),
          Positioned(
            top: height * 0.85,
            left: width * 0.27,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FirstScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF64EA26),
                foregroundColor: Colors.white,
                fixedSize: Size(width * 0.5, height * 0.07),
                elevation: width * 0.05,
              ),
              child: Text(
                "Get Started",
                style: TextStyle(fontSize: width * 0.05),
              ),
            ),
          )
        ],
      ),
    );
  }
}

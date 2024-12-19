import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remote_config_example/firebase_options.dart';
import 'package:flutter_remote_config_example/remote_config.dart';
import 'package:simple_snowfall/snows/snowfall_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final remoteConfig =
      RemoteValueService(remoteConfig: FirebaseRemoteConfig.instance);
  await remoteConfig.setConfigurations();
  await remoteConfig.setDefaultsAndFetch();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final remoteConfig =
      RemoteValueService(remoteConfig: FirebaseRemoteConfig.instance);
  late bool isChristmas;
  @override
  void initState() {
    super.initState();
    isChristmas = remoteConfig.christmasModeEnabledKey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: Center(
          child: isChristmas
              ? Stack(
                  children: [
                    const Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Text('Merry Christmas 🎅🎄🎁!!',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SnowfallWidget(
                      gravity: 0.1,
                      windIntensity: 1,
                      size: Size(MediaQuery.sizeOf(context).width,
                          MediaQuery.sizeOf(context).height),
                    ),
                  ],
                )
              : const Text('Hello World!'),
        ));
  }
}

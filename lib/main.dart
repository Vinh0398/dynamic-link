import 'dart:io';

import 'package:dynamic_link/firebase_options.dart';
import 'package:dynamic_link/route/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Check if you received the link via `getInitialLink` first

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final scafoldKey = GlobalKey<ScaffoldMessengerState>();

  // This widget is the root of your application.
  final globalKey = GlobalKey();

  @override
  void initState() {
    _initDynamicLink();
    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) => _onDeeplink(pendingDynamicLinkData.link),
    );
    _getFCMToken();
    _listenFCM();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scafoldKey,
      key: globalKey,
      routerConfig: router,
    );
  }

  void _onDeeplink(Uri deepLink) {
    // Example of using the dynamic link to push the user to a different screen
    //Navigator.pushNamed(context, deepLink.path);
    print("------------------> $deepLink");
    final path = deepLink.toString().replaceAll("https://yoyoko.page.link", "");
    print("------------------> navaigate to $path");
    router.routerDelegate.navigatorKey.currentContext?.go(path);
  }

  Future<void> _initDynamicLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      _onDeeplink(initialLink.link);
    } else {
      print("------------------> initialLink is null");
    }
  }

  Future<void> _getFCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("token fcm: $fcmToken");
  }

  void _listenFCM() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (Platform.isAndroid) {
        final titleNotification = message.notification?.title;
        final bodyNotification = message.notification?.body;
        if (scafoldKey.currentContext == null) return;
        scafoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text("$titleNotification\n$bodyNotification"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}

class HomePage extends StatefulWidget {
  final Widget child;

  const HomePage({super.key, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: _onTapBottomBar,
        currentIndex: _getCurrentIndex(context),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onTapBottomBar(int value) {
    String path = RoutePath.newsPath;
    if (value == 0) {
      path = RoutePath.newsPath;
    }
    if (value == 1) {
      path = RoutePath.notificationsPath;
    }
    if (value == 2) {
      path = RoutePath.accountPath;
    }
    context.go(path);
  }

  int _getCurrentIndex(BuildContext context) {
    final path = GoRouter.of(context).location;
    if (path.startsWith(RoutePath.newsPath)) {
      return 0;
    }
    if (path.startsWith(RoutePath.notificationsPath)) {
      return 1;
    }
    if (path.startsWith(RoutePath.accountPath)) {
      return 2;
    }
    return 0;
  }
}

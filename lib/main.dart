import 'package:assignment/features/auth/provider/authProvider.dart';
import 'package:assignment/features/auth/screen/loginScreen.dart';
import 'package:assignment/features/profile/model/user.dart';
import 'package:assignment/features/profile/provider/profileProvider.dart';
import 'package:assignment/provider/provider/storageProvider.dart';
import 'package:assignment/provider/provider/userProvider.dart';
import 'package:assignment/routes/routing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('userBox');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Userprovider>(create: (_) => Userprovider()),
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ChangeNotifierProvider<Profileprovider>(create: (_) => Profileprovider()),
  ], child: const MyApp()));
}

final navigateKey = GlobalKey<NavigatorState>();


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final base = ThemeData.light().textTheme;
    final colorScheme =
        ColorScheme.fromSeed(seedColor: Color(0xff2C3E50)).copyWith(
      primary: Color(0xff2C3E50),
    );

    final style = base.copyWith(
      headlineLarge: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 30,
      ),
      headlineMedium: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
      ),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.login,
      navigatorKey: navigateKey,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff2C3E50)
        ),
        filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(
          // maximumSize: WidgetStateProperty.all(Size.fromHeight(40)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          padding: WidgetStateProperty.all(const EdgeInsets.all(14)),
        )),
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 225, 229),
        colorScheme: colorScheme,
        textTheme: style,
        useMaterial3: true,
      ),
      // home: Loginscreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

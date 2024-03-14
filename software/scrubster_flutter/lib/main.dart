import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scrubster/app/app.bottomsheets.dart';
import 'package:scrubster/app/app.dialogs.dart';
import 'package:scrubster/app/app.locator.dart';
import 'package:scrubster/app/app.router.dart';
import 'package:scrubster/firebase_options.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.homeView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

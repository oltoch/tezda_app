import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tezda_app/modules/onboarding/views/login_view.dart';
import 'package:tezda_app/modules/product/views/product_list_view.dart';
import 'package:tezda_app/routes/routes.dart';
import 'package:tezda_app/utils/app_data.dart';
import 'package:tezda_app/utils/dialog_manager.dart';
import 'package:tezda_app/utils/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: 'Tezda App',
        debugShowCheckedModeBanner: false,
        navigatorKey: nav.navigatorKey,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFFAFDFF),
          textTheme: GoogleFonts.soraTextTheme(Theme.of(context).textTheme)
              .apply(fontSizeFactor: 1.sp),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: (context, widget) {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          widget = DialogManager(child: widget!);
          return Navigator(
            onGenerateRoute: (settings) => PageRouteBuilder(
              pageBuilder: (context, animation, anotherAnimation) => widget!,
              transitionsBuilder:
                  (context, animation, anotherAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        onGenerateRoute: onGenerateRoutes,
        initialRoute: AppData().token.isNotEmpty
            ? ProductListView.route
            : LoginView.route,
      ),
    );
  }
}

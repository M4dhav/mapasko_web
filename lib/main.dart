import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mapsko/contact/contact.dart';
import 'package:mapsko/documents/document_page.dart';
import 'package:mapsko/home/home.dart';
import 'package:mapsko/team/team.dart';
import 'package:mapsko/tenders/tender_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return PageTransition(
          child: const HomePage(),
          duration: const Duration(milliseconds: 300),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/team':
        return PageTransition(
          child: const TeamPage(),
          duration: const Duration(milliseconds: 300),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/contact':
        return PageTransition(
          child: const ContactUsPage(),
          duration: const Duration(milliseconds: 300),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/documents':
        return PageTransition(
          child: const DocumentPage(),
          duration: const Duration(milliseconds: 300),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/tenders':
        return PageTransition(
          child: const TenderPage(),
          duration: const Duration(milliseconds: 300),
          type: PageTransitionType.fade,
          settings: settings,
        );
      // case '/Spectrum':
      //   return PageTransition(
      //     child: const SpectrumScreen(),
      //     duration: const Duration(milliseconds: 300),
      //     type: PageTransitionType.fade,
      //     settings: settings,
      //   );

      default:
        throw UnsupportedError('Unknown route: ${settings.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
        onGenerateRoute: onGenerateRoute,
        // routes: {
        //   '/home': (context) => const HomePage(),
        //   '/team': (context) => const TeamPage(),
        //   '/contact': (context) => const ContactUsPage(),
        // },
      );
    });
  }
}

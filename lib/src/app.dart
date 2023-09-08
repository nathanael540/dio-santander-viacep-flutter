import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viacep/src/views/pages/home_page.dart';

class AppCore extends StatelessWidget {
  const AppCore({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'ViaCEP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: const Color(0xff008012),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xff008012),
            onPrimary: Colors.white,
            secondary: Color(0xffFAF920),
            onSecondary: Colors.black,
            background: Colors.white,
            onBackground: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black,
            error: Colors.red,
            onError: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff008012),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
          ),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: Color(0xff008012),
              statusBarColor: Color(0xff008012),
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            centerTitle: true,
            backgroundColor: Color(0xff008012),
            foregroundColor: Colors.white,
            elevation: 7,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 1,
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}

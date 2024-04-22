import 'package:flutter/material.dart';

// Define the theme using ThemeData
final ThemeData myTheme = ThemeData(
  useMaterial3: true,
  // Define text theme
  textTheme: const TextTheme(
    // Define headline6 style
    titleLarge: TextStyle(
      fontSize: 16.0, // --bs-root-font-size
      fontWeight: FontWeight.w500, // --bs-body-font-weight
      color: Colors.white, // --bs-gray-rgb
    ),
    // Define headline5 style
    headlineSmall: TextStyle(
      fontSize: 24.0, // Custom size
      fontWeight: FontWeight.bold, // Custom weight
      color: Colors.white, // --bs-gray-rgb
    ),
    // Define headline4 style
    headlineMedium: TextStyle(
      fontSize: 20.0, // Custom size
      fontWeight: FontWeight.bold, // Custom weight
      color: Colors.white, // --bs-gray-rgb
    ),
    // Define headline3 style
    displaySmall: TextStyle(
      fontSize: 18.0, // Custom size
      fontWeight: FontWeight.bold, // Custom weight
      color: Colors.white, // --bs-gray-rgb
    ),
    // Define headline2 style
    displayMedium: TextStyle(
      fontSize: 32.0, // Custom size
      fontWeight: FontWeight.bold, // Custom weight
      color: Colors.white, // --bs-gray-rgb
    ),
    // Define headline1 style
    displayLarge: TextStyle(
      fontSize: 48.0, // Custom size
      fontWeight: FontWeight.bold, // Custom weight
      color: Colors.white, // --bs-gray-rgb
    ),
    // Define bodyText1 style
    bodyLarge: TextStyle(
      fontSize: 16.0, // Custom size
      color: Colors.white, // --bs-body-color-rgb
    ),
    // Define bodyText2 style
    bodyMedium: TextStyle(
      fontSize: 14.0, // Custom size
      color: Colors.white, // --bs-body-color-rgb
    ),
  ),

  // Define divider color
  dividerColor: const Color(0xFFE7E7E8), // --bs-border-color

  // Define scaffold background color
  scaffoldBackgroundColor: const Color(0xFFf4f5fa), // --bs-body-bg

  // Define card color
  cardColor: const Color(0xFFF4F5FA),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF7332DF),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFEADDFF),
    onPrimaryContainer: Color(0xFF25005A),
    secondary: Color(0xFF0062A0),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD0E4FF),
    onSecondaryContainer: Color(0xFF001D35),
    tertiary: Color(0xFF006493),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFCAE6FF),
    onTertiaryContainer: Color(0xFF001E30),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFDFBFF),
    onBackground: Color(0xFF001B3D),
    surface: Color(0xFFFDFBFF),
    onSurface: Color(0xFF001B3D),
    surfaceVariant: Color(0xFFE7E0EB),
    onSurfaceVariant: Color(0xFF49454E),
    outline: Color(0xFF7A757F),
    onInverseSurface: Color(0xFFECF0FF),
    inverseSurface: Color(0xFF003062),
    inversePrimary: Color(0xFFD3BBFF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF7332DF),
    outlineVariant: Color(0xFFCBC4CF),
    scrim: Color(0xFF000000),
  ), // --bs-body-bg

  // button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF9055FD),
      disabledForegroundColor: const Color(0xffC2CFFB),
      disabledBackgroundColor: const Color(0xffEFF3FF),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    ),
  ),
);

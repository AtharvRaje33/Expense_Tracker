import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var kDarkColorScheme = ColorScheme.fromSeed(brightness: Brightness.dark,seedColor: const Color.fromARGB(255, 5, 99, 125));
// brightness.dark tells flutter that the theme is for dark brightness/mode

void main() {
  runApp(
     MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,

        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal:16,vertical: 8), 
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.onPrimaryContainer
        )),
      ),

      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal:16,vertical: 8), 
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
        )),
        textTheme: ThemeData().textTheme.copyWith(         // ensures that we are writing texttheme concerned with our themedata object
            titleLarge: TextStyle(fontWeight: FontWeight.bold, color: kColorScheme.secondaryContainer,fontSize: 17),
        )
      ),
      themeMode: ThemeMode.system,         // uses default theme of the system
      home: const Expenses()
    ),
  );
}


// TODO:
// 1) Styling of expense items, textsize,etc..
// 2) Add more detalied categories
// 3) change theme of date picker - https://stackoverflow.com/questions/50321182/how-to-customize-a-date-picker
// 4) Display monthwise expense(seperate modal similar to new expense) and reset every month 
// 5)


// theming is done to change styles of a particular widget in the entire app
// themedata is better for styling as changes have to be made only at one place and they will be applied everywhere else
// it is a practice to name global variables with a starting character k

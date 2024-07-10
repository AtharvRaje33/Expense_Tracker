//import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();               // unique identifier

final formatter = DateFormat.yMd();   // creates a formatter object

enum Category{                      // values are not strings 
  food,
  travel,
  leisure,
  work,
}

const categoryIcons = {
  Category.food : Icons.lunch_dining_outlined,
  Category.travel: Icons.flight_takeoff,
  Category.leisure : Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense({
    required this.title, 
    required this.amount,
     required this.date,
     required this.category,
     }) : id=uuid.v4();

  final String id; // every expense has an unique id
  final String title; // expense title
  final double amount; // expense amount
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }

}


class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses
  });

  ExpenseBucket.forCategory(                       // alternative named constructor
    List<Expense> allExpenses,                    
    this.category
  ): expenses = allExpenses.where((expense) => expense.category == category).toList();           //  takes only expense of the specified category                                                  

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum=0;
    for(final expense in expenses){
      sum+=expense.amount;

    }
    return sum;
  }
}
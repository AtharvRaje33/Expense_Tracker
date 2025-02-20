import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter course',
        amount: 499,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Burger King',
        amount: 700,
        date: DateTime.now(),
        category: Category.food)
  ];

  _openAddExpenseOverlay(){
    showModalBottomSheet(
      context: context, builder: (ctx)=> NewExpense(onAddExpense: _addExpense),
      isScrollControlled: true,
      );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense deleted'),
      action: SnackBarAction(label: 'Undo', onPressed: (){
        setState(() {
          _registeredExpenses.insert(expenseIndex, expense);
        });
      }
      ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {


   
    Widget mainContent = const Center(child: Text('No expense found. Start adding some!'));

    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(
            expenses: _registeredExpenses,
          onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
      actions: [
        IconButton(
          onPressed: _openAddExpenseOverlay, 
          icon: const Icon(Icons.add)
        )
      ],      
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses), 
          Expanded(child: mainContent
          )
        ],
      ),
    );
  }
}


// when we try to display a column inside another column, the size of the inner column is undefined 
//hence we wrap inner columm with expanded
// any builder: argument always requires a function as a value
// every widget has its own context, context has metadeta- it holds info of that particular widget in the tree

// snackbar is an info message shown on the screen

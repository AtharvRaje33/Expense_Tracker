import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget{

  const ExpensesList({super.key,required this.expenses,required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.75),
        margin:  EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal), // get theme from cardtheme defined in main.dart
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction){onRemoveExpense(expenses[index]);},
        child: ExpensesItem(expenses[index],
        )),
    );
  }
}


// Columns can be used in place of lists
// But when we have lists of unknown length, column should not be used as it creates all widgets in it once column becomes active
// listviews are always scrollable
// .builder creates the list items only when they are about to become visible
// dismissable is used to remove the items of list
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesItem extends StatelessWidget{

  const ExpensesItem(this.expense,{super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return   Card(child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(expense.title,
         //style: Theme.of(context).textTheme.titleLarge     // theme from themedata set in theme
          ),  
          const SizedBox(height: 4,),
          Row(
            children: [
              Text('₹${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(children: [
                Icon(categoryIcons[expense.category]),
                const SizedBox(width: 8,),
                Text(expense.formattedDate)

              ],)
            ],
          )
        ],
      ),
      ),
    );
  }
}


// \ is used to escape sequence
// spacer is a widget that can be used in any column or row which takes up all the space it can between other widgets
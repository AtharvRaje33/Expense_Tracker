import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }


  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount==null || enteredAmount<=0;
    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate==null){
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text('Please make sure a valid title, amount, date and category was entered'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(ctx);
          }, child: const Text('Okay'))
        ],
      ));
      return;
    }
    widget.onAddExpense(Expense(title: _titleController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 30,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '₹ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No date selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month_outlined))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase(),
                          )
                        )
                      )
                      .toList(),
                  onChanged: (value) {
                    if(value==null){
                      return;
                    }
                    setState(() {
                      _selectedCategory=value;
                    });
                  }),
                    const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('Save Expense'))
            ],
          )
        ],
      ),
    );
  }
}


// Textfield is used for text input
// keyboard type specifies which type of keyboard should be opened when user taps the textfield, eg: for email,for text,for date,etc.
// Texteditingcontroller does all the work of storing the user input
// navigator is used to navigate bw diff screens, it takes in the current context as argument
// navigator pop removes the overlay from the screen  
// textfield also tries to take as much space as it can, hence it is wrapped with expanded
// date picker returns a value of type future
// async await can be used for saving values of type future
// ! mark tells dart that the possible value wont be null
// The dropdown button take a value of type dynamic in which the selecte option from dropdown will be stored

// map is used to transform a list,etc. from one type of value to another type of value
// map takes a function which will be executed for every listitem automatically   

// trim removes extra whitespaces - can be called on strings
// isEmpty is a built in property - can be called on lists and strings

// double.tryparse converts string into a double number, if the string is invalid, it returns null

// using widget. we can access members of the widget class inside of its respective state class
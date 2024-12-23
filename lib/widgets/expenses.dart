import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

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
      title: 'flutter course',
      amount: 19.99,
      category: Category.work,
      date: DateTime.now(),
    ),
    Expense(
      title: 'cinema',
      amount: 15,
      category: Category.leisure,
      date: DateTime.now(),
    )
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddToExpenseList: addToExpensesList,
      ),
    );
  }

  void addToExpensesList(Expense expense) {
    setState(() {
      _registeredExpenses.add(
        expense,
      );
    });
  }

  void removeFromExpensesList(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(
      () {
        _registeredExpenses.remove(expense);
      },
    );

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted successfully'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);

    final width = MediaQuery.of(context).size.width;
    Widget currentContent = const Center(
      child: Text('There is no expenses right there'),
    );

    if (_registeredExpenses.isNotEmpty) {
      currentContent = ExpensesList(
        expenses: _registeredExpenses,
        onDismess: removeFromExpensesList,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: currentContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: currentContent),
              ],
            ),
    );
  }
}

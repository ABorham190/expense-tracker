import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onDismess});
  final void Function(Expense expense) onDismess;
  final List<Expense> expenses;
  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(.75),
                margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              ),
              key: ValueKey(expenses[index]),
              onDismissed: (direction) => onDismess(
                expenses[index],
              ),
              child: ExpenseItem(
                expenses[index],
              ),
            ));
  }
}

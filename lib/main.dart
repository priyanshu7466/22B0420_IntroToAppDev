import 'package:flutter/material.dart';

void main() {
  runApp(BudgetTrackerApp());
}

class BudgetTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/expenses': (context) => ExpenseScreen(),
        '/addExpense': (context) => AddExpenseScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User Information',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Expense Total: \$500',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Categories',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category 1'),
              trailing: Text('\$100'),
              onTap: () {
                Navigator.pushNamed(context, '/expenses');
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category 2'),
              trailing: Text('\$200'),
              onTap: () {
                Navigator.pushNamed(context, '/expenses');
              },
            ),
            // Add more categories as needed
          ],
        ),
      ),
    );
  }
}

class Expense {
  final String title;
  final String category;
  final double amount;

  Expense({
    required this.title,
    required this.category,
    required this.amount,
  });
}

class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<Expense> expenses = [];

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          Expense expense = expenses[index];
          return ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text(expense.title),
            subtitle: Text(expense.category),
            trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addExpense')
              .then((value) => addExpense(value as Expense));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddExpenseScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Expense Title'),
            ),
            TextFormField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextFormField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text;
                String category = categoryController.text;
                double amount = double.parse(amountController.text);

                Expense expense = Expense(
                  title: title,
                  category: category,
                  amount: amount,
                );

                Navigator.pop(context, expense);
              },
              child: Text('Save Expense'),
            ),
          ],
        ),
      ),
    );
  }
}

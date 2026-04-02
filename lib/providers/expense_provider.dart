import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/hive_service.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  ExpenseProvider() {
    _loadData();
  }

  void _loadData() {
    _expenses = HiveService.expensesBox.values.toList();
    if (_expenses.isEmpty) {
      _addDummyData();
    }
    notifyListeners();
  }

  void _addDummyData() {
    // Assuming the Honda Civic dummy ID is accessible in UI, we just hardcode a couple for testing charts.
    // In reality, this relies on a valid Vehicle ID. We'll use a generic one or match it later.
    final e1 = Expense(
      vehicleId: 'dummy_vehicle_1',
      date: DateTime.now().subtract(const Duration(days: 5)),
      category: 'Fuel',
      amount: 40.0,
      description: 'Full tank',
    );
    final e2 = Expense(
      vehicleId: 'dummy_vehicle_1',
      date: DateTime.now().subtract(const Duration(days: 15)),
      category: 'Insurance',
      amount: 300.0,
      description: 'Annual renewal',
    );
    addExpense(e1);
    addExpense(e2);
  }

  Future<void> addExpense(Expense expense) async {
    await HiveService.expensesBox.put(expense.id, expense);
    _expenses.add(expense);
    notifyListeners();
  }

  Future<void> deleteExpense(Expense expense) async {
    await expense.delete();
    _expenses.remove(expense);
    notifyListeners();
  }

  List<Expense> getExpensesForVehicle(String vehicleId) {
    return _expenses.where((e) => e.vehicleId == vehicleId).toList();
  }

  Map<String, double> getCategoryBreakdown() {
    final map = <String, double>{};
    for (var e in _expenses) {
      map[e.category] = (map[e.category] ?? 0.0) + e.amount;
    }
    return map;
  }
}

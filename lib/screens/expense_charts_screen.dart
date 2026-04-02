import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/expense_provider.dart';
import '../widgets/web_max_width_container.dart';
import 'package:intl/intl.dart';

class ExpenseChartsScreen extends StatefulWidget {
  const ExpenseChartsScreen({super.key});

  @override
  State<ExpenseChartsScreen> createState() => _ExpenseChartsScreenState();
}

class _ExpenseChartsScreenState extends State<ExpenseChartsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Expense Analytics'),
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            indicatorColor: Color(0xFF4F46E5),
            labelColor: Color(0xFF4F46E5),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Categories', icon: Icon(Icons.pie_chart)),
              Tab(text: 'Monthly', icon: Icon(Icons.bar_chart)),
            ],
          ),
        ),
        body: const WebMaxWidthContainer(
          child: TabBarView(
            children: [
              _CategoryPieChart(),
              _MonthlyBarChart(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryPieChart extends StatelessWidget {
  const _CategoryPieChart();

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final data = expenseProvider.getCategoryBreakdown();

    if (data.isEmpty) {
      return Center(child: Text('No expenses recorded yet', style: TextStyle(color: Colors.grey.shade500)));
    }

    double total = data.values.fold(0, (sum, item) => sum + item);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20)],
            ),
            child: Column(
              children: [
                Text(
                  'Total Lifecycle Expenses',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF4F46E5)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 250,
            child: PieChart(
              PieChartData(
                sectionsSpace: 4,
                centerSpaceRadius: 50,
                sections: _generateChartData(data),
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildLegend(data),
          const SizedBox(height: 100), // Navigation spacing
        ],
      ),
    );
  }

  List<PieChartSectionData> _generateChartData(Map<String, double> data) {
    final colors = [const Color(0xFF4F46E5), const Color(0xFF22C55E), const Color(0xFFF59E0B), const Color(0xFFEF4444), const Color(0xFF06B6D4), const Color(0xFF8B5CF6)];
    int colorIndex = 0;
    return data.entries.map((entry) {
      final color = colors[colorIndex % colors.length];
      colorIndex++;
      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '\$${entry.value.toStringAsFixed(0)}',
        radius: 60,
        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  Widget _buildLegend(Map<String, double> data) {
    final colors = [const Color(0xFF4F46E5), const Color(0xFF22C55E), const Color(0xFFF59E0B), const Color(0xFFEF4444), const Color(0xFF06B6D4), const Color(0xFF8B5CF6)];
    int colorIndex = 0;
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: data.entries.map((entry) {
        final color = colors[colorIndex % colors.length];
        colorIndex++;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10)]),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _MonthlyBarChart extends StatelessWidget {
  const _MonthlyBarChart();

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final data = _getMonthlyData(expenseProvider);

    if (data.isEmpty) {
      return Center(child: Text('No expenses recorded', style: TextStyle(color: Colors.grey.shade500)));
    }

    final double maxVal = data.values.isEmpty ? 100 : data.values.reduce((a, b) => a > b ? a : b);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Periodic Expenditure', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87)),
                const SizedBox(height: 32),
                SizedBox(
                  height: 250,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxVal * 1.2,
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= data.keys.length) return const Text('');
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(data.keys.elementAt(index), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              if (value == 0) return const Text('');
                              return Text('\$${value.toInt()}', style: const TextStyle(fontSize: 10, color: Colors.grey));
                            },
                          )
                        ),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: maxVal / 4, getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey.shade200, strokeWidth: 1)),
                      borderData: FlBorderData(show: false),
                      barGroups: data.entries.toList().asMap().entries.map((entry) {
                        return BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.value,
                              color: const Color(0xFF4F46E5),
                              width: 24,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100), // Navigation spacing
        ],
      ),
    );
  }

  Map<String, double> _getMonthlyData(ExpenseProvider provider) {
    Map<String, double> monthlyData = {};
    for (var exp in provider.expenses) {
      String monthLabel = DateFormat('MMM yy').format(exp.date);
      monthlyData[monthLabel] = (monthlyData[monthLabel] ?? 0.0) + exp.amount;
    }
    return monthlyData;
  }
}

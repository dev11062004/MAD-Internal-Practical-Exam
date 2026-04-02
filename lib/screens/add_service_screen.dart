import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/vehicle_provider.dart';
import '../providers/expense_provider.dart';
import '../models/service_record.dart';
import '../models/expense.dart';

class AddServiceScreen extends StatefulWidget {
  final String vehicleId;

  const AddServiceScreen({super.key, required this.vehicleId});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _costCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _serviceType = 'Oil Change';
  DateTime _serviceDate = DateTime.now();

  @override
  void dispose() {
    _costCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _serviceDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _serviceDate = picked;
      });
    }
  }

  void _saveService() {
    if (_formKey.currentState!.validate()) {
      final double cost = double.tryParse(_costCtrl.text) ?? 0.0;
      
      final serviceRecord = ServiceRecord(
        vehicleId: widget.vehicleId,
        serviceDate: _serviceDate,
        serviceType: _serviceType,
        notes: _notesCtrl.text,
        cost: cost,
      );

      final expenseRecord = Expense(
        vehicleId: widget.vehicleId,
        date: _serviceDate,
        category: _serviceType,
        amount: cost,
        description: _notesCtrl.text,
      );

      Provider.of<VehicleProvider>(context, listen: false).addServiceRecord(serviceRecord);
      Provider.of<ExpenseProvider>(context, listen: false).addExpense(expenseRecord);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Service Record')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: _serviceType,
                  decoration: const InputDecoration(labelText: 'Service Type', border: OutlineInputBorder()),
                  items: ['Oil Change', 'General Service', 'Repair', 'Tire Change', 'Insurance', 'Other']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _serviceType = val);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _costCtrl,
                  decoration: const InputDecoration(labelText: 'Cost', border: OutlineInputBorder()),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (val) => val == null || val.isEmpty ? 'Enter cost' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesCtrl,
                  decoration: const InputDecoration(labelText: 'Notes', border: OutlineInputBorder()),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(labelText: 'Service Date', border: OutlineInputBorder()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${_serviceDate.toLocal()}".split(' ')[0]),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _saveService,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                  child: const Text('Save Service'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

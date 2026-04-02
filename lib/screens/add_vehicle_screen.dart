import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/vehicle_provider.dart';
import '../models/vehicle.dart';

class AddEditVehicleScreen extends StatefulWidget {
  final Vehicle? existingVehicle;

  const AddEditVehicleScreen({super.key, this.existingVehicle});

  @override
  State<AddEditVehicleScreen> createState() => _AddEditVehicleScreenState();
}

class _AddEditVehicleScreenState extends State<AddEditVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _modelCtrl;
  late TextEditingController _regCtrl;
  String _fuelType = 'Petrol';
  DateTime _purchaseDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.existingVehicle?.name ?? '');
    _modelCtrl = TextEditingController(text: widget.existingVehicle?.model ?? '');
    _regCtrl = TextEditingController(text: widget.existingVehicle?.registrationNumber ?? '');
    if (widget.existingVehicle != null) {
      _fuelType = widget.existingVehicle!.fuelType;
      _purchaseDate = widget.existingVehicle!.purchaseDate;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _modelCtrl.dispose();
    _regCtrl.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _purchaseDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _purchaseDate) {
      setState(() {
        _purchaseDate = picked;
      });
    }
  }

  void _saveVehicle() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<VehicleProvider>(context, listen: false);
      
      if (widget.existingVehicle != null) {
        // Edit
        widget.existingVehicle!.name = _nameCtrl.text;
        widget.existingVehicle!.model = _modelCtrl.text;
        widget.existingVehicle!.registrationNumber = _regCtrl.text;
        widget.existingVehicle!.fuelType = _fuelType;
        widget.existingVehicle!.purchaseDate = _purchaseDate;
        provider.updateVehicle(widget.existingVehicle!);
      } else {
        // Add
        final newVehicle = Vehicle(
          name: _nameCtrl.text,
          model: _modelCtrl.text,
          registrationNumber: _regCtrl.text,
          purchaseDate: _purchaseDate,
          fuelType: _fuelType,
        );
        provider.addVehicle(newVehicle);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingVehicle == null ? 'Add Vehicle' : 'Edit Vehicle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(labelText: 'Make/Name (e.g. Honda)', border: OutlineInputBorder()),
                  validator: (val) => val == null || val.isEmpty ? 'Required field' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _modelCtrl,
                  decoration: const InputDecoration(labelText: 'Model (e.g. Civic)', border: OutlineInputBorder()),
                  validator: (val) => val == null || val.isEmpty ? 'Required field' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _regCtrl,
                  decoration: const InputDecoration(labelText: 'Registration Number', border: OutlineInputBorder()),
                  validator: (val) => val == null || val.isEmpty ? 'Required field' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _fuelType,
                  decoration: const InputDecoration(labelText: 'Fuel Type', border: OutlineInputBorder()),
                  items: ['Petrol', 'Diesel', 'Electric', 'Hybrid'].map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _fuelType = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(labelText: 'Purchase Date', border: OutlineInputBorder()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${_purchaseDate.toLocal()}".split(' ')[0]),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _saveVehicle,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                  child: const Text('Save Vehicle'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

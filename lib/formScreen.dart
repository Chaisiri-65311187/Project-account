import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/deviceProvider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _brand = '';

  void _saveDevice() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<DeviceProvider>(context, listen: false)
          .addDevice(_name, _brand);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Device')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Device Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Brand'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a brand' : null,
                onSaved: (value) => _brand = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveDevice,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/deviceProvider.dart';
import 'model/deviceItem.dart';

class EditScreen extends StatefulWidget {
  final DeviceItem device;

  const EditScreen({super.key, required this.device});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _brand;

  @override
  void initState() {
    super.initState();
    _name = widget.device.name;
    _brand = widget.device.brand;
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<DeviceProvider>(context, listen: false)
          .updateDevice(widget.device.id, _name, _brand);
      Navigator.pop(context);
    }
  }

  void _deleteDevice() {
    Provider.of<DeviceProvider>(context, listen: false)
        .removeDevice(widget.device.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Device')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Device Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _brand,
                decoration: const InputDecoration(labelText: 'Brand'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a brand' : null,
                onSaved: (value) => _brand = value!,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _deleteDevice,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Delete'),
                  ),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

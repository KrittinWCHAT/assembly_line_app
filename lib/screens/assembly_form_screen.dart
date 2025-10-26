import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/assembly_line.dart';
import '../providers/assembly_lines_provider.dart';

class AssemblyFormScreen extends StatefulWidget {
  final AssemblyLine? item;
  AssemblyFormScreen({this.item});

  @override
  _AssemblyFormScreenState createState() => _AssemblyFormScreenState();
}

class _AssemblyFormScreenState extends State<AssemblyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String serialNumber;
  late String productType;
  late String operatorName;
  late String status;
  late String speedStr;
  late String startedAt;

  @override
  void initState() {
    super.initState();
    final it = widget.item;
    serialNumber = it?.serialNumber ?? '';
    productType = it?.productType ?? '';
    operatorName = it?.operatorName ?? '';
    status = it?.status ?? 'running';
    speedStr = it?.speed.toString() ?? '0.0';
    startedAt = it?.startedAt ?? DateTime.now().toIso8601String();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    final speed = double.tryParse(speedStr) ?? 0.0;
    final a = AssemblyLine(
      id: widget.item?.id,
      serialNumber: serialNumber,
      productType: productType,
      status: status,
      operatorName: operatorName,
      speed: speed,
      startedAt: startedAt,
    );
    final prov = Provider.of<AssemblyLinesProvider>(context, listen: false);
    if (widget.item == null) {
      await prov.add(a);
    } else {
      await prov.update(a);
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Assembly' : 'New Assembly')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: serialNumber,
                decoration: InputDecoration(labelText: 'Assembly Line No.'),
                validator: (v) => v==null || v.trim().isEmpty ? 'Required' : null,
                onSaved: (v) => serialNumber = v!.trim(),
              ),
              TextFormField(
                initialValue: productType,
                decoration: InputDecoration(labelText: 'Product Type'),
                validator: (v) => v==null || v.trim().isEmpty ? 'Required' : null,
                onSaved: (v) => productType = v!.trim(),
              ),
              TextFormField(
                initialValue: operatorName,
                decoration: InputDecoration(labelText: 'Operator Name'),
                onSaved: (v) => operatorName = v!.trim(),
              ),
              TextFormField(
                initialValue: status,
                decoration: InputDecoration(labelText: 'Status (running/stop)'),
                onSaved: (v) => status = v!.trim(),
              ),
              TextFormField(
                initialValue: speedStr,
                decoration: InputDecoration(labelText: 'Speed (units/min)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => speedStr = v!.trim(),
              ),
              SizedBox(height: 12),
              ElevatedButton.icon(icon: Icon(Icons.save), label: Text('Save'), onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
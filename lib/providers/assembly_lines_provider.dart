import 'package:flutter/material.dart';
import '../models/assembly_line.dart';
import '../repositories/assembly_repository.dart';

class AssemblyLinesProvider with ChangeNotifier {
  final AssemblyRepository _repo = AssemblyRepository();
  List<AssemblyLine> _items = [];

  List<AssemblyLine> get items => List.unmodifiable(_items);

  Future<void> loadAll() async {
    _items = await _repo.getAll();
    notifyListeners();
  }

  Future<void> add(AssemblyLine a) async {
    final id = await _repo.insert(a);
    final added = a.copyWith(id: id);
    _items.insert(0, added);
    notifyListeners();
  }

  Future<void> update(AssemblyLine a) async {
    await _repo.update(a);
    final idx = _items.indexWhere((e) => e.id == a.id);
    if (idx >= 0) {
      _items[idx] = a;
      notifyListeners();
    }
  }

  Future<void> remove(int id) async {
    await _repo.delete(id);
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
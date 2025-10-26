import '../db/assembly_db.dart';
import '../models/assembly_line.dart';

class AssemblyRepository {
  final AssemblyDB _db = AssemblyDB();

  Future<int> insert(AssemblyLine a) => _db.insertAssembly(a);
  Future<List<AssemblyLine>> getAll() => _db.getAll();
  Future<int> update(AssemblyLine a) => _db.updateAssembly(a);
  Future<int> delete(int id) => _db.deleteAssembly(id);
}
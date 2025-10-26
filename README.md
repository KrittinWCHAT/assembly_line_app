Assembly Line Manager - Flutter app (SQLite + Provider)

Model: AssemblyLine (id, serialNumber, productType, status, operatorName, speed, startedAt)
Features:
- SQLite DB with table assembly_lines
- Repository layer (repositories/assembly_repository.dart)
- Provider (providers/assembly_lines_provider.dart)
- Screens: Lobby, List, Form (add/edit)
- CRUD operations (create, read, update, delete)

How to run:
1. Install Flutter SDK (stable).
2. In project root, run `flutter pub get`
3. Run on device/emulator: `flutter run`
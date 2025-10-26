import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/assembly_lines_provider.dart';
import 'assembly_form_screen.dart';
import '../main.dart';

class AssemblyListScreen extends StatefulWidget {
  @override
  _AssemblyListScreenState createState() => _AssemblyListScreenState();
}

class _AssemblyListScreenState extends State<AssemblyListScreen> {
  bool _init = true;
  String _searchQuery = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      Provider.of<AssemblyLinesProvider>(context, listen: false).loadAll();
      _init = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AssemblyLinesProvider>(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    final filtered = prov.items.where((a) {
      final q = _searchQuery.toLowerCase();
      return a.productType.toLowerCase().contains(q) ||
          a.serialNumber.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assembly Lines'),
        actions: [
          IconButton(
            icon: Icon(themeProv.isDark ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Toggle Theme',
            onPressed: () => themeProv.toggleTheme(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by product or serial...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No records found.'))
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (_, i) {
                      final a = filtered[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: ListTile(
                          title: Text('${a.productType} — ${a.serialNumber}'),
                          subtitle: Text(
                              'Operator: ${a.operatorName} • Status: ${a.status} • Speed: ${a.speed}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        AssemblyFormScreen(item: a),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  final ok = await showDialog<bool>(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('Confirm delete'),
                                      content:
                                          const Text('Delete this record?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (ok == true && a.id != null) {
                                    await Provider.of<AssemblyLinesProvider>(
                                            context,
                                            listen: false)
                                        .remove(a.id!);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AssemblyFormScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}

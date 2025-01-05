import 'package:flutter/material.dart';
import 'package:hey/Home.dart';

class TableSelectionPage extends StatefulWidget {
  const TableSelectionPage({super.key});

  @override
  State<TableSelectionPage> createState() => _TableSelectionPageState();
}

class _TableSelectionPageState extends State<TableSelectionPage> {
  String? selectedTable;
  final List<String> tables = List.generate(20, (index) => '${index + 1}');
  bool isLoading = false;

  Future<void> _selectTable(String table) async {
    setState(() {
      isLoading = true;
      selectedTable = table;
    });

    // Simulate loading time (you can replace this with actual API calls later)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
          tableNumber: selectedTable!,
          onChangeTable: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TableSelectionPage(),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to our Restaurant'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Please select your table number',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: tables.length,
                  itemBuilder: (context, index) {
                    final table = tables[index];
                    final isSelected = selectedTable == table;

                    return ElevatedButton(
                      onPressed: isLoading ? null : () => _selectTable(table),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Table $table',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

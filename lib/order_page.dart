import 'package:flutter/material.dart';
//import 'package:first/Home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hey/table_selection_page.dart';
class OrderPage extends StatefulWidget {
  final Map<String, int> selectedItems;
  final List<Map<String, dynamic>> foods;
  final String tableNumber;

  const OrderPage({
    super.key,
    required this.selectedItems,
    required this.foods,
    required this.tableNumber,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final databaseRef = FirebaseDatabase.instance.ref();
  bool isLoading = false;

  double get totalPrice {
    double total = 0;
    for (var food in widget.foods) {
      if (widget.selectedItems.containsKey(food['name'])) {
        total += food['price'] * widget.selectedItems[food['name']]!;
      }
    }
    return total;
  }
  // firebase connection 
  Future<void> _uploadOrder(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      final now = DateTime.now();
      final dateStr =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

      int hour =
          now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
      final period = now.hour >= 12 ? 'PM' : 'AM';
      final timeStr =
          '${hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} $period';

      await databaseRef.child('orders').child(widget.tableNumber).set({
        'items': widget.selectedItems.map((key, value) => MapEntry(key, value)),
        'totalPrice': totalPrice,
        'tableNumber': widget.tableNumber,
        'enabled': true,
        'date': dateStr,
        'time': timeStr,
      });

      if (!context.mounted) return;

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order placed successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Wait for snackbar to show before navigation
      await Future.delayed(const Duration(seconds: 2));

      if (!context.mounted) return;

      // Changed navigation to go to TableSelectionPage
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const TableSelectionPage(),
        ),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error placing order: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Your Order'),
        backgroundColor: const Color(0xFF1F1F1F),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.selectedItems.length,
              itemBuilder: (context, index) {
                String foodName = widget.selectedItems.keys.elementAt(index);
                var food =
                    widget.foods.firstWhere((f) => f['name'] == foodName);
                int quantity = widget.selectedItems[foodName]!;
                double itemTotal = food['price'] * quantity;

                return Card(
                  color: const Color(0xFF1E1E1E),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Food image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            food['image'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Food details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                food['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${quantity}x \E\G\P${food['price'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Total price
                        Text(
                          '\E\G\P ${itemTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Order summary
          Container(
            color: const Color(0xFF1E1E1E),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '\E\G\P ${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : () => _uploadOrder(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Order',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




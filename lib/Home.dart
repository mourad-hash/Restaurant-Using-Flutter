import 'package:flutter/material.dart';
import 'order_page.dart';

class Home extends StatefulWidget {
  final String tableNumber;
  final VoidCallback onChangeTable;

  const Home({
    super.key,
    required this.tableNumber,
    required this.onChangeTable,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String _searchQuery = '';
  Map<String, int> _selectedItems = {};

  // Sample food data - you can expand this or fetch from an API
final List<Map<String, dynamic>> foods = [
    {
      'name': 'Classic Burger',
      'price': 149.99,
      'category': 'Fast Food',
      'image': 'assets/burger.jpeg',
      'description': 'Juicy beef burger with cheese'
    },
    {
      'name': 'Margherita Pizza',
      'price': 199.99,
      'category': 'Pizza',
      'image': 'assets/pizza.jpeg',
      'description': 'Classic Italian pizza'
    },
    {
      'name': 'French Fries',
      'price': 40.0,
      'category': 'Fast Food',
      'image': 'assets/fries.jpeg',
      'description': 'Crispy golden fries'
    },
    {
      'name': 'Fried Chicken',
      'price': 150.0,
      'category': 'Fast Food',
      'image': 'assets/chicken.jpeg',
      'description': 'Crispy fried chicken'
    },
    {
      'name': 'Caesar Salad',
      'price': 30.0,
      'category': 'Fast Food',
      'image': 'assets/salad.jpeg',
      'description': 'Fresh garden salad'
    },
    {
      'name': 'Coca Cola',
      'price': 30.0,
      'category': 'Drinks',
      'image': 'assets/coke.jpeg',
      'description': 'Ice-cold cola'
    },
    {
      'name': 'Coffee Latte',
      'price': 40.0,
      'category': 'Drinks',
      'image': 'assets/coffee.jpeg',
      'description': 'Hot coffee with milk'
    },
    {
      'name': 'Ice Cream Sunday',
      'price': 30.0,
      'category': 'Desserts',
      'image': 'assets/sundae.jpeg',
      'description': 'Vanilla ice cream with toppings'
    },
     // Fast Food
  {
    'name': 'Burrito with Chicken & French Fries',
    'price': 150.0,
    'category': 'Fast Food',
    'image': 'assets/BurittoWithChickenFries.jpg',
    'description': 'Delicious burrito served with chicken and fries'
  },
  {
    'name': 'Crunch Chicken Wrap',
    'price': 90.0,
    'category': 'Fast Food',
    'image': 'assets/CrunchChickenWrap90.jpg',
    'description': 'Crispy chicken wrap with a spicy sauce'
  },
  {
    'name': 'Fried Chicken & French Fries',
    'price': 120.0,
    'category': 'Fast Food',
    'image': 'assets/FriedChickenFries.jpg',
    'description': 'Golden fried chicken served with crispy fries'
  },
  {
    'name': 'Grilled Beef Burger with Fries',
    'price': 180.0,
    'category': 'Fast Food',
    'image': 'assets/GrilledBeefBurger.jpg',
    'description': 'Juicy grilled beef burger with cheese and fries'
  },
  {
    'name': 'Double BBQ Chicken Shot',
    'price': 160.0,
    'category': 'Fast Food',
    'image': 'assets/DoubleBBQChickenShot160.jpg',
    'description': 'Double BBQ chicken sandwich with tangy sauce'
  },
  {
    'name': 'Chicken Fire',
    'price': 170.0,
    'category': 'Fast Food',
    'image': 'assets/ChickenFire170.jpg',
    'description': 'Spicy and flavorful chicken with fiery seasoning'
  },
  {
    'name': 'Turkish Bazooka Chicken',
    'price': 210.0,
    'category': 'Fast Food',
    'image': 'assets/TurkishBazookaChicken210.jpg',
    'description': 'Hearty and delicious Turkish-style chicken'
  },
  // Pizza
  {
    'name': 'Mixed Pizza',
    'price': 180.0,
    'category': 'Pizza',
    'image': 'assets/MixedPizza.jpg',
    'description': 'A mix of toppings on a classic pizza base'
  },
  {
    'name': 'Cheese Pizza',
    'price': 150.0,
    'category': 'Pizza',
    'image': 'assets/PizzaWithCheese.jpg',
    'description': 'Cheesy goodness on a thin crust pizza'
  },
  {
    'name': 'Sausage Pizza',
    'price': 160.0,
    'category': 'Pizza',
    'image': 'assets/SausagePizza.jpg',
    'description': 'Savory sausage slices on a tomato base'
  },
  {
    'name': 'Chicken & Mushroom Pizza',
    'price': 170.0,
    'category': 'Pizza',
    'image': 'assets/SideViewPizza.jpg',
    'description': 'Tender chicken and mushrooms on a cheesy base'
  },
  {
    'name': 'Margherita Pizza',
    'price': 140.0,
    'category': 'Pizza',
    'image': 'assets/MargheritaPizza.jpg',
    'description': 'Classic Italian pizza with fresh basil and mozzarella'
  },
  // Drinks
  {
    'name': 'Mango Juice',
    'price': 40.0,
    'category': 'Drinks',
    'image': 'assets/MangoJuice.jpg',
    'description': 'Freshly squeezed mango juice'
  },
  {
    'name': 'Milk Shake',
    'price': 50.0,
    'category': 'Drinks',
    'image': 'assets/MilkShake.jpg',
    'description': 'Rich and creamy milkshake'
  },
  {
    'name': 'Orange Juice',
    'price': 35.0,
    'category': 'Drinks',
    'image': 'assets/OrangeJuice.jpg',
    'description': 'Fresh and tangy orange juice'
  },
  // Desserts
  {
    'name': 'Baklava',
    'price': 70.0,
    'category': 'Desserts',
    'image': 'assets/Baklava.jpg',
    'description': 'Sweet and flaky baklava with nuts and syrup'
  },
  {
    'name': 'Basbousa',
    'price': 60.0,
    'category': 'Desserts',
    'image': 'assets/Basbousa.jpg',
    'description': 'Traditional Egyptian semolina cake'
  },
  {
    'name': 'Cheesecake',
    'price': 80.0,
    'category': 'Desserts',
    'image': 'assets/CheeseCake.jpg',
    'description': 'Classic cheesecake with a buttery crust'
  },
  {
    'name': 'Chocolate Cake',
    'price': 75.0,
    'category': 'Desserts',
    'image': 'assets/ChocleteCake.jpg',
    'description': 'Moist chocolate cake with rich frosting'
  },
  {
    'name': 'Chocolate Chip Cookies',
    'price': 50.0,
    'category': 'Desserts',
    'image': 'assets/ChocleteChepCookies.jpg',
    'description': 'Crunchy cookies loaded with chocolate chips'
  },
  {
    'name': 'Cupcakes',
    'price': 45.0,
    'category': 'Desserts',
    'image': 'assets/Cupcakes.jpg',
    'description': 'Soft and colorful cupcakes'
  },
  {
    'name': 'Konafa',
    'price': 90.0,
    'category': 'Desserts',
    'image': 'assets/Konafa.jpg',
    'description': 'Golden shredded dough dessert with syrup'
  },
  {
    'name': 'Kunafa with Cream',
    'price': 95.0,
    'category': 'Desserts',
    'image': 'assets/KunafaWithCream.jpg',
    'description': 'Creamy kunafa topped with pistachios'
  },
  {
    'name': 'Om Ali',
    'price': 85.0,
    'category': 'Desserts',
    'image': 'assets/OmAli.jpg',
    'description': 'Traditional Egyptian dessert with nuts and raisins'
  },
  {
    'name': 'Strawberry Cheesecake',
    'price': 85.0,
    'category': 'Desserts',
    'image': 'assets/StrawberryCheeseCake.jpg',
    'description': 'Cheesecake topped with fresh strawberries'
  },
  {
    'name': 'Tiramisu',
    'price': 90.0,
    'category': 'Desserts',
    'image': 'assets/Tiramisu.jpg',
    'description': 'Classic Italian dessert with coffee and mascarpone'
  },
  {
    'name': 'Qatayef',
    'price': 80.0,
    'category': 'Desserts',
    'image': 'assets/Qatayef.jpg',
    'description': 'Stuffed Arabic pancakes'
  },
  {
    'name': 'Luqaimat',
    'price': 60.0,
    'category': 'Desserts',
    'image': 'assets/Luqaimat.jpg',
    'description': 'Sweet fried dumplings'
  },
  {
    'name': 'Zainab Finger',
    'price': 55.0,
    'category': 'Desserts',
    'image': 'assets/ZainabFinger.jpg',
    'description': 'Sweet dough fingers soaked in syrup'
  },
  {
    'name': 'Waffles',
    'price': 50.0,
    'category': 'Desserts',
    'image': 'assets/Waffles.jpg',
    'description': 'Soft and crispy waffles with toppings'
  },
  {
    'name': 'Brownies',
    'price': 70.0,
    'category': 'Desserts',
    'image': 'assets/Brawnis.jpg',
    'description': 'Rich and fudgy chocolate brownies'
  },
  {
    'name': 'Crepe',
    'price': 80.0,
    'category': 'Desserts',
    'image': 'assets/Crepe.jpg',
    'description': 'Thin crepes served with sweet fillings'
  },
  {
    'name': 'Christmas Biscuit',
    'price': 60.0,
    'category': 'Desserts',
    'image': 'assets/BiscuitChristmase.jpg',
    'description': 'Festive biscuits with Christmas designs'
  },
  // Salads
  {
    'name': 'Fruit Salad',
    'price': 50.0,
    'category': 'Salads',
    'image': 'assets/FrautSalad.jpg',
    'description': 'Fresh and colorful fruit salad'
  },
  {
    'name': 'Dolma Grape Leaves',
    'price': 65.0,
    'category': 'Salads',
    'image': 'assets/DolmaGrapeLeaves.jpg',
    'description': 'Stuffed grape leaves with rice and spices'
  },
  {
    'name': 'Fresh Hummus',
    'price': 55.0,
    'category': 'Salads',
    'image': 'assets/FreshHummus.jpg',
    'description': 'Smooth and creamy hummus served with olive oil'
  },
  {
    'name': 'Plate of Lamb Kebabs',
    'price': 120.0,
    'category': 'Salads',
    'image': 'assets/LambKebabs.jpg',
    'description': 'Succulent lamb kebabs with herbs'
  },
  {
    'name': 'Greek Salad',
    'price': 70.0,
    'category': 'Salads',
    'image': 'assets/GreekSalad.jpg',
    'description': 'Fresh Greek salad with feta and olives'
  },
  ];


  final PageController _pageController = PageController();

  late final List<List<Map<String, dynamic>>> _categorizedFoods = [
    foods,
    foods.where((food) => food['category'] == 'Fast Food').toList(),
    foods.where((food) => food['category'] == 'Pizza').toList(),
    foods.where((food) => food['category'] == 'Drinks').toList(),
    foods.where((food) => food['category'] == 'Desserts').toList(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _selectedItems = {};
    _searchQuery = '';
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table ${widget.tableNumber} - Food Menu'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: widget.onChangeTable,
            tooltip: 'Change Table',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search foods...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              itemCount: _categorizedFoods.length,
              itemBuilder: (context, pageIndex) {
                final categoryFoods = _searchQuery.isEmpty
                    ? _categorizedFoods[pageIndex]
                    : _categorizedFoods[pageIndex]
                        .where((food) => food['name']
                            .toString()
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                        .toList();

                return GridView.builder(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 8,
                    bottom: kBottomNavigationBarHeight + 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: categoryFoods.length,
                  itemBuilder: (context, index) {
                    final food = categoryFoods[index];
                    final itemCount = _selectedItems[food['name']] ?? 0;

                    return Card(
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(food['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food['name'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    food['description'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 47, 46, 47),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\E\G\P ${food['price'].toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          _buildIconButton(
                                            Icons.remove,
                                            () => _decrementItem(food['name']),
                                            Colors.grey[200]!,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text('$itemCount'),
                                          ),
                                          _buildIconButton(
                                            Icons.add,
                                            () => _incrementItem(food['name']),
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu), label: 'All'),
          BottomNavigationBarItem(
              icon: Icon(Icons.lunch_dining), label: 'Fast Food'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_pizza), label: 'Pizza'),
          BottomNavigationBarItem(icon: Icon(Icons.coffee), label: 'Drinks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.icecream), label: 'Desserts'),
        ],
      ),
      floatingActionButton: _selectedItems.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderPage(
                      selectedItems: _selectedItems,
                      foods: foods,
                      tableNumber: widget.tableNumber,
                    ),
                  ),
                );
              },
              label: Text(
                'View Order (${_selectedItems.values.reduce((a, b) => a + b)})',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              icon: const Icon(
                Icons.receipt_long,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildIconButton(
      IconData icon, VoidCallback onPressed, Color backgroundColor) {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        icon: Icon(icon, size: 16),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor:
              backgroundColor == Colors.grey[200] ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  void _incrementItem(String foodName) {
    setState(() {
      _selectedItems[foodName] = (_selectedItems[foodName] ?? 0) + 1;
    });
  }

  void _decrementItem(String foodName) {
    setState(() {
      if (_selectedItems[foodName] != null && _selectedItems[foodName]! > 0) {
        _selectedItems[foodName] = _selectedItems[foodName]! - 1;
        if (_selectedItems[foodName] == 0) {
          _selectedItems.remove(foodName);
        }
      }
    });
  }
}

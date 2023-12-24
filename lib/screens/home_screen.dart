import 'package:flutter/material.dart';
import 'package:lab2/screens/shopping_cart_screen.dart';

import '../model/Clothing.dart';
import '../widgets/edit_clothing.dart';
import '../widgets/new_clothing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Clothing> _clothing = [];
  List<Clothing> _shoppingCart = [];

  void _addClothing() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewClothing(
              addClothing: _addNewClothingToList,
            ),
          );
        });
  }

  void _addNewClothingToList(Clothing newClothing) {
    setState(() {
      _clothing.add(newClothing);
    });
  }

  void _editClothing(index) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: EditClothing(
              editClothing: _editClothingFromList,
              index: index,
              clothing: _clothing[index],
            ),
          );
        });
  }

  void _editClothingFromList(Clothing newClothing, int index) {
    setState(() {
      _clothing[index].name = newClothing.name;
      _clothing[index].description = newClothing.description;
      _clothing[index].price = newClothing.price;
    });
  }

  void _addToShoppingCart(int index) {
    setState(() {
      _shoppingCart.add(_clothing[index]);
    });
  }

  void _goToShoppingCart() {
    print("shopping cart pressed");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ShoppingCartScreen(shoppingCart: _shoppingCart)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lab2-201083 shop"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            ElevatedButton(
              onPressed: () => _addClothing(),
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green)),
              child: const Text(
                "Add clothing",
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
        body: GridView.builder(
          itemCount: _clothing.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "lib/images/tshirt.png",
                        height: 72,
                        width: 72,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_clothing[index].name),
                      const Text(" Price:"),
                      Text(_clothing[index].price.toString()),
                      const Text("\$"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // IconButton(
                      //       onPressed: () => _addToShoppingCart(index),
                      //       icon: const Icon(Icons.add_shopping_cart))
                      ElevatedButton(
                        onPressed: () => _addToShoppingCart(index),
                        style: const ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.green),
                        ),
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _clothing.removeAt(index);
                          });
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.green),
                        ),
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _editClothing(index),
                        style: const ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.green)),
                        child: const Text(
                          "Edit",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       setState(() {
                      //         _clothing.removeAt(index);
                      //       });
                      //     },
                      //     icon: const Icon(Icons.delete_rounded)),
                      // IconButton(
                      //   onPressed: () => _editClothing(index),
                      //   icon: const Icon(Icons.edit_rounded),
                      // ),
                      // IconButton(
                      //     onPressed: () => _addToShoppingCart(index),
                      //     icon: const Icon(Icons.add_shopping_cart))
                    ],
                  )
                ],
              ),
              // child: ListTile(
              //   title: Text(_clothing[index].name),
              //   subtitle: Text(_clothing[index].description),
              //   trailing: IconButton(
              //     icon: const Icon(Icons.delete_rounded),
              //     onPressed: (){
              //       setState(() {
              //         _clothing.removeAt(index);
              //       });
              //     },
              //   ),
              // ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: _goToShoppingCart,
                style: const ButtonStyle(
                  backgroundColor:
                  MaterialStatePropertyAll<Color>(Colors.green),
                ),
                child: const Row(
                  children: [Text("View cart",
                    style: TextStyle(color: Colors.red),),
                    Icon(Icons.add_shopping_cart, color: Colors.red,)],
                ))
          ],
        ));
  }
}

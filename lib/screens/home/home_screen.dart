import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/providers/cart_provider.dart';
import 'package:flutter_riverpod_tutorial/providers/products_provider.dart';

import '../../shared/cart_icon.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts = ref.watch(productsProvider);
    final cartProducts = ref.watch(cartNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Garage Sale Products'),
        actions: [CartIcon()],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: allProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(20),
              color: Colors.blueGrey.withOpacity(0.1),
              child: Column(
                children: [
                  Image.asset(allProducts[index].image, width: 60, height: 60),
                  Text(allProducts[index].title),
                  Text('\£${allProducts[index].price}'),

                  if (cartProducts.any((p) => p.id == allProducts[index].id))
                    TextButton(
                      onPressed: () {
                        ref
                            .read(cartNotifierProvider.notifier)
                            .removeProduct(allProducts[index]);
                      },
                      child: Text('Remove'),
                    ),

                  if (!cartProducts.any((p) => p.id == allProducts[index].id))
                    TextButton(
                      // style: TextButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        ref
                            .read(cartNotifierProvider.notifier)
                            .addProduct(allProducts[index]);
                      },
                      child: Text('Add to Cart'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

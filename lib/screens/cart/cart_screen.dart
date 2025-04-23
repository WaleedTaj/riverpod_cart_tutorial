import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/providers/cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  bool showCoupon = true;
  @override
  Widget build(BuildContext context) {
    final cartProducts = ref.watch(cartNotifierProvider);
    final total = ref.watch(cartTotalProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        centerTitle: true,
        // actions: [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Column(
                children:
                    cartProducts.map((products) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Image.asset(products.image, width: 60, height: 60),
                            SizedBox(width: 10),
                            Text('${products.title}...'),
                            Expanded(child: SizedBox()),
                            Text('£${products.price}'),
                          ],
                        ),
                      );
                    }).toList(),
              ),
              Text('Total Price - £$total'),
            ],
          ),
          // output totals here
        ),
      ),
    );
  }
}

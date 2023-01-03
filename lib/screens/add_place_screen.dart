import 'package:flutter/material.dart';

class AddPlaceScreen extends StatelessWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add n New Place'),
      ),
      body: Column(
        children: [
          const Text('User Inputs...'),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
          ),
        ],
      ),
    );
  }
}

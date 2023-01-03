import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/custom_dialog.dart';
import '../widgets/image_input.dart';
import '../providers/great_place.dart';

class AddPlaceScreen extends StatelessWidget {
  static const routeName = '/add-place';

  // final Function onSelectImage;

  AddPlaceScreen({super.key});

  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    File? _pickedImage;

    void _selectImage(File pickedImage) {
      _pickedImage = pickedImage;
    }

    void _savePlace() {
      if (_titleController.text.isEmpty || _pickedImage == null) {
        customDialog(
          title: 'Message',
          msg: 'You have not made any selection',
          context: context,
          onConfirmHandler: () {
            Navigator.of(context).pop();
          },
        );
        return;
      }
      Provider.of<GreatPlaces>(context, listen: false).addPlace(
        _titleController.text,
        _pickedImage!,
      );
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 10),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}

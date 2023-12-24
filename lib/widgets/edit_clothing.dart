
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab2/model/Clothing.dart';

class EditClothing extends StatefulWidget {
  final Function editClothing;
  final int index;
  final Clothing clothing;
  const EditClothing({super.key, required this.editClothing, required this.index, required this.clothing});

  @override
  State<EditClothing> createState() => _EditClothingState();
}

class _EditClothingState extends State<EditClothing> {
  final _nameController = new TextEditingController();
  final _descriptionController = new TextEditingController();
  final _priceController = new TextEditingController();
  String name="";
  String description="";
  double price=0.0;

  @override
  void initState() {
    // TODO: implement initState
    _nameController.text=widget.clothing.name;
    _descriptionController.text=widget.clothing.description;
    _priceController.text=widget.clothing.price.toString();
  }

  void _submitData(){
    if(_nameController.text.isEmpty || _descriptionController.text.isEmpty){
      return;
    }

    this.name=_nameController.text;
    this.description=_descriptionController.text;
    this.price=double.parse(_priceController.text);

    final newClothing = Clothing(Random().nextInt(1000), name, description, price);

    widget.editClothing(newClothing, widget.index);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name:"),
            onSubmitted: (_) => _submitData,
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: "Description:"),
            onSubmitted: (_) => _submitData,
          ),
          TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Price:"),
              onSubmitted: (_) => _submitData,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ]
          ),
          ElevatedButton(
            onPressed: _submitData,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                )
            ),
            child: const Text("Edit item"),
          )
        ],
      ),
    );
  }
}

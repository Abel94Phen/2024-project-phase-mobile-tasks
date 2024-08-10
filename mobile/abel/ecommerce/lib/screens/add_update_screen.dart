import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product6/widgets/rectangular_button_widget.dart';

class AddUpdatepage extends StatelessWidget {
  const AddUpdatepage({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(File(image.path), fit: BoxFit.cover),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      "Add Products",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () => _pickImage(context),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Upload Image',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'name',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(243, 243, 243, 1),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Circular border
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'category',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(243, 243, 243, 1),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Circular border
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'price',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(243, 243, 243, 1),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Circular border
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'description',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(243, 243, 243, 1),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Circular border
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: CustomRectangularButton(
                            text: 'ADD',
                            borderColor: const Color.fromARGB(255, 63, 81, 243),
                            textColor: Colors.white,
                            backgroundColor:
                                const Color.fromARGB(255, 63, 81, 243),
                            onPressed: () {
                              debugPrint('Add Pressed');
                            }),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity,
                          child: CustomRectangularButton(
                              text: "DELETE",
                              borderColor: Colors.red,
                              textColor: Colors.red,
                              backgroundColor: Colors.white,
                              onPressed: () {
                                debugPrint("Delete Pressed");
                              })),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

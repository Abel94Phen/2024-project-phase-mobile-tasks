import 'package:flutter/material.dart';
import 'package:product6/models/products_list.dart'; // Import your productData

import '../widgets/product_card_widget.dart'; // Import the ProductCard widget

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        String selectedCategory = 'Shoes';
        RangeValues selectedPriceRange = const RangeValues(20, 80);

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildSectionTitle('Filter Options'),
                  _buildDropdown(
                    label: 'Category',
                    value: selectedCategory,
                    items: <String>['Shoes', 'Belt', 'Watch'],
                    onChanged: (String? newValue) {
                      setModalState(() {
                        selectedCategory = newValue!;
                      });
                    },
                  ),
                  _buildRangeSlider(
                    rangeValues: selectedPriceRange,
                    onChanged: (RangeValues newRange) {
                      setModalState(() {
                        selectedPriceRange = newRange;
                      });
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 63, 81, 243),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        // Handle filter values if needed
                        print('Selected Category: $selectedCategory');
                        print(
                            'Selected Price Range: ${selectedPriceRange.start} - ${selectedPriceRange.end}');
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildSearchRow(context),
            const SizedBox(height: 20),
            Expanded(
              child: _buildProductList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              "Search Products",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search",
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              suffixIcon: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Handle search action
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 63, 81, 243),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => _showFilterModal(context),
            child: const Icon(Icons.filter_list),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        DropdownButton<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          isExpanded: true, // Make dropdown take full width
        ),
      ],
    );
  }

  Widget _buildRangeSlider({
    required RangeValues rangeValues,
    required ValueChanged<RangeValues> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Price Range',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        RangeSlider(
          values: rangeValues,
          min: 0,
          max: 100,
          divisions: 10,
          labels: RangeLabels(
            rangeValues.start.round().toString(),
            rangeValues.end.round().toString(),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      itemCount: productData.length,
      itemBuilder: (context, index) {
        final product = productData.values.elementAt(index);

        return ProductCard(
          imageUrl: product.image,
          productName: product.name,
          price: product.price,
          rating: 4.0,
          category: product.category,
        );
      },
    );
  }
}

class Product {
  String _name;
  String _description;
  double _price;

  // Constructor
  Product(this._name, this._description, this._price);

  // Getters for the properties
  String get name => this._name;
  String get description => this._description;
  double get price => this._price;

  // Setters for the properties
  set name(String newName) {
    _name = newName;
  }

  set description(String newDescription) {
    _description = newDescription;
  }

  set price(double newPrice) {
    _price = newPrice;
  }

  @override
  String toString() {
    return "Product Name: ${_name} | Product Description: ${_description} | Product Price: \$${_price}";
  }
}

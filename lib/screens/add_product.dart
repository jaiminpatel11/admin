import 'package:admin/db/brand.dart';
import 'package:admin/db/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProudct extends StatefulWidget {
  @override
  _AddProudctState createState() => _AddProudctState();
}

class _AddProudctState extends State<AddProudct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _productNameController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDwon = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDwon = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

  @override
  void initState() {
    // _getBrands();
    //_currentCategory = categoriesDropDwon[0].value;
    _getCategories();
  }

  List<DropdownMenuItem<String>> getcategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      Map<String, dynamic> categoriesMap = Map<String, dynamic>.from(categories[i].data());
      print("category " + categoriesMap["category"]);

      items.insert(
          0,
          DropdownMenuItem(
            value: categoriesMap["category"],
          ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          "add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: new OutlineButton(
                      borderSide: BorderSide(color: grey.withOpacity(0.6), width: 1.0),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
                        child: new Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: new OutlineButton(
                      borderSide: BorderSide(color: grey.withOpacity(0.6), width: 1.0),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
                        child: new Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: new OutlineButton(
                      borderSide: BorderSide(color: grey.withOpacity(0.6), width: 1.0),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
                        child: new Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: new Text(
                  'Enter a product name with 10 characters at maximum',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: red,
                    fontSize: 12,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(hintText: "Product name"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "you must enter the produc tname";
                  } else if (value.length > 10) {
                    return "product name cant have more than 10 letters";
                  }
                },
              ),
            ),
            DropdownButton(
              items: categoriesDropDwon,
              onChanged: changeSelectedCategory,
              value: _currentCategory,
            )
          ],
        ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      Map<String, dynamic> X = Map<String, dynamic>.from(categories[0].data());
      _currentCategory = X["category"];
      categoriesDropDwon = getcategoriesDropdown();
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }
}

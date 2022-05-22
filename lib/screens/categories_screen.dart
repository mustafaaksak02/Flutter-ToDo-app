import 'package:flutter/material.dart';
import 'package:fluttertodoapp/screens/home_screen.dart';
import 'package:fluttertodoapp/services/category_service.dart';

import '../models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = <Category>[];

  var category;

  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();


  @override
  void initState(){
    super.initState();
    getAllCategories();
  }



  getAllCategories() async {
    _categoryList = <Category>[];
    var categories = await _categoryService.readCategories();
    categories.forEach((category){
      setState((){
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async{
    category = await _categoryService.readCategoryById(categoryId);
    setState((){
      _editCategoryNameController.text = category[0]['name'] ?? 'No Name';
      _editCategoryDescriptionController.text = category[0]['description'] ?? 'No Description';
    });
    _editFormDialog(context)
  }

  _showFormDialog(BuildContext context){

    return showDialog(context: context, barrierDismissible: true, builder: (param)
    {
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.red,
            child: const Text("İptal"),
          ),
          FlatButton(
            onPressed: () async{
              _category.name = _categoryNameController.text;
              _category.description =_categoryDescriptionController.text;
              var result =await _categoryService.saveCategory(_category);
              print(result);
            },
            color: Colors.blue,
            child: const Text("Kaydet"),
          ),
        ],
        title: const Text("Categories Form"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _categoryNameController,
                decoration: const InputDecoration(
                    hintText: "Kategori Yazınız",
                    labelText: "Kategori"
                ),
              )
              TextField(
                controller: _categoryDescriptionController,
                decoration: const InputDecoration(
                    hintText: "Açıklama Yazınız",
                    labelText: "Açıklama"
                ),
              )
            ],
          ),
        ),
      );
  }
}

  _editFormDialog(BuildContext context){

    return showDialog(context: context, barrierDismissible: true, builder: (param)
    {
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.red,
            child: const Text("İptal"),
          ),
          FlatButton(
            onPressed: () async{
              _category.id = category[0]['id'];
              _category.name = _editCategoryDescriptionController.text;
              _category.description =_editCategoryDescriptionController.text;
              var result =await _categoryService.saveCategory(_category);
              print(result);
            },
            color: Colors.blue,
            child: const Text("Güncelle"),
          ),
        ],
        title: const Text("Kategori Düzenleme Formu"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _editCategoryNameController,
                decoration: const InputDecoration(
                    hintText: "Kategori Yazınız",
                    labelText: "Kategori"
                ),
              )
              TextField(
                controller: _editCategoryDescriptionController,
                decoration: const InputDecoration(
                    hintText: "Açıklama Yazınız",
                    labelText: "Açıklama"
                ),
              )
            ],
          ),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(
          onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen())),
          elevation: 0.0,
          child: Icon(Icons.arrow_back, color: Colors.white,),
          color: Colors.blue,

        ),
        title: const Text("Kategoriler"),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.only(top:8.0, left: 16.0, right:16.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(icon: Icon(Icons.edit),onPressed: (){
                    _editCategory(context, _categoryList[index].id);
                  },),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_categoryList[index].name),
                      IconButton(icon: Icon(Icons.delete), color: Colors.red,onPressed: (){},)
                    ],
                  ),
                  subtitle: Text(_categoryList[index].description),
                ),
              ),
            );

    }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showFormDialog(context);
        },
        child: Icon(Icons.add),),
    );
  }
}

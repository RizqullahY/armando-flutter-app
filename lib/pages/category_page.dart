import 'package:drift/extensions/native.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/database.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isExpense = true;
  final AppDb database = AppDb();
  TextEditingController categoryNameController = TextEditingController();

  Future insert(String name, int type) async {
    DateTime now = DateTime.now();
    await database.into(database.categories).insertReturning(
          CategoriesCompanion.insert(
            name: Value(name), // Menggunakan Value() karena menggunakan Drift
            type: Value(type as String), // Tipe 1 untuk Income, 2 untuk Expense
            createdAt: Value(now as String),
            updatedAt: Value(now as String),
          ),
        );
  }

  Future<List<Category>> getAllCategory(int type, {required int}) async {
    return await database.getAllCategoryRepo(type);
  }

  void openDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Center(
                  child: Column(children: [
                Text(
                  "Add Category",
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: categoryNameController,
                  decoration: InputDecoration(
                      hintText: "Category Name", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    final categoryName = categoryNameController.text;
                    if (categoryName.isNotEmpty) {
                      insert(categoryName, (isExpense) ? 2 : 1);
                      Navigator.of(context).pop();
                      setState(() {});
                    }
                  },
                  child: Text((isExpense) ? "Add Expense" : "Add Income"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (isExpense) ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 12),
                  ),
                )
              ])),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        //* Switch + Add Category
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                value: isExpense, // Use your boolean variable here
                onChanged: (bool value) {
                  // Update the state of your boolean variable
                  setState(() {
                    isExpense = value;
                  });
                },
                inactiveTrackColor: Colors.green[200],
                inactiveThumbColor: Colors.green,
                activeColor: Colors.red,
              ),
              IconButton(
                  onPressed: () {
                    openDialog();
                  },
                  icon: Icon(Icons.add))
            ],
          ),
        ),

        //* List Category
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: Card(
        //     elevation: 10,
        //     child: ListTile(
        //       leading: (isExpense)
        //           ? Icon(Icons.upload, color: Colors.red)
        //           : Icon(
        //               Icons.download,
        //               color: Colors.green,
        //             ),
        //       title: Text("Sedekah"),
        //       trailing: Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        //           IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),

        FutureBuilder<List<Category>>(
            future: getAllCategory((isExpense) ? 2 : 1, int: null),
            builder: (context, snapshot) {
              //* Setiap Output Harus Ada Return-nya

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  if (snapshot.data!.length > 0) {
                    return Center(
                        child: Text(snapshot.data!.length.toString as String));
                  } else {
                    return Center(
                      child: Text("Has No Data"),
                    );
                  }
                } else {
                  return Center(
                    child: Text("Has No Data"),
                  );
                }
              }
            }),
      ],
    ));
  }

  Value(String name) {}
}

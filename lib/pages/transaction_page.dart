import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isExpense = true;
  List<String> categories = ['Sedekah', 'Upgrade To Premium'];
  late String selectedCategory = categories.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Switch dan Text
              Padding(
                padding: const EdgeInsets.all(16),
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
                    Text(
                      (isExpense) ? 'Expense' : 'Income',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: (isExpense) ? Colors.red : Colors.green,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              //* Amount - FormField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Amount',
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),

              //* Category - DropDown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Category',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: (isExpense) ? Colors.red : Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButton(
                    isExpanded: true,
                    value: selectedCategory,
                    icon: Icon(Icons.arrow_downward),
                    items: categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {}),
              ),
              SizedBox(
                height: 25,
              ),

              //* DateTime Picker
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                    decoration: InputDecoration(labelText: 'Enter Date'),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        String formattedDate = DateFormat('yyyy-MM-dd')
                            .format(pickedDate);
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

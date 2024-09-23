import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/pages/category_page.dart';
import 'package:myapp/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // ignore: unused_field
  final List<Widget> _children = [HomePage(), CategoryPage()];

  // 0 = Home , 1 = Category
  int currentIndex = 0;
  // Function untuk pindah table atau halaman yang diletakkan di icon bottom navigation bar
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentIndex == 0)
          ? CalendarAppBar(
              backButton: false,
              accent: Colors.green,
              locale: 'id',

              // ignore: avoid_print
              onDateChanged: (value) => print(value),
              firstDate: DateTime.now().subtract(const Duration(days: 140)),
              lastDate: DateTime.now(),
            )
          : PreferredSize(
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
                  child: Text("Categories" , style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
              preferredSize: Size.fromHeight(100),
            ),

      // Isinya mengikuti index yang di pilih di icon bottom navigation bar
      body: _children[currentIndex],

      floatingActionButton: Visibility(
        visible: ( currentIndex == 0 ), //* Visible saat index = 0 (Home)
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                onTabTapped(0);
              },
              icon: const Icon(Icons.home),
              color: Colors.green,
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                onTabTapped(1);
              },
              icon: const Icon(Icons.list),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

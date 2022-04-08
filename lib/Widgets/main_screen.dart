import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/Widgets/drawer.dart';
import 'package:placementcracker/helper/general.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  General general = new General();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.book_outlined,
                color: Colors.white,
              ),
              label: 'Courses'),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.book_outlined,
              ),
              label: 'Feed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), label: 'Profile'),
        ]),
        drawer: drawer(),
        appBar: AppBar(
          title: Text(
            'Placement Cracker',
            style: GoogleFonts.roboto(),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(gradient: general.backgroundColor),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Top courses for you',
                    style: GoogleFonts.rubik(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              height: height / 4,
                              width: width / 1.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: width,
                                        height: height / 6,
                                        child: Image.asset(
                                          'Assets/images/hcl.jpg',
                                          fit: BoxFit.cover,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Latest tech blogs',
                  style: GoogleFonts.rubik(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Container(
                              height: height / 3,
                              width: width,
                            ),
                          );
                        })),
              ],
            ),
          ),
        )));
  }
}

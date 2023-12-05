import 'package:ek_shodbe_quran/component/quran.dart/para.dart';
import 'package:ek_shodbe_quran/component/quran.dart/surah.dart';
import 'package:flutter/material.dart';

class ReadQuran extends StatefulWidget {
  const ReadQuran({super.key});

  @override
  State<ReadQuran> createState() => _ReadQuranState();
}

class _ReadQuranState extends State<ReadQuran>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  ScrollController _customtabController = ScrollController();

  final List<String> tabTitles = ['Dashboard', 'Exams'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
      if (index < tabTitles.length / 2) {
        _customtabController.animateTo(0,
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        _customtabController.animateTo(100,
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Image(
          image: AssetImage(
              'assets/images/toprectangle.png'), // Replace with your image path
          fit: BoxFit.cover,
        ),
        foregroundColor: Colors.white,
        title: const Text('আল-কুরআন'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0), // Adjust the height as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              tabTitles.length,
              (index) => GestureDetector(
                onTap: () => _onTabSelected(index),
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          tabTitles[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: // Show the appropriate content based on the selected tab index
            (_selectedIndex == 0) ? Surah() : Para(),
      ),
    );
  }
}

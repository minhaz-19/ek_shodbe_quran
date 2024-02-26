import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/model/calendarmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarTab extends StatefulWidget {
  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  late List<Appointment> _appointments = [];

  DateTime dateSelected = DateTime.now();

  var url = '';
  bool _isItLoading = false;
  var titleEn = '';
  var titleBn = '';
  var descriptionEn = '';
  var descriptionBn = '';
  var endTime = '';
  var contentId = '';
  var examDuration;
  var totalQuestion;
  var questionMark;
  var negativeMark;
  var startTime;
  bool isDone = true;
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  List<Appointment> events = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments(
        DateTime.now().year.toString(), DateTime.now().month.toString());
  }

  Map<int, List<int>> generateYearMonthMap() {
    Map<int, List<int>> yearMonthMap = {};

    // Get current year and month
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;

    // Iterate from -2 to 6
    for (int i = -1; i <= 3; i++) {
      // Calculate the offset year and month
      int yearOffset = currentYear;
      int monthOffset = currentMonth + i;

      // Adjust year and month if month offset goes out of bounds
      if (monthOffset <= 0) {
        monthOffset += 12;
        yearOffset -= 1;
      } else if (monthOffset > 12) {
        monthOffset -= 12;
        yearOffset += 1;
      }

      // Add the year and month to the map
      yearMonthMap[i] = [yearOffset, monthOffset];
    }

    return yearMonthMap;
  }

  void _loadAppointments(String year, String month) async {
    setState(() {
      _isItLoading = true;
      events = [];
      _appointments = [];
    });
    // call the API and get the holidays and add them to the _appointments list

    // start from two month back of current date time and upto next six month give a list of month number and year number in two lists

    Map<int, List<int>> yearMonthMap = generateYearMonthMap();

    for (int i = -1; i <= 3; i++) {
      // Get the year and month from the map
      int year = yearMonthMap[i]![0];
      int month = yearMonthMap[i]![1];

      await fetchIslamicCalendar(year.toString(), month.toString())
          .then((islamicCalendar) {
        if (islamicCalendar != null) {
          // Fluttertoast.showToast(msg: 'here');
          // only add the  holidays to the appointments list
          for (var i = 0; i < islamicCalendar.data!.length; i++) {
            // if it contains holiday then add all the holiday to the list
            if (islamicCalendar.data?[i].hijri?.holidays?.length != 0) {
              for (var j = 0;
                  j < islamicCalendar.data![i].hijri!.holidays!.length;
                  j++) {
                String dateString =
                    islamicCalendar.data?[i].gregorian?.date ?? "21-07-1445";
                // Fluttertoast.showToast(msg: '$dateString');
                DateTime dateTime = convertStringToDateTime(dateString);
                events.add(Appointment(
                  id: i.toString() + j.toString(),
                  startTime: dateTime.add(Duration(days: 1)),
                  isAllDay: true,
                  endTime: dateTime.add(Duration(hours: 23)),
                  subject: islamicCalendar.data?[i].hijri?.holidays?[j] ?? '',
                  color: Theme.of(context).primaryColor,
                ));
              }
            }
          }
        }
      });
    }

    setState(() {
      _appointments = events;
      _isItLoading = false;
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
        title: const Text('ক্যালেন্ডার'),
        centerTitle: true,
      ),
      body: _isItLoading
          ? ProgressBar()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    child: SfCalendar(
                      view: CalendarView.month,
                      backgroundColor: Colors.white,
                      showNavigationArrow: true,
                      dataSource: AppointmentDataSource(_appointments),
                      // onViewChanged: (ViewChangedDetails details) {
                      //   year = details.visibleDates[0].year;
                      //   month = details.visibleDates[0].month + 1;

                      //   _loadAppointments(year.toString(), month.toString());
                      // },
                      onTap: (CalendarTapDetails details) {
                        setState(() {
                          dateSelected = details.date!;
                        });
                      },
                    ),
                  ),
                  Column(
                    children: _appointments
                        .where((element) =>
                            (element.startTime.day == dateSelected.day &&
                                element.startTime.month == dateSelected.month &&
                                element.startTime.year == dateSelected.year))
                        .map((e) {
                      return ListTile(
                        title: Text(e.subject,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        subtitle:
                            Text(DateFormat('dd/MM/yyyy').format(e.startTime),
                                style: TextStyle(
                                    // color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w400)),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

Future<IslamicCalendar?> fetchIslamicCalendar(String year, String month) async {
  try {
    // Initialize Dio
    final dio = Dio();

    // Define API endpoint
    String apiUrl = 'http://api.aladhan.com/v1/gToHCalendar/$month/$year';

    // Make API request
    final response = await dio.get(apiUrl);

    // Check if the response is successful
    if (response.statusCode == 200) {
      // Parse JSON response
      // final jsonData = json.decode(response.data);
      // print(jsonData);
      // Convert JSON data to IslamicCalendar object
      final IslamicCalendar islamicCalendar =
          IslamicCalendar.fromJson(response.data);
      return islamicCalendar;
    } else {
      // If the response is not successful, throw an error
      throw Exception('Failed to load data');
    }
  } catch (e) {
    // Handle errors
    Fluttertoast.showToast(msg: 'ডাটা লোড করা যাচ্ছে না');
    print(e.toString());
    return null;
  }
}

DateTime convertStringToDateTime(String dateString) {
  // Split the dateString into day, month, and year components
  List<String> components = dateString.split('-');

  // Extract day, month, and year
  int day = int.parse(components[0]);
  int month = int.parse(components[1]);
  int year = int.parse(components[2]);

  // Adjust year based on the Hijri year
  // Note: This is a simplified approach and may not be accurate in all cases
  // You might need a library or algorithm to accurately convert Hijri dates to Gregorian dates
  // This is just a demonstration of the conversion process
  // Adjust for Hijri to Gregorian year

  // Create DateTime object
  return DateTime(year, month, day);
}

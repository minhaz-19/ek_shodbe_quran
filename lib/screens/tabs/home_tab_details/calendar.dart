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
  bool _is_it_loading = false;
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

  @override
  void initState() {
    super.initState();
    _loadAppoinments();
  }

  void _loadAppoinments() async {
    setState(() {
      _is_it_loading = true;
    });
    // call the API and get the holidays and add them to the _appointments list
    List<Appointment> events = [];
    await fetchIslamicCalendar().then((islamicCalendar) {
      if (islamicCalendar != null) {
        // only add the  holidays to the appoinments list
        for (var i = 0; i < islamicCalendar.data!.length; i++) {
          // if it contains holiday then add all the holiday to the list
          if (islamicCalendar.data?[i].hijri?.holidays?.length != 0) {
            for (var j = 0;
                j < islamicCalendar.data![i].hijri!.holidays!.length;
                j++) {
              String dateString =
                  islamicCalendar.data?[i].gregorian?.date ?? "21-07-1445";
              DateTime dateTime = convertStringToDateTime(dateString);
              events.add(Appointment(
                id: i.toString() + j.toString(),
                startTime: dateTime,
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
    _appointments = events;
    setState(() {
      _is_it_loading = false;
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
      body: _is_it_loading
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

Future<IslamicCalendar?> fetchIslamicCalendar() async {
  try {
    // Initialize Dio
    final dio = Dio();

    String month = DateTime.now().month.toString();
    String year = DateTime.now().year.toString();

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

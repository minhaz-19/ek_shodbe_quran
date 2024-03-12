import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/model/calendarmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTab extends StatefulWidget {
  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool _isLoding = false;
  IslamicCalendar? islamicCalendar;

  @override
  void initState() {
    super.initState();
    kEvents.clear(); // initialize Kevents
    // initialize Kevents
    // _loadedMonths.add(DateFormat('yyyyMM').format(_focusedDay));
    _initializeCalendar();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  void _initializeCalendar() async {
    setState(() {
      _isLoding = true;
    });
    islamicCalendar = await fetchIslamicCalendar(
        _focusedDay.year.toString(), _focusedDay.month.toString());
    if (islamicCalendar != null) {
      for (var i = 0; i < islamicCalendar!.data!.length; i++) {
        if (islamicCalendar?.data?[i].hijri?.holidays?.isNotEmpty ?? false) {
          for (var j = 0;
              j < islamicCalendar!.data![i].hijri!.holidays!.length;
              j++) {
            String dateString =
                islamicCalendar!.data?[i].gregorian?.date ?? "21-07-1445";
            DateTime dateTime = convertStringToDateTime(dateString);
            if (kEvents[dateTime] == null) {
              kEvents[dateTime] = [];
            }
            if (islamicCalendar!.data![i].hijri!.holidays![j] != null) {
              kEvents[dateTime]!.add(
                Event(
                  islamicCalendar!.data![i].hijri!.holidays![j],
                ),
              );
            }
          }
        }
      }
    }
    setState(() {
      _isLoding = false;
    });
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
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
      body: _isLoding == true
          ? const ProgressBar()
          : SingleChildScrollView(
              child: Column(
                children: [
                  TableCalendar<Event>(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    calendarFormat: _calendarFormat,
                    rangeSelectionMode: _rangeSelectionMode,
                    eventLoader: _getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek.saturday,
                    calendarStyle: const CalendarStyle(
                      // Use `CalendarStyle` to customize the UI
                      outsideDaysVisible: false,
                    ),
                    onDaySelected: _onDaySelected,
                    rowHeight: 110,
                    calendarBuilders: CalendarBuilders(
                      selectedBuilder: (context, day, events) => Container(
                        // height: 200,
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day.day.toString(),
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            const Spacer(),
                            ('${islamicCalendar?.data?[(day.day - 1)].hijri?.day}' ==
                                        '30' &&
                                    '${islamicCalendar?.data?[(day.day - 2)].hijri?.day}' ==
                                        '28')
                                ? const Text('29',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white))
                                : Text(
                                    '${islamicCalendar?.data?[(day.day - 1)].hijri?.day}',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white)),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                '${islamicCalendar?.data?[(day.day - 1)].hijri?.month?.en}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 8, color: Colors.white)),
                            Text(
                              '${islamicCalendar?.data?[(day.day - 1)].hijri?.year}',
                              style: const TextStyle(
                                  fontSize: 8, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      todayBuilder: (context, day, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day.day.toString(),
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white),
                            ),
                            const Spacer(),
                            ('${islamicCalendar?.data?[(day.day - 1)].hijri?.day}' ==
                                        '30' &&
                                    '${islamicCalendar?.data?[(day.day - 2)].hijri?.day}' ==
                                        '28')
                                ? const Text('29',style: TextStyle(color:Colors.white),)
                                : Text(
                                    '${islamicCalendar?.data?[(day.day - 1)].hijri?.day}',style:const TextStyle(color:Colors.white),),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                '${islamicCalendar?.data?[(day.day - 1)].hijri?.month?.en}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 8, color: Colors.white)),
                            Text(
                              '${islamicCalendar?.data?[(day.day - 1)].hijri?.year}',
                              style: const TextStyle(fontSize: 8, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      defaultBuilder: (context, day, focusedDay) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day.day.toString(),
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context).primaryColor),
                            ),
                            const Spacer(),
                            ('${islamicCalendar?.data?[(day.day - 1)].hijri?.day}' ==
                                        '30' &&
                                    '${islamicCalendar?.data?[(day.day - 2)].hijri?.day}' ==
                                        '28')
                                ? const Text('29')
                                : Text(
                                    '${islamicCalendar?.data?[(day.day - 1)].hijri?.day}'),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                '${islamicCalendar?.data?[(day.day - 1)].hijri?.month?.en}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 8)),
                            Text(
                              '${islamicCalendar?.data?[(day.day - 1)].hijri?.year}',
                              style: const TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onRangeSelected: _onRangeSelected,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    // change event indicator dot position

                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;
                        kEvents.clear();
                        islamicCalendar = null;
                        _selectedDay = _focusedDay;
                        _rangeStart = null; // Important to clean those
                        _rangeEnd = null;
                      }); // initialize Kevents
                      // initialize Kevents
                      // _loadedMonths.add(DateFormat('yyyyMM').format(_focusedDay));
                      _initializeCalendar();
                      _selectedDay = _focusedDay;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              title: Text('${value[index]}'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
);

// final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
//   ..addAll({
//     kToday: [
//       Event('Today\'s Event 1'),
//       Event('Today\'s Event 2'),
//     ],
//   });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 5, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year + 5, kToday.month, kToday.day);

Future<IslamicCalendar?> fetchIslamicCalendar(String year, String month) async {
  try {
    // Initialize Dio
    final dio = Dio();

    // Define API endpoint
    String apiUrl = 'http://api.aladhan.com/v1/gToHCalendar/$month/$year';

    // Make API request
    final response = await dio.get(apiUrl, queryParameters: {
      "adjustment": -1,
    });

    // Check if the response is successful
    if (response.statusCode == 200) {
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
  return DateTime(year, month, day);
}

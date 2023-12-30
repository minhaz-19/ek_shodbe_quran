import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarTab extends StatefulWidget {
  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  late List<Appointment> _appointments = [];

  DateTime dateSelected = DateTime.now();

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
      body: Padding(
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

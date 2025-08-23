// import 'package:flutter/material.dart';
//
// class calender extends StatefulWidget {
//   const calender({super.key});
//
//   @override
//   State<calender> createState() => _calenderState();
// }
//
// class _calenderState extends State<calender> {
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         backgroundColor: Color(0xff05243E),
//         appBar: AppBar(
//           iconTheme: IconThemeData(
//             color: Colors.white,
//           ),
//           title: Center(
//               child: Text(
//             "Manage Your Time",
//             style: TextStyle(color: Colors.white),
//           )),
//           backgroundColor: Color(0xFF05243E),
//         ),
//         body: Center(
//           child: Padding(
//             padding: EdgeInsets.only(bottom: height * 0.2),
//             child: Container(
//               height: height * 0.6,
//               width: width* 0.9,
//               decoration: BoxDecoration(
//                 color: Color(0xffD9D9D9).withOpacity(0.3),
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 // gradient: LinearGradient(colors: [
//                 //   Color(0xffD9D9D9),
//                 //   // Color(0xffD9D9D9).withOpacity(0.1),
//                 //   //  Color(0xffD9D9D9).withOpacity(0.1),
//                 // ],
//                 //   begin: Alignment.topCenter,
//                 //   end: Alignment.bottomCenter,
//               ),
//               child: Column(
//
//               ),
//             ),
//           ),
//         )
//
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _tasks = {};

  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff05243E),
      appBar: AppBar(
        title: const Text(
          "Manage Your Time and date and time",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff05243E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(color: Colors.redAccent),
              defaultTextStyle: TextStyle(color: Colors.white),
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
              formatButtonVisible: false,
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.grey[300]),
              weekendStyle: TextStyle(color: Colors.redAccent),
            ),
          ),
          const SizedBox(height: 10),
          if (_selectedDay != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  hintText: 'Enter task for selected day',
                  hintStyle: TextStyle(color: Colors.white70),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      if (_taskController.text.trim().isNotEmpty) {
                        setState(() {
                          final taskDate = DateTime(
                            _selectedDay!.year,
                            _selectedDay!.month,
                            _selectedDay!.day,
                          );
                          _tasks.putIfAbsent(taskDate, () => []);
                          _tasks[taskDate]!.add(_taskController.text.trim());
                          _taskController.clear();
                        });
                      }
                    },
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: _tasks[_selectedDay] != null
                    ? _tasks[_selectedDay]!
                    .map((task) => ListTile(
                  title: Text(
                    task,
                    style: TextStyle(color: Colors.white),
                  ),
                ))
                    .toList()
                    : [Center(child: Text("No tasks", style: TextStyle(color: Colors.white54)))],
              ),
            ),
          ]
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:students_mate/utils/colors.dart';

class StudentAttendenceView extends StatefulWidget {
  const StudentAttendenceView({Key? key}) : super(key: key);

  @override
  _StudentAttendenceViewState createState() => _StudentAttendenceViewState();
}

class _StudentAttendenceViewState extends State<StudentAttendenceView> {
  String dropdownvalue = 'Sem 1';

  // List of items in our dropdown menu
  var items = [
    'Sem 1',
    'Sem 2',
    'Sem 3',
    'Sem 4',
    'Sem 5',
    'Sem 6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {},
        ),
        title: const Text("Attendance", style: TextStyle(color: Colors.green)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Select Semester :",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                width: 70,
              ),
              DropdownButton(
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 80,
          ),
          CircularPercentIndicator(
            radius: 90,
            lineWidth: 15,
            percent: 0.8,
            center: Text(
              "80%",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.green),
            ),
            animation: true,
            animationDuration: 1200,
            footer: Text(
              "Your Attendance Percentage",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            progressColor: Colors.green,
            circularStrokeCap: CircularStrokeCap.round,
          )
        ],
      ),
    );
  }
}

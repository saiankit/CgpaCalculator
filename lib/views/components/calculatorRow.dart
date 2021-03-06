import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/services/gradePointCalculator.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:CgpaCalculator/viewModels/courseInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorRow extends StatefulWidget {
  final String fuid;
  final BuildContext homeScreenContext;
  CalculatorRow({this.fuid, this.homeScreenContext});
  @override
  _CalculatorRowState createState() => _CalculatorRowState();
}

class _CalculatorRowState extends State<CalculatorRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text('SGPA', style: ThemeStyles.gpaTextStyle),
              ),
              StreamBuilder(
                stream: Provider.of<AppDatabase>(widget.homeScreenContext)
                    .watchCoursesBySemesterCode(
                        Provider.of<CourseInfoState>(widget.homeScreenContext)
                            .selectedSemester,
                        widget.fuid),
                builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child:
                          Text('0.00', style: ThemeStyles.gpaNumberTextStyle),
                    );
                  String sGPA = calculateGPA(snapshot);
                  return Text(sGPA, style: ThemeStyles.gpaNumberTextStyle);
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text('CGPA', style: ThemeStyles.gpaTextStyle),
              ),
              StreamBuilder(
                stream: Provider.of<AppDatabase>(widget.homeScreenContext)
                    .watchAllCourses(widget.fuid),
                builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child:
                          Text('0.00', style: ThemeStyles.gpaNumberTextStyle),
                    );
                  String sGPA = calculateCGPA(snapshot);
                  return Text(sGPA, style: ThemeStyles.gpaNumberTextStyle);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

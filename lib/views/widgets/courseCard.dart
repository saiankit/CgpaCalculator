import 'package:CgpaCalculator/services/openElectiveService.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:CgpaCalculator/viewModels/courseInfo.dart';
import 'package:CgpaCalculator/views/screens/courseUpdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatefulWidget {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final int courseCredits;
  final int gradeAchieved;
  final int documentID;
  final String semesterCode;
  final String userID;
  CourseCard({
    this.courseCode,
    this.courseCredits,
    this.gradeAchieved,
    this.courseID,
    this.courseTitle,
    this.documentID,
    this.semesterCode,
    this.userID,
  });
  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  mapGrades(String letterGrade) {
    int numericalGrade = 10;
    switch (letterGrade) {
      case "A":
        {
          numericalGrade = 10;
        }
        break;

      case "A-":
        {
          numericalGrade = 9;
        }
        break;
      case "B":
        {
          numericalGrade = 8;
        }
        break;
      case "B-":
        {
          numericalGrade = 7;
        }
        break;
      case "C":
        {
          numericalGrade = 6;
        }
        break;
      case "C-":
        {
          numericalGrade = 5;
        }
        break;
      case "D":
        {
          numericalGrade = 4;
        }
        break;
      case "E":
        {
          numericalGrade = 2;
        }
        break;
      case "CLR":
        {
          numericalGrade = 0;
        }
        break;

      default:
        {
          numericalGrade = 10;
        }
        break;
    }
    return numericalGrade;
  }

  mapToNumberGrades(int numericalGrade) {
    String letterGrade = "A";
    switch (numericalGrade) {
      case 10:
        {
          letterGrade = "A";
        }
        break;

      case 9:
        {
          letterGrade = "A-";
        }
        break;
      case 8:
        {
          letterGrade = "B";
        }
        break;
      case 7:
        {
          letterGrade = "B-";
        }
        break;
      case 6:
        {
          letterGrade = "C";
        }
        break;
      case 5:
        {
          letterGrade = "C-";
        }
        break;
      case 4:
        {
          letterGrade = "D";
        }
        break;
      case 2:
        {
          letterGrade = "E";
        }
        break;

      case 0:
        {
          letterGrade = "CLR";
        }
        break;

      default:
        {
          letterGrade = "A";
        }
        break;
    }
    return letterGrade;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseInfoState(),
      child: Consumer<CourseInfoState>(
        builder: (context, semState, _) => GestureDetector(
          onTap: () {
            HapticFeedback.mediumImpact();
            searchCourseTitle(widget.courseCode, widget.courseID);
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.60,
                decoration: ThemeStyles.modalBottomSheetDecoration,
                child: CourseUpdate(
                  courseCode: widget.courseCode,
                  courseGrade: widget.gradeAchieved,
                  courseID: widget.courseID,
                  courseTitle: widget.courseTitle,
                  courseCredits: widget.courseCredits,
                  documentID: widget.documentID,
                  semesterCode: widget.semesterCode,
                  userID: widget.userID,
                ),
              ),
            );
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: Container(
              height: 60.0,
              decoration: ThemeStyles.courseCardDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: ThemeStyles.courseCardCourseInfo,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.courseCode,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          widget.courseID,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(left: 10.0),
                      scrollDirection: Axis.horizontal,
                      child: Text(widget.courseTitle,
                          style: ThemeStyles.titleTextStyle),
                    ),
                  ),
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: ThemeStyles.courseCardGradeInfo,
                    child: Center(
                      child: Text(
                        mapToNumberGrades(widget.gradeAchieved),
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CourseCardUI extends StatefulWidget {
  final DummyCourseModel course;

  const CourseCardUI({Key key, this.course}) : super(key: key);

  @override
  _CourseCardUIState createState() => _CourseCardUIState();
}

class _CourseCardUIState extends State<CourseCardUI> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseInfoState(),
      child: Consumer<CourseInfoState>(
        builder: (context, semState, _) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Container(
            height: 60.0,
            decoration: ThemeStyles.courseCardDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: ThemeStyles.courseCardCourseInfo,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.course.courseCode,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        widget.course.courseID,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 10.0),
                    scrollDirection: Axis.horizontal,
                    child: Text(widget.course.courseTitle,
                        style: ThemeStyles.titleTextStyle),
                  ),
                ),
                Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: ThemeStyles.courseCardGradeInfo,
                  child: Center(
                    child: Text(
                      widget.course.courseCredits,
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

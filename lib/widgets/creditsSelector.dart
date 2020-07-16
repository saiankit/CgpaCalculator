import 'package:CgpaCalculator/services/courseInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CreditSelector extends StatefulWidget {
  int chosenCredits;
  CreditSelector(this.chosenCredits);
  @override
  _CreditSelectorState createState() => _CreditSelectorState();
}

class _CreditSelectorState extends State<CreditSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Credits',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 20),
          Container(
            height: 60.0,
            width: 65.0,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: DropdownButton<int>(
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                  underline: Container(),
                  value: widget.chosenCredits.toInt(),
                  items: [1, 2, 3, 4, 5].map<DropdownMenuItem<int>>(
                    (int value) {
                      return DropdownMenuItem(
                        value: value.toInt(),
                        child: Text(value.toString()),
                      );
                    },
                  ).toList(),
                  onChanged: (int value) {
                    setState(
                      () {
                        widget.chosenCredits = value;
                      },
                    );
                    Provider.of<CourseInfoState>(context, listen: false)
                        .changeCredits(value);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

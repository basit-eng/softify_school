import 'package:flutter/material.dart';
import 'package:softify/views/customWidget/CustomAppBar.dart';

class RountineClassScreen extends StatelessWidget {
  RountineClassScreen({Key key}) : super(key: key);

  static const routeName = '/routineClass-screen';

  List days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontWeight: FontWeight.w700);
    return Scaffold(
      appBar: CustomAppBar(
          title: Text(
        "Time Table",
        style: Theme.of(context).appBarTheme.textTheme.headline6,
      )),
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: days.length,
          itemBuilder: (context, index) {
            return Card(
              child: ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(days[index], style: style),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 08, left: 16.0, right: 16, bottom: 08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text("Time", style: style),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text("Subject", style: style),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text("Room", style: style),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text("Teacher Name", style: style),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

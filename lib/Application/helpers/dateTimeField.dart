import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFieldCustom extends StatelessWidget {
  // time formater
  final timeFormat = DateFormat("hh:mm a");
  // pass controller
  final timeController;
  // constractor
  DateTimeFieldCustom({Key key, this.timeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      style: Theme.of(context).textTheme.bodyText1,
      format: timeFormat,
      controller: timeController,
      onShowPicker: (context, currentValue) async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Color(0xffB454E7),
                  onPrimary: Color(0xff131313),
                  surface: Color(0xff131313),
                  onSurface: Colors.white,
                  //Color(0xffB454E7)
                ),
                dialogBackgroundColor: Color(0xff131313),
              ),
              child: child,
            );
          },
        );
        return DateTimeField.convert(time);
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.white70,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: "Pick Visited Time",
        labelStyle: Theme.of(context).textTheme.bodyText2,
        suffixIcon: Icon(
          Icons.access_time,
          color: Colors.white54,
        ),
      ),
    );
  }
}

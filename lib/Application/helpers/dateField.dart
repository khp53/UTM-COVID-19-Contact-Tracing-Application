import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFieldCustom extends StatelessWidget {
  // date formater
  final dateFormat = DateFormat("dd-MM-yyyy");
  // pass controller
  final dateController;
  // pass lable text
  final String lableText;
  // constractor
  DateFieldCustom({Key key, this.dateController, this.lableText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      style: Theme.of(context).textTheme.bodyText1,
      format: dateFormat,
      controller: dateController,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          context: context,
          firstDate: DateTime(2019),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2025),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Color(0xffB454E7),
                  onPrimary: Colors.white,
                  surface: Color(0xffB454E7),
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: Color(0xff131313),
              ),
              child: child,
            );
          },
        );
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
          labelText: lableText,
          labelStyle: Theme.of(context).textTheme.bodyText2,
          suffixIcon: Icon(
            Icons.date_range,
            color: Colors.white54,
          )),
    );
  }
}

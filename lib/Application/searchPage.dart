import 'package:flutter/material.dart';
import 'package:utmccta/BLL/utmHealthAuthorityHandler.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _search = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  UTMHealthAuthorityHandler _healthAuthorityHandler =
      UTMHealthAuthorityHandler();

  initiateSearch() async {
    if (_search.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      _healthAuthorityHandler.getUserDetails(_search.text);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                'Search For a User By Their Matric Number\nTo Change Their COVID Status',
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.headline2,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(flex: 5, child: buildTextFormField(context)),
                  Expanded(flex: 1, child: buildMaterialButton(context))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              _healthAuthorityHandler.getUserDetails(_search.text),
            ],
          ),
        ),
      ),
    );
  }

  Container buildMaterialButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: MaterialButton(
        elevation: 0,
        onPressed: () => initiateSearch(),
        color: Theme.of(context).accentColor,
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SEARCH',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: 8),
            Icon(
              Icons.search,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField(BuildContext context) {
    return TextFormField(
      onEditingComplete: () => initiateSearch(),
      textInputAction: TextInputAction.search,
      validator: (val) {
        return val.length > 6 ? null : "Password should be 6+ chars";
      },
      controller: _search,
      style: Theme.of(context).primaryTextTheme.bodyText1,
      decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black54,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.black54,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          labelText: "Search For a User",
          labelStyle: Theme.of(context).primaryTextTheme.bodyText2),
    );
  }
}

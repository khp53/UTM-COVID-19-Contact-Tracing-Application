import 'package:flutter/material.dart';
import 'package:utmccta/BLL/utmHealthAuthorityHandler.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
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
      await _healthAuthorityHandler.searchUsersBasedOnRegID(_search.text);
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
                'Search For a User\'s Contacted Persons List By Their Registration ID\nFound In The App',
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
              _healthAuthorityHandler.showContactList(context)
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
        color: Theme.of(context).primaryColorDark,
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
          labelText: "Enter Registration ID",
          labelStyle: Theme.of(context).primaryTextTheme.bodyText2),
    );
  }
}

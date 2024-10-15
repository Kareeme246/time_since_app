// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_since_app/app_theme.dart';
import 'package:time_since_app/components/enchanced_list_view.dart';
import 'package:time_since_app/components/service_and_privacy.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<String> goalOptions = [
    'Diet',
    'Sober',
    'Cigarettes',
    'Alcohol',
    'Sugar',
    'Caffeine',
    'Social Media',
    'Video Games',
    'Gambling',
    'Junk Food',
    'Shopping',
    'TV/Streaming',
    'Phone Usage',
    'Drugs',
    'Exercise',
    'Procrastination',
    'Negative Thinking',
    'Workaholism',
    'Pornography',
    'Sleeping Pills',
    'Overeating',
    'Energy Drinks',
    'Fast Food',
    'Self-Harm',
  ];
  final List<String> sexOptions = ['Male', 'Female'];
  bool _isLoading = true;
  // Do name and email address later as they may be slightly more complicated with text-controllers
  late String _currentName = "";
  late String _currentEmail = "";
  late String _currentGoal = "Not chosen";
  late String _currentSex = "Not chosen";
  late DateTime _currentStartDate = DateTime.now();

  @override
  void initState() {
    // Initialize your variables here
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose your variables here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            color: AppTheme.darkGrey,
            child: SafeArea(
              child: Center(
                  child: CircularProgressIndicator(
                color: AppTheme.green,
              )),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: AppTheme.darkGrey,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                // Pass the updated values back to homepage to avoid complex state management
                                Navigator.pop(context, {
                                  'name': _currentName,
                                  'startDate': _currentStartDate,
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      color: AppTheme.green,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            child: Text(
                              'Settings',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppTheme.white1,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  // Text
                  textTitleRow('Name'),
                  // Input text area
                  settingsTextField('Enter your name', 'name'),

                  // Text
                  textTitleRow('Email Address'),
                  // Input text area
                  settingsTextField('Enter your email address', 'email'),

                  // Text
                  textTitleRow('Goal'),
                  // Select goal custom picker
                  textTitleRow3(
                      _currentGoal,
                      context,
                      () => customScaffold(
                          'Goal',
                          context,
                          selectionList(
                              Key("goal_list"), context, goalOptions, "goal"))),

                  // Text
                  textTitleRow('Sex'),
                  // Select Sex custom picker
                  textTitleRow3(
                      _currentSex,
                      context,
                      () => customScaffold(
                          'Sex',
                          context,
                          selectionList(
                              Key("sex_list"), context, sexOptions, "sex"))),

                  // Text
                  textTitleRow('Start Date'),
                  // Select Start Date apple picker
                  textTitleRow4(formatDate(_currentStartDate), context),
                  //Small sized box(gap)
                  SizedBox(height: 20.0),

                  // Terms of service
                  textTitleRow2(
                      'Terms of Service',
                      context,
                      () => customScaffold('App Terms of service', context,
                          termsOfServiceContent())),

                  // Privacy policy
                  textTitleRow2(
                      'Privacy Policy',
                      context,
                      () => customScaffold('App Privacy Policy', context,
                          privacyPolicyContent())),
                ],
              ),
            ));
  }

  void _handleNameUpdate(String selectedName) async {
    setState(() {
      _currentName = selectedName;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", _currentName);
  }

  void _handleEmailUpdate(String selectedEmail) async {
    setState(() {
      _currentEmail = selectedEmail;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", _currentEmail);
  }

  void _handleGoalUpdate(String selectedGoal) async {
    setState(() {
      _currentGoal = selectedGoal;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("goal", _currentGoal);
  }

  void _handleSexUpdate(String selectedSex) async {
    setState(() {
      _currentSex = selectedSex;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("sex", _currentSex);
  }

  void _handleDateUpdate(DateTime selectedDate) async {
    setState(() {
      _currentStartDate = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, selectedDate.hour, selectedDate.minute);
    });
    final SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Not ideal to call on each date change, but ¯\_(ツ)_/¯
    prefs.setInt("date", _currentStartDate.millisecondsSinceEpoch);
  }

  void _loadData() async {
    // Load and obtain the shared preferences for this app.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _currentGoal = prefs.getString("goal") ?? "Not chosen";
      _currentSex = prefs.getString("sex") ?? "Not chosen";
      _currentStartDate = DateTime.fromMillisecondsSinceEpoch(
          prefs.getInt("date") ?? DateTime.now().millisecondsSinceEpoch);
      _currentName = prefs.getString("name") ?? "";
      _currentEmail = prefs.getString("email") ?? "";
      _isLoading = false;
    });
  }

Widget selectionList(Key listKey, BuildContext context, List<String> dataList, String changeVar) {
  return EnhancedListView(
    listKey: listKey,
    dataList: dataList,
    changeVar: changeVar,
    onItemTap: (item) {
      switch (changeVar) {
        case "goal":
          _handleGoalUpdate(item);
          Navigator.pop(context);
          break;
        case "sex":
          _handleSexUpdate(item);
          Navigator.pop(context);
          break;
      }
    },
  );
}


  // Function to show the date picker
  Future<void> _showDatePicker(BuildContext context) async {
    showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        child: Container(
          color: AppTheme.white1,
          height: MediaQuery.of(context).size.height *
              0.45, // Add minimum height via BoxConstraints maybe
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: _currentStartDate,
            onDateTimeChanged: (DateTime newDate) {
              _handleDateUpdate(newDate);
            },
            maximumDate: DateTime.now(),
            use24hFormat: false,
            minuteInterval: 1,
          ),
        ),
      ),
    );
  }

  Padding settingsTextField(String insideText, String fieldVar) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        onSubmitted: (value) {
          switch (fieldVar) {
            case "name":
              _handleNameUpdate(value);
              break;
            case "email":
              _handleEmailUpdate(value);
              break;
            default:
          }
        },
        cursorColor: Colors.black,
        style: TextStyle(color: AppTheme.white1),
        decoration: InputDecoration(
          fillColor: AppTheme.darkGrey,
          filled: true,
          labelText: (() {
            switch (fieldVar) {
              case "name":
                return _currentName.isNotEmpty ? _currentName : insideText;
              case "email":
                return _currentEmail.isNotEmpty ? _currentEmail : insideText;
            }
          })(),
          labelStyle: TextStyle(color: AppTheme.white1),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }

// Function to format the date
  String formatDate(DateTime date) {
    String formattedDate = DateFormat('MMMM d,').format(date);
    String formattedTime = DateFormat('yyyy').format(date);
    String formattedHour = DateFormat('jm').format(date);

    return "$formattedDate $formattedTime at $formattedHour";
  }

  Row textTitleRow(String titleString) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          child: Text(titleString,
              style: TextStyle(
                  color: AppTheme.white1,
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }

  InkWell textTitleRow2(
      String titleString, BuildContext context, Widget Function() pageBuilder) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => pageBuilder()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
            child: Text(titleString,
                style: TextStyle(
                    color: AppTheme.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    );
  }

  InkWell textTitleRow3(
      String titleString, BuildContext context, Widget Function() pageBuilder) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => pageBuilder()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(titleString,
                style: TextStyle(
                    color: AppTheme.white1,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  InkWell textTitleRow4(String titleString, BuildContext context) {
    return InkWell(
      onTap: () {
        _showDatePicker(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(titleString,
                style: TextStyle(
                    color: AppTheme.white1,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

Widget customScaffold(
  String pageName,
  BuildContext context,
  Widget pageContent,
) {
  return Scaffold(
    backgroundColor: AppTheme.darkGrey,
    appBar: AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_left,
            color: AppTheme.white1,
            size: 35,
          ),
          onPressed: Navigator.of(context).pop),
      backgroundColor: Colors.transparent,
      title: Text(
        pageName,
        style: TextStyle(
            color: AppTheme.white1, fontSize: 22, fontWeight: FontWeight.w500),
      ),
    ),
    body: pageContent,
  );
}

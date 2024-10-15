// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_since_app/app_theme.dart';
import 'package:time_since_app/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variables go here
  final List<Quote> quotes = [
    Quote(
        "The only limit to our realization of tomorrow is our doubts of today.",
        "Franklin D. Roosevelt"),
    Quote(
        "Success is not final, failure is not fatal: It is the courage to continue that counts.",
        "Winston Churchill"),
    Quote(
        "In the end, we will remember not the words of our enemies, but the silence of our friends.",
        "Martin Luther King Jr."),
    Quote("The best way to predict your future is to create it.",
        "Abraham Lincoln"),
    Quote("Life is what happens when you're busy making other plans.",
        "John Lennon"),
    Quote(
        "It is our choices that show what we truly are, far more than our abilities.",
        "J.K. Rowling"),
    Quote("You miss 100% of the shots you don't take.", "Wayne Gretzky"),
    Quote(
        "Do not go where the path may lead, go instead where there is no path and leave a trail.",
        "Ralph Waldo Emerson"),
    Quote("I have not failed. I've just found 10,000 ways that won't work.",
        "Thomas Edison"),
    Quote("It does not matter how slowly you go as long as you do not stop.",
        "Unknown"),
    Quote(
        "The greatest glory in living lies not in never falling, but in rising every time we fall.",
        "Nelson Mandela"),
    Quote("Your time is limited, don't waste it living someone else's life.",
        "Steve Jobs"),
    Quote("The way to get started is to quit talking and begin doing.",
        "Walt Disney"),
    Quote(
        "Don't watch the clock; do what it does. Keep going.", "Sam Levenson"),
    Quote(
        "Keep your face always toward the sunshine—and shadows will fall behind you.",
        "Walt Whitman"),
    Quote("Opportunities don't happen, you create them.", "Chris Grosser"),
    Quote("Whether you think you can or you think you can't, you're right.",
        "Henry Ford"),
    Quote(
        "You will face many defeats in life, but never let yourself be defeated.",
        "Maya Angelou"),
    Quote("Life is what happens when you're busy making other plans.",
        "John Lennon"),
    Quote("Don't let yesterday take up too much of today.", "Will Rogers"),
    Quote("It always seems impossible until it's done.", "Nelson Mandela"),
    Quote("Believe you can and you're halfway there.", "Theodore Roosevelt"),
    Quote(
        "The only way to do great work is to love what you do.", "Steve Jobs"),
    Quote("Your time is limited, so don't waste it living someone else's life.",
        "Steve Jobs"),
    Quote("Everything you’ve ever wanted is on the other side of fear.",
        "George Addair"),
    Quote("Success is how high you bounce when you hit bottom.",
        "George S. Patton"),
    Quote(
        "If you are not willing to risk the usual, you will have to settle for the ordinary.",
        "Jim Rohn"),
    Quote(
        "The only place where success comes before work is in the dictionary.",
        "Vidal Sassoon"),
    Quote("Try not to become a man of success. Rather become a man of value.",
        "Albert Einstein"),
    Quote("Don't be afraid to give up the good to go for the great.",
        "John D. Rockefeller"),
    Quote(
        "Failure will never overtake me if my determination to succeed is strong enough.",
        "Og Mandino"),
    Quote(
        "What lies behind us and what lies before us are tiny matters compared to what lies within us.",
        "Ralph Waldo Emerson"),
    Quote("The only thing we have to fear is fear itself.",
        "Franklin D. Roosevelt"),
    Quote("I attribute my success to this: I never gave or took any excuse.",
        "Florence Nightingale"),
    Quote("Doubt kills more dreams than failure ever will.", "Suzy Kassem"),
    Quote(
        "I can’t change the direction of the wind, but I can adjust my sails to always reach my destination.",
        "Jimmy Dean"),
    Quote(
        "The future belongs to those who believe in the beauty of their dreams.",
        "Eleanor Roosevelt"),
    Quote("It’s not whether you get knocked down, it’s whether you get up.",
        "Vince Lombardi"),
    Quote(
        "Hardships often prepare ordinary people for an extraordinary destiny.",
        "C.S. Lewis"),
    Quote(
        "Success usually comes to those who are too busy to be looking for it.",
        "Henry David Thoreau"),
    Quote(
        "The only person you are destined to become is the person you decide to be.",
        "Ralph Waldo Emerson"),
    Quote("The greatest wealth is to live content with little.", "Plato"),
  ];
  late Quote _currentSelectedQuote = Quote("", "");
  Timer? _timer;
  int? lastSampledIndex;

  late String _name = "";
  late DateTime _startDate = DateTime.now();

  Quote getRandomQuoteWithoutRepeats() {
    final random = Random();
    int index;

    do {
      index = random.nextInt(quotes.length);
    } while (index == lastSampledIndex);

    lastSampledIndex = index;
    return quotes[index];
  }

  @override
  void initState() {
    super.initState();
    _loadData();

    // Fetch the first quote immediately
    _currentSelectedQuote = getRandomQuoteWithoutRepeats();
    _timer = Timer.periodic(Duration(hours: 6), (Timer t) {
      setState(() {
        _currentSelectedQuote = getRandomQuoteWithoutRepeats();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: IconButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  CupertinoPageRoute(
                    barrierDismissible: true,
                    fullscreenDialog: true,
                    builder: (context) {
                      return Scaffold(
                        body: SettingsPage(),
                      );
                    },
                  ),
                );

                if (result != null) {
                  setState(() {
                    _name = result['name'] ?? _name;
                    _startDate = result['startDate'] ?? _startDate;
                  });
                }
              },
              icon: Image.asset(
                'assets/settings-gears.png',
                color: AppTheme.white2,
                width: 24,
                height: 24,
              ),
            ),
          )
        ],
      ),
      Column(
        children: [
          SizedBox(height: 10),
          Text(
            _name.isNotEmpty ? 'Hello, $_name' : 'Hello',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.white1),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .20),
          Column(
            children: [
              Text(
                'It has been',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.white1),
              ),
              SizedBox(height: 8),
              Text(
                // Add ability to see hours, seconds, etc... later
                "${DateTime.now().difference(_startDate).inDays}",
                style: TextStyle(
                    color: AppTheme.white1,
                    fontSize: 85,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              Text(
                'Days',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.white1),
              ),
              SizedBox(height: 8),
              OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.transparent),
                    side: WidgetStateProperty.all<BorderSide>(BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.black,
                        width: 0.5)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                  ),
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text('Reset Counter'),
                          content: Text('Are you sure you want to reset?'),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text('Yes'),
                              onPressed: () {
                                _resetDate();
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Restart',
                    style: TextStyle(color: AppTheme.white1),
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * .10),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Text(
                    _currentSelectedQuote.text,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.white1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Text(
                '- ${_currentSelectedQuote.author}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.white1),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .08),
              Text(
                'Share with friends',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.white1),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              IconButton(
                  onPressed: () {
                    final difference = DateTime.now().difference(_startDate);
                    Share.share(
                        'It has been ${difference.inDays} days, ${difference.inHours % 24} hours, ${difference.inMinutes % 60} minutes, and ${difference.inSeconds % 60} seconds since I have ___',
                        subject: 'Current Streak');
                  },
                  icon: Icon(
                    Icons.ios_share,
                    color: AppTheme.white1,
                  )),
            ],
          ),
        ],
      )
    ]);
  }

  void _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString("name") ?? "";
      _startDate = DateTime.fromMillisecondsSinceEpoch(
          prefs.getInt("date") ?? DateTime.now().millisecondsSinceEpoch);
    });
  }

  void _resetDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _startDate = DateTime.now();
    });
    prefs.setInt("date", _startDate.millisecondsSinceEpoch);
  }
}

class Quote {
  final String text;
  final String author;

  Quote(this.text, this.author);
}

class AnimatedRoute extends PageRouteBuilder {
  final Widget widget;

  AnimatedRoute(this.widget)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            // var tween = Tween(begin: begin, end: end);
            const curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}

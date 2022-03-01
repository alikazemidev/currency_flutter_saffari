import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa', ''), // farsi
      ],
      theme: ThemeData(
        fontFamily: 'vazir',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'vazir',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontFamily: 'vazir',
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          bodyText1: TextStyle(
            fontFamily: 'vazir',
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Image.asset('assets/images/icon.png'),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'قیمت به روز ارز',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/images/menu.png'),
            ),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/q.png'),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'نرخ ارز آزاد چیست؟ ',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              ' نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.',
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Container(
              height: 35,
              width: double.infinity,
              margin: EdgeInsets.only(top: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color.fromARGB(255, 130, 130, 130),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'نام ارز',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      'قیمت',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      'تغییر',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 400,
              // color: Colors.blue,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListItem();
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 9 == 0) {
                    return AdItem();
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 12,
              ),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 202, 193, 255),
                  ),
                ),
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.refresh_bold,
                  color: Colors.black,
                ),
                label: Text(
                  'بروزرسانی',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1.0,
              color: Colors.grey,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'دلار',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              '26.000',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              '+3%',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}

class AdItem extends StatelessWidget {
  const AdItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              blurRadius: 1.0,
              color: Colors.grey,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'تبلیغات',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:currency/model/currency.dart';
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
  final apiUrl =
      'http://sasansafari.com/flutter/api.php?access_key=flutter123456';
  final List<Currency> myCurrencyList = [
    Currency(
      id: DateTime.now().toString(),
      title: 'dollar',
      price: '20000',
      change: '+3%',
      status: 'p',
    ),
    Currency(
      id: DateTime.now().toString(),
      title: 'rial',
      price: '600',
      change: '-5%',
      status: 'n',
    ),
  ];



  String _getTime() {
    return '20:46';
  }

// show snackbar function
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.headline1!.copyWith(
                color: Colors.white,
              ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

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
            //* list view
            SizedBox(
              width: double.infinity,
              height: 400,
              // color: Colors.blue,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: myCurrencyList.length,
                itemBuilder: (context, index) {
                  return ListItem(
                    title: myCurrencyList[index].title,
                    price: myCurrencyList[index].price,
                    change: myCurrencyList[index].change,
                  );
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
            //* update button box
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //* update btn
                  SizedBox(
                    height: 50,
                    child: TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 202, 193, 255),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        ),
                      ),
                      onPressed: () => showSnackBar(
                        context,
                        'بروزرسانی با موفقیت انجام شد',
                      ),
                      icon: Icon(
                        CupertinoIcons.refresh_bold,
                        color: Colors.black,
                      ),
                      label: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'بروزرسانی',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                  ),
                  //  update time
                  Text('آخرین بروزرسانی  ${_getTime()}'),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String? title;
  final String? price;
  final String? change;
  ListItem({this.title, this.price, this.change});
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
              title!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              price!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              change!,
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

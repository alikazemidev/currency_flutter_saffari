import 'dart:convert';
import 'package:currency/model/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

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
          headline3: TextStyle(
            fontFamily: 'vazir',
            color: Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          headline4: TextStyle(
            fontFamily: 'vazir',
            color: Colors.green,
            fontSize: 14,
            fontWeight: FontWeight.w700,
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

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isloading = false;
  final List<Currency> myCurrencyList = [];

  Future getResponse(BuildContext ctx) async {
    Uri apiUrl = Uri.parse(
        'http://sasansafari.com/flutter/api.php?access_key=flutter123456');

    var respone = await http.get(apiUrl);

    if (myCurrencyList.isEmpty) {
      if (respone.statusCode == 200) {
        setState(() {
          _isloading = false;
        });

        showSnackBar(context, 'به روز رسانی با موفقیت انجام شد');

        List jsonList = jsonDecode(respone.body);
        if (jsonList.length > 0) {
          for (var i = 0; i < jsonList.length; i++) {
            setState(() {
              myCurrencyList.add(
                Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  price: jsonList[i]["price"],
                  changes: jsonList[i]["changes"],
                  status: jsonList[i]["status"],
                ),
              );
            });
          }
        }
      }
    }

    developer.log(respone.statusCode.toString(), name: 'response');
    return respone;
  }

  String _getTime() {
    return DateFormat('hh:mm:ss').format(DateTime.now());
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
  void initState() {
    super.initState();
    getResponse(context);
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
          // IconButton(onPressed: (){}, icon: Icon(Icons.dark_mode,color: Colors.black,)),
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
              // textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            // * table title
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
              height: MediaQuery.of(context).size.height / 2,
              // color: Colors.blue,
              child: listFutureBuilder(context),
            ),
            //* update button box
            Container(
              margin: EdgeInsets.only(
                top: 12,
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 16,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //* update btn
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 16,
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
                      onPressed: () {
                        setState(() {
                          _isloading = true;
                        });
                        myCurrencyList.clear();
                        listFutureBuilder(context);
                      },
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
                  SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<dynamic> listFutureBuilder(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return !_isloading
            ? (snapshot.hasData
                ? ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: myCurrencyList.length,
                    itemBuilder: (context, index) {
                      return ListItem(
                        title: myCurrencyList[index].title,
                        price: myCurrencyList[index].price,
                        change: myCurrencyList[index].changes,
                        currencyList: myCurrencyList,
                        position: index,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      if (index % 9 == 0) {
                        return AdItem();
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ))
            : Center(
                child: CircularProgressIndicator(),
              );
      },
      future: getResponse(context),
    );
  }
}

class ListItem extends StatelessWidget {
  final String? title;
  final String? price;
  final String? change;
  final List<Currency>? currencyList;
  final int? position;
  ListItem({
    this.title,
    this.price,
    this.change,
    this.currencyList,
    this.position,
  });
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
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  getFarsiNumber(price!),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  getFarsiNumber(change.toString()),
                  style: currencyList![position!].status == "n"
                      ? Theme.of(context).textTheme.headline3
                      : Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
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

String getFarsiNumber(String number) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  english.forEach((item) {
    number = number.replaceAll(item, farsi[english.indexOf(item)]);
  });

  return number;
}

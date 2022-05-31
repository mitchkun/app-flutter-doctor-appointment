import 'package:doctor_app/config/apps/food_delivery/constant.dart';
import 'package:doctor_app/config/apps/food_delivery/global_style.dart';
import 'package:doctor_app/constant/constant.dart';
import 'package:doctor_app/pages/home.dart';
import 'package:doctor_app/ui/apps/food_delivery/cart.dart';
import 'package:doctor_app/ui/apps/food_delivery/coupon.dart';
import 'package:doctor_app/model/apps/food_delivery/food_model.dart';
import 'package:doctor_app/ui/apps/food_delivery/restaurant_information.dart';
import 'package:doctor_app/ui/apps/food_delivery/reusable_widget.dart';
import 'package:doctor_app/ui/reusable/cache_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizontal_calendar_widget/date_helper.dart';
import 'package:horizontal_calendar_widget/date_widget.dart';
import 'package:horizontal_calendar_widget/horizontal_calendar.dart';

class DetailRestaurantPage extends StatefulWidget {
  @override
  _DetailRestaurantPageState createState() => _DetailRestaurantPageState();
}

const labelMonth = 'Month';
const labelDate = 'Date';
const labelWeekDay = 'Week Day';

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  DateTime? firstDate;
  DateTime? lastDate;
  String dateFormat = 'dd';
  String monthFormat = 'MMM';
  String weekDayFormat = 'EEE';
  Color bgcolor = Color(0xfff2b036);
  List<String> order = [labelMonth, labelDate, labelWeekDay];
  bool forceRender = false;
  String? selectedDate;
  String? monthString;
  Color defaultDecorationColor = Colors.transparent;
  BoxShape defaultDecorationShape = BoxShape.circle;
  bool isCircularRadiusDefault = true;
  String selectedTime = '';
  Color selectedDecorationColor = Color(0xfff2b036);
  BoxShape selectedDecorationShape = BoxShape.circle;
  bool isCircularRadiusSelected = true;

  Color disabledDecorationColor = Colors.grey;
  BoxShape disabledDecorationShape = BoxShape.circle;
  bool isCircularRadiusDisabled = true;

  int minSelectedDateCount = 1;
  int maxSelectedDateCount = 1;
  RangeValues? selectedDateCount;

  List<DateTime>? initialSelectedDates;
  // initialize reusable widget
  final _reusableWidget = ReusableWidget();

  bool _showAppBar = false;

  late ScrollController _scrollController;

  List<FoodModel> _foodData = [];

  @override
  void initState() {
    super.initState();
    setupAnimateAppbar();
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _getData();
    const int days = 30;
    firstDate = toDateMonthYear(DateTime.now());
    lastDate = toDateMonthYear(firstDate!.add(Duration(days: days - 1)));
    selectedDateCount = RangeValues(
      minSelectedDateCount.toDouble(),
      maxSelectedDateCount.toDouble(),
    );
    initialSelectedDates = feedInitialSelectedDates(minSelectedDateCount, days);
    setState(() {
      selectedDate =
          '${firstDate!.day}-${convertNumberMonthToStringMonth(firstDate!.month)}';
    });
  }

  List<DateTime> feedInitialSelectedDates(int target, int calendarDays) {
    List<DateTime> selectedDates = [];

    for (int i = 0; i < calendarDays; i++) {
      if (selectedDates.length == target) {
        break;
      }
      DateTime date = firstDate!.add(Duration(days: i));
      if (date.weekday != DateTime.sunday) {
        selectedDates.add(date);
      }
    }

    return selectedDates;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void setupAnimateAppbar() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.hasClients &&
            _scrollController.offset >
                (MediaQuery.of(context).size.width * 3 / 4) - 80) {
          setState(() {
            _showAppBar = true;
          });
        } else {
          setState(() {
            _showAppBar = false;
          });
        }
      });
  }

  void _getData() {
    /*
    Image Information
    width = 800px
    height = 600px
    ratio width height = 4:3
     */
    _foodData = [
      FoodModel(
          id: 8,
          restaurantName: "Chicken Specialties",
          name: "Chicken Rice Teriyaki",
          image: GLOBAL_URL + "/assets/images/apps/food_delivery/food/8.jpg",
          price: 5,
          discount: 10,
          rating: 4.7,
          distance: 3.9,
          location: "Liberty Avenue"),
      FoodModel(
          id: 6,
          restaurantName: "Bread and Cookies",
          name: "Delicious Croissant",
          image: GLOBAL_URL + "/assets/images/apps/food_delivery/food/6.jpg",
          price: 5,
          discount: 0,
          rating: 4.8,
          distance: 0.9,
          location: "Mapple Street"),
      FoodModel(
          id: 7,
          restaurantName: "Taco Salad Beef Classic",
          name: "Awesome Health",
          image: GLOBAL_URL + "/assets/images/apps/food_delivery/food/7.jpg",
          price: 4.9,
          discount: 10,
          rating: 4.9,
          distance: 1.1,
          location: "Fenimore Street"),
      FoodModel(
          id: 5,
          restaurantName: "Italian Food",
          name: "Chicken Penne With Tomato",
          image: GLOBAL_URL + "/assets/images/apps/food_delivery/food/5.jpg",
          price: 6.5,
          discount: 20,
          rating: 4.6,
          distance: 0.9,
          location: "New York Avenue"),
      FoodModel(
          id: 4,
          restaurantName: "Steam Boat Lovers",
          name: "Seafood shabu-shabu",
          image: GLOBAL_URL + "/assets/images/apps/food_delivery/food/4.jpg",
          price: 6,
          discount: 20,
          rating: 4.9,
          distance: 0.7,
          location: "Lefferts Avenue"),
      FoodModel(
          id: 3,
          restaurantName: "Salad Stop",
          name: "Sesame Salad",
          image: GLOBAL_URL + "/assets/images/apps/food_delivery/food/3.jpg",
          price: 4.8,
          discount: 10,
          rating: 4.3,
          distance: 0.7,
          location: "Empire Boulevard"),
      FoodModel(
          id: 2,
          restaurantName: "Beef Lovers",
          name: "Beef Yakiniku",
          image: GLOBAL_URL + "/assets/images/apps/food_delivery/food/2.jpg",
          price: 3.6,
          discount: 20,
          rating: 5,
          distance: 0.6,
          location: "Montgomery Street"),
      FoodModel(
          id: 1,
          restaurantName: "Mr. Hungry",
          name: "Hainam Chicken Rice",
          image: GLOBAL_URL + "/assets/images/apps/food_delivery/food/1.jpg",
          price: 5,
          discount: 50,
          rating: 4.9,
          distance: 0.4,
          location: "Crown Street"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double bannerWidth = MediaQuery.of(context).size.width;
    final double bannerHeight = MediaQuery.of(context).size.width * 2 / 4;
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: (selectedTime == '')
            ? Container(
                height: 0.0,
                width: 0.0,
              )
            : Material(
                elevation: 5.0,
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 55.0,
                  padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  alignment: Alignment.center,
                  child: Column(children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(15.0),
                      onTap: () {
                        // if (selectedPaymentMethod == 0)
                        logoutDialogue();
                        // else
                        //   CardDialogue();
                        // _selectPaymentMethod(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: primaryColor,
                        ),
                        child: Text(
                          'Book  Appointment',
                          style: whiteColorButtonTextStyle,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // InkWell(
                    //   borderRadius: BorderRadius.circular(15.0),
                    //   onTap: () {
                    //     // bookforSomeone();
                    //   },
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: 50.0,
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15.0),
                    //       color: primaryColor,
                    //     ),
                    //     child: Text(
                    //       'Book for Someone',
                    //       style: whiteColorButtonTextStyle,
                    //     ),
                    //   ),
                    // )
                  ]),
                ),
              ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                // margin: EdgeInsets.only(bottom: kToolbarHeight + 22),
                child: ListView(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  children: [
                    _buildMerchantTop(),
                    // buildCacheNetworkImage(
                    //     width: bannerWidth,
                    //     height: bannerHeight,
                    //     url:
                    //         "https://2micoaching.com/wp-content/uploads/2021/12/1.jpg"),
                    _reusableWidget.divider1(),
                    _calenderWidget(),
                    // _buildMerchantTop(),
                    _reusableWidget.divider1(),
                    Container(
                      padding: EdgeInsets.only(
                          bottom: fixPadding * 2.0,
                          right: fixPadding * 2.0,
                          left: fixPadding * 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/sunrise.png',
                            height: 35.0,
                            width: 35.0,
                            fit: BoxFit.cover,
                          ),
                          widthSpace,
                          Text(
                            '${morningSlotList.length} Slots',
                            style: blackNormalBoldTextStyle,
                          )
                        ],
                      ),
                    ),
                    Wrap(
                      children: morningSlotList
                          .map((e) => Padding(
                                padding: EdgeInsets.only(
                                    left: fixPadding * 2.0,
                                    bottom: fixPadding * 2.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedTime = e['time'].toString();
                                    });
                                  },
                                  child: Container(
                                    width: 90.0,
                                    padding: EdgeInsets.all(fixPadding),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                          width: 0.7, color: greyColor),
                                      color: (e['time'] == selectedTime)
                                          ? primaryColor
                                          : whiteColor,
                                    ),
                                    child: Text(e['time'].toString(),
                                        style: (e['time'] == selectedTime)
                                            ? whiteColorNormalTextStyle
                                            : primaryColorNormalTextStyle),
                                  ),
                                ),
                              ))
                          .toList()
                          .cast<Widget>(),
                    ),

                    // Morning Slot End

                    // Afternoon Slot Start
                    Container(
                      padding: EdgeInsets.only(
                          bottom: fixPadding * 2.0,
                          right: fixPadding * 2.0,
                          left: fixPadding * 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/sun.png',
                            height: 35.0,
                            width: 35.0,
                            fit: BoxFit.cover,
                          ),
                          widthSpace,
                          Text(
                            '${afternoonSlotList.length} Slots',
                            style: blackNormalBoldTextStyle,
                          )
                        ],
                      ),
                    ),
                    Wrap(
                      children: afternoonSlotList
                          .map((e) => Padding(
                                padding: EdgeInsets.only(
                                    left: fixPadding * 2.0,
                                    bottom: fixPadding * 2.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedTime = e['time'].toString();
                                    });
                                  },
                                  child: Container(
                                    width: 90.0,
                                    padding: EdgeInsets.all(fixPadding),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                          width: 0.7, color: greyColor),
                                      color: (e['time'] == selectedTime)
                                          ? primaryColor
                                          : whiteColor,
                                    ),
                                    child: Text(e['time'].toString(),
                                        style: (e['time'] == selectedTime)
                                            ? whiteColorNormalTextStyle
                                            : primaryColorNormalTextStyle),
                                  ),
                                ),
                              ))
                          .toList()
                          .cast<Widget>(),
                    ),
                    // Afternoon Slot End

                    // Evening Slot Start
                    Container(
                      padding: EdgeInsets.only(
                          bottom: fixPadding * 2.0,
                          right: fixPadding * 2.0,
                          left: fixPadding * 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/sun-night.png',
                            height: 35.0,
                            width: 35.0,
                            fit: BoxFit.cover,
                          ),
                          widthSpace,
                          Text(
                            '${eveningSlotList.length} Slots',
                            style: blackNormalBoldTextStyle,
                          )
                        ],
                      ),
                    ),
                    Wrap(
                      children: eveningSlotList
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(
                                  left: fixPadding * 2.0,
                                  bottom: fixPadding * 2.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedTime = e['time'].toString();
                                  });
                                },
                                child: Container(
                                  width: 90.0,
                                  padding: EdgeInsets.all(fixPadding),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                        width: 0.7, color: greyColor),
                                    color: (e['time'] == selectedTime)
                                        ? primaryColor
                                        : whiteColor,
                                  ),
                                  child: Text(e['time'].toString(),
                                      style: (e['time'] == selectedTime)
                                          ? whiteColorNormalTextStyle
                                          : primaryColorNormalTextStyle),
                                ),
                              ),
                            ),
                          )
                          .toList()
                          .cast<Widget>(),
                    ),
                    // _buildNewMenu(),
                    // _reusableWidget.divider1(),
                    // _buildChickenMenu(),
                    // _reusableWidget.divider1(),
                    // _buildBeefMenu(),
                  ],
                ),
              ),
              Opacity(
                opacity: _showAppBar ? 1 : 0,
                child: Container(
                  height: 60,
                  child: AppBar(
                    iconTheme: IconThemeData(
                      color: GlobalStyle.appBarIconThemeColor,
                    ),
                    systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
                    centerTitle: true,
                    title: Text('2Mi Coaching Service - Rapid Action Coaching',
                        style: GlobalStyle.appBarTitle),
                    backgroundColor: GlobalStyle.appBarBackgroundColor,
                  ),
                ),
              ),
              // _buildViewCartButton(),
            ],
          ),
        ),
        floatingActionButton: _reusableWidget.fabCart(context));
  }

  logoutDialogue() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "You are about to book Rapid Action Coaching Session for \n $selectedTime on $selectedDate ",
                      style: blackHeadingTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Cancel',
                              style: blackColorButtonTextStyle,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Appointment Added to cart"),
                            ));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Confirm',
                              style: whiteColorButtonTextStyle,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  LabelType toLabelType(String label) {
    LabelType type = LabelType.date;
    switch (label) {
      case labelMonth:
        type = LabelType.month;
        break;
      case labelDate:
        type = LabelType.date;
        break;
      case labelWeekDay:
        type = LabelType.weekday;
        break;
    }
    return type;
  }

  Widget _calenderWidget() {
    return HorizontalCalendar(
      key: forceRender ? UniqueKey() : Key('Calendar'),
      selectedDateTextStyle: TextStyle(color: Colors.white),
      selectedMonthTextStyle: TextStyle(color: Colors.white),
      selectedWeekDayTextStyle: TextStyle(color: Colors.white),
      spacingBetweenDates: 5.0,
      height: 185,
      padding: EdgeInsets.all(10.0 * 2.0),
      firstDate: firstDate,
      lastDate: lastDate,
      dateFormat: dateFormat,
      weekDayFormat: weekDayFormat,
      monthFormat: monthFormat,
      defaultDecoration: BoxDecoration(
        color: defaultDecorationColor,
        shape: defaultDecorationShape,
        borderRadius: defaultDecorationShape == BoxShape.rectangle &&
                isCircularRadiusDefault
            ? BorderRadius.circular(8)
            : null,
      ),
      selectedDecoration: BoxDecoration(
        color: selectedDecorationColor,
        shape: selectedDecorationShape,
        borderRadius: selectedDecorationShape == BoxShape.rectangle &&
                isCircularRadiusSelected
            ? BorderRadius.circular(8)
            : null,
      ),
      disabledDecoration: BoxDecoration(
        color: disabledDecorationColor,
        shape: disabledDecorationShape,
        borderRadius: disabledDecorationShape == BoxShape.rectangle &&
                isCircularRadiusDisabled
            ? BorderRadius.circular(8)
            : null,
      ),
      isDateDisabled: (date) =>
          date.weekday == DateTime.sunday || date.weekday == DateTime.now(),
      labelOrder: order.map(toLabelType).toList(),
      maxSelectedDateCount: maxSelectedDateCount,
      initialSelectedDates: initialSelectedDates,
      onDateSelected: (e) async {
        setState(() {
          selectedDate = '${e.day}-${convertNumberMonthToStringMonth(e.month)}';
        });
      },
    );
    // HorizontalCalendar(
    //   key: forceRender ? UniqueKey() : Key('Calendar'),
    //   height: 120,
    //   padding: EdgeInsets.all(22),
    //   firstDate: DateTime.now(),
    //   lastDate: DateTime.now().add(
    //     Duration(days: 15),
    //   ),
    //   defaultDecoration: BoxDecoration(
    //     color: defaultDecorationColor,
    //     shape: defaultDecorationShape,
    //     borderRadius: defaultDecorationShape == BoxShape.rectangle &&
    //             isCircularRadiusDefault
    //         ? BorderRadius.circular(8)
    //         : null,
    //   ),
    //   selectedDecoration: BoxDecoration(
    //     color: selectedDecorationColor,
    //     shape: selectedDecorationShape,
    //     borderRadius: selectedDecorationShape == BoxShape.rectangle &&
    //             isCircularRadiusSelected
    //         ? BorderRadius.circular(8)
    //         : null,
    //   ),
    //   disabledDecoration: BoxDecoration(
    //     color: disabledDecorationColor,
    //     shape: disabledDecorationShape,
    //     borderRadius: disabledDecorationShape == BoxShape.rectangle &&
    //             isCircularRadiusDisabled
    //         ? BorderRadius.circular(8)
    //         : null,
    //   ),
    //   //pass other properties as required
    // );
  }

  final morningSlotList = [
    {'time': '07:00'},
    {'time': '07:15'},
    {'time': '07:30'},
    {'time': '07:45'},
    {'time': '08:00'},
    {'time': '08:15'},
    {'time': '08:30'},
    {'time': '08:45'},
    {'time': '09:00'},
    {'time': '09:30'},
    {'time': '10:00'},
    {'time': '10:30'},
    {'time': '11:00'}
  ];

  final List<Map> data = [
    {'value': 'M', 'display': 'Female'},
    {'value': 'F', 'display': 'Male'},
  ];

  final afternoonSlotList = [
    {'time': '12:30'},
    {'time': '13:00'},
    {'time': '13:30'},
    {'time': '14:00'},
    {'time': '14:30'},
    {'time': '15:00'},
    {'time': '15:30'},
    {'time': '16:00'},
    {'time': '16:30'}
  ];

  final eveningSlotList = [
    {'time': '17:00'},
    {'time': '17:30'},
    {'time': '18:00'},
    {'time': '18:30'}
  ];
  String convertNumberMonthToStringMonth(month) {
    String yearString = DateTime.now().year.toString();
    if (month == 1) {
      monthString = 'January';
    } else if (month == 2) {
      monthString = 'February';
    } else if (month == 3) {
      monthString = 'March';
    } else if (month == 4) {
      monthString = 'April';
    } else if (month == 5) {
      monthString = 'May';
    } else if (month == 6) {
      monthString = 'June';
    } else if (month == 7) {
      monthString = 'July';
    } else if (month == 8) {
      monthString = 'August';
    } else if (month == 9) {
      monthString = 'September';
    } else if (month == 10) {
      monthString = 'October';
    } else if (month == 11) {
      monthString = 'November';
    } else if (month == 12) {
      monthString = 'December';
    }
    return "$monthString $yearString";
  }

  Widget _buildMerchantTop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('2Mi Coaching', style: GlobalStyle.preferredMerchant),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantInformationPage()));
                  },
                  child: Icon(Icons.info_outline, size: 20, color: BLACK77)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Rapid Action Coaching - \$500/hr',
              style: GlobalStyle.restaurantTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ),
        SizedBox(height: 4),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              SizedBox(width: 6),
              Icon(Icons.location_pin, color: ASSENT_COLOR, size: 15),
              SizedBox(width: 2),
              Text('Online', style: GlobalStyle.textRatingDistances),
            ],
          ),
        ),
        // _reusableWidget.divider2(),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 16),
        //   child: GestureDetector(
        //     behavior: HitTestBehavior.translucent,
        //     onTap: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => CouponPage()));
        //     },
        //     child: Row(
        //       children: [
        //         Icon(Icons.local_offer_outlined, color: ASSENT_COLOR, size: 16),
        //         SizedBox(width: 4),
        //         Text('Check for available coupons'),
        //         Spacer(),
        //         Text('See Coupons', style: GlobalStyle.couponAction),
        //       ],
        //     ),
        //   ),
        // ),
        SizedBox(height: 16)
      ],
    );
  }

  slots() {
    // DateTime nowTime = DateTime.now();
    // DateTime selected = HttpDate.parse(selectedDate);
    // final format = DateFormat("dd.MM.yyyy");
    return ListView(
      children: [
        heightSpace,
        // Morning Slot Start
        Container(
          padding: EdgeInsets.only(
              bottom: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/sunrise.png',
                height: 35.0,
                width: 35.0,
                fit: BoxFit.cover,
              ),
              widthSpace,
              Text(
                '${morningSlotList.length} Slots',
                style: blackNormalBoldTextStyle,
              )
            ],
          ),
        ),
        Wrap(
          children: morningSlotList
              .map((e) => Padding(
                    padding: EdgeInsets.only(
                        left: fixPadding * 2.0, bottom: fixPadding * 2.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedTime = e['time'].toString();
                        });
                      },
                      child: Container(
                        width: 90.0,
                        padding: EdgeInsets.all(fixPadding),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(width: 0.7, color: greyColor),
                          color: (e['time'] == selectedTime)
                              ? primaryColor
                              : whiteColor,
                        ),
                        child: Text(e['time'].toString(),
                            style: (e['time'] == selectedTime)
                                ? whiteColorNormalTextStyle
                                : primaryColorNormalTextStyle),
                      ),
                    ),
                  ))
              .toList()
              .cast<Widget>(),
        ),

        // Morning Slot End

        // Afternoon Slot Start
        Container(
          padding: EdgeInsets.only(
              bottom: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/sun.png',
                height: 35.0,
                width: 35.0,
                fit: BoxFit.cover,
              ),
              widthSpace,
              Text(
                '${afternoonSlotList.length} Slots',
                style: blackNormalBoldTextStyle,
              )
            ],
          ),
        ),
        Wrap(
          children: afternoonSlotList
              .map((e) => Padding(
                    padding: EdgeInsets.only(
                        left: fixPadding * 2.0, bottom: fixPadding * 2.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedTime = e['time'].toString();
                        });
                      },
                      child: Container(
                        width: 90.0,
                        padding: EdgeInsets.all(fixPadding),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(width: 0.7, color: greyColor),
                          color: (e['time'] == selectedTime)
                              ? primaryColor
                              : whiteColor,
                        ),
                        child: Text(e['time'].toString(),
                            style: (e['time'] == selectedTime)
                                ? whiteColorNormalTextStyle
                                : primaryColorNormalTextStyle),
                      ),
                    ),
                  ))
              .toList()
              .cast<Widget>(),
        ),
        // Afternoon Slot End

        // Evening Slot Start
        Container(
          padding: EdgeInsets.only(
              bottom: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/sun-night.png',
                height: 35.0,
                width: 35.0,
                fit: BoxFit.cover,
              ),
              widthSpace,
              Text(
                '${eveningSlotList.length} Slots',
                style: blackNormalBoldTextStyle,
              )
            ],
          ),
        ),
        Wrap(
          children: eveningSlotList
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(
                      left: fixPadding * 2.0, bottom: fixPadding * 2.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTime = e['time'].toString();
                      });
                    },
                    child: Container(
                      width: 90.0,
                      padding: EdgeInsets.all(fixPadding),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(width: 0.7, color: greyColor),
                        color: (e['time'] == selectedTime)
                            ? primaryColor
                            : whiteColor,
                      ),
                      child: Text(e['time'].toString(),
                          style: (e['time'] == selectedTime)
                              ? whiteColorNormalTextStyle
                              : primaryColorNormalTextStyle),
                    ),
                  ),
                ),
              )
              .toList()
              .cast<Widget>(),
        ),
        // Evening Slot End
      ],
    );
  }

  Widget _buildViewCartButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
            color: Colors.grey[100]!,
          )),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartPage()));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: kToolbarHeight - 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: ASSENT_COLOR,
            ),
            child: Row(
              children: [
                Text('View Cart',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 16),
                Text('3 Items',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    )),
                Spacer(),
                Text('\$14',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

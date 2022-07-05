import 'dart:convert';
import 'dart:math';

import 'package:backdrop/backdrop.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_app/config/apps/food_delivery/constant.dart';
import 'package:doctor_app/config/apps/food_delivery/global_style.dart';
import 'package:doctor_app/data/json.dart';
import 'package:doctor_app/model/apps/food_delivery/restaurant_model.dart';
import 'package:doctor_app/model/apps/food_delivery/services_model.dart';
import 'package:doctor_app/model/feature/banner_slider_model.dart';
import 'package:doctor_app/model/screen/product_model.dart';
import 'package:doctor_app/theme/colors.dart';
import 'package:doctor_app/ui/apps/food_delivery/detail_restaurant.dart';
import 'package:doctor_app/ui/apps/food_delivery/restaurant_list.dart';
import 'package:doctor_app/ui/apps/food_delivery/reusable_widget.dart';
import 'package:doctor_app/ui/reusable/cache_image_network.dart';
import 'package:doctor_app/ui/reusable/global_widget.dart';
import 'package:doctor_app/utils.dart';
import 'package:doctor_app/widgets/category_box.dart';
import 'package:doctor_app/widgets/popular_doctor.dart';
import 'package:doctor_app/widgets/textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

import '../ui/reusable/shimmer_loading.dart';

List<ProductModel> _trendingData = [
  ProductModel(
    id: 1,
    name: "Adidas Shirt",
    image: GLOBAL_URL + "/assets/images/product/21.jpg",
    sale: 12700,
  ),
  ProductModel(
    id: 2,
    name: "iPhone SE 2020",
    image: GLOBAL_URL + "/assets/images/product/22.jpg",
    sale: 8300,
  ),
  ProductModel(
    id: 3,
    name: "Macbook Air 2020",
    image: GLOBAL_URL + "/assets/images/product/23.jpg",
    sale: 31400,
  ),
  ProductModel(
    id: 4,
    name: "Gaming Chair",
    image: GLOBAL_URL + "/assets/images/product/24.jpg",
    sale: 11900,
  )
];

// List<RestaurantModel> _nearbyFoodData = [
//   RestaurantModel(
//       id: 1,
//       name: "Rapid-Action Coaching",
//       tag: "Chicken, Rice",
//       image: "assets/images/RapidActionCoaching.jpg",
//       rating: 4.9,
//       distance: 0.4,
//       promo: '500/hr',
//       location: "43-14271 60 Avenue"),
//   RestaurantModel(
//       id: 2,
//       name: "Personal Impact Coaching",
//       tag: "Beef, Yakiniku, Japanese Food",
//       image: "assets/images/PersonalImpactCoaching.jpg",
//       rating: 5,
//       distance: 0.6,
//       promo: '500/hr',
//       location: "43-14271 60 Avenue"),
//   RestaurantModel(
//       id: 3,
//       name: "Executive Leadership Coaching",
//       tag: "Healthy Food, Salad",
//       image: "assets/images/ExecutiveLeadershipCoaching.jpg",
//       rating: 4.3,
//       distance: 0.7,
//       promo: '500/hr',
//       location: "43-14271 60 Avenue"),
//   RestaurantModel(
//       id: 4,
//       name: "Executive Leadership Team Coaching",
//       tag: "Hot, Fresh, Steam",
//       image: "assets/images/ExecutiveLeadershipteamCoaching.jpg",
//       rating: 4.9,
//       distance: 0.7,
//       promo: '500/hr',
//       location: "Online"),
//   RestaurantModel(
//       id: 5,
//       name: "Transition Coaching",
//       tag: "Penne, Western Food",
//       image: "assets/images/TransitionCoaching.jpg",
//       rating: 4.6,
//       distance: 0.9,
//       promo: '500/hr',
//       location: "Online"),
//   // RestaurantModel(
//   //     id: 6,
//   //     name: "Transition Coaching",
//   //     tag: "Bread",
//   //     image: GLOBAL_URL + "/assets/images/apps/food_delivery/food/6.jpg",
//   //     rating: 4.8,
//   //     distance: 0.9,
//   //     promo: '',
//   //     location: "Mapple Street"),
//   // RestaurantModel(
//   //     id: 7,
//   //     name: "Awesome Health",
//   //     tag: "Salad, Healthy Food, Fresh",
//   //     image: GLOBAL_URL + "/assets/images/apps/food_delivery/food/7.jpg",
//   //     rating: 4.9,
//   //     distance: 1.1,
//   //     promo: '10% Off',
//   //     location: "Fenimore Street"),
//   // RestaurantModel(
//   //     id: 8,
//   //     name: "Chicken Specialties",
//   //     tag: "Chicken, Rice, Teriyaki",
//   //     image: GLOBAL_URL + "/assets/images/apps/food_delivery/food/8.jpg",
//   //     rating: 4.7,
//   //     distance: 3.9,
//   //     promo: '10% Off',
//   //     location: "Liberty Avenue"),
// ];
final _globalWidget = GlobalWidget();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _shimmerLoading = ShimmerLoading();
  final _reusableWidget = ReusableWidget();
  List<BannerSliderModel> bannerData = [];
  Color _bulletColor = Color(0xff01aed6);
  Color bgcolor = Color(0xfff2b036);
  Color _color3 = Color(0xff777777);
  Color _color1 = Color(0xff777777);
  Color _color2 = Color(0xFF515151);
  List<ServicesModel> services = [];

  int _currentImageSlider = 0;

  int _currentIndex = 0;
  final List<Widget> _pages = [_Widget1(), _Widget2(), _Widget3()];
  @override
  void initState() {
    _getServices().then((value) => setState(() {
          services = value;
        }));
    bannerData.add(BannerSliderModel(
        id: 1,
        image:
            'https://2micoaching.com/wp-content/uploads/2021/12/Untitled-1.jpg'));
    bannerData.add(BannerSliderModel(
        id: 2,
        image:
            'https://2micoaching.com/wp-content/uploads/2021/09/pexels-rfstudio-3810762-1024x731.jpg'));
    bannerData.add(BannerSliderModel(
        id: 3,
        image:
            'https://2micoaching.com/wp-content/uploads/2021/09/3810792.jpg'));

    super.initState();
  }

  Future<List<ServicesModel>> _getServices() async {
    List<ServicesModel> services = [];
    List<dynamic> data = [];

    http.Response response = await http.get(
        Uri.parse(apiServiceUrlGlobal + '?page=1&length=4'),
        headers: {'Authorization': basicAuth});

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data.length);
      for (int i = 0; i < data.length; i++) {
        services.add(new ServicesModel(
            id: data[i]['id'],
            name: data[i]['name'],
            duration: data[i]['duration'],
            price: data[i]['price'],
            currency: data[i]['currency'],
            description: data[i]['description'],
            availabilitiesType: data[i]['availabilitiesType'],
            location: data[i]['location']));
      }
      // print(response.body);
    } else {
      print(response.reasonPhrase);
    }
    return services;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      floatingActionButton: _reusableWidget.fabCart(context),
      body: getBody(),
    );
  }

  Widget _createTrending() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Services',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Trebuchet MS')),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RestaurantListPage(title: 'Services')));
                },
                child: Text('view all',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_COLOR),
                    textAlign: TextAlign.end),
              )
            ],
          ),
        ),
        GridView.count(
          padding: EdgeInsets.all(12),
          primary: false,
          childAspectRatio: 4 / 1.6,
          shrinkWrap: true,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          crossAxisCount: 2,
          children: List.generate(1, (index) {
            return _buildTrendingProductCard(index);
          }),
        ),
      ],
    );
  }

  String randomAsset() {
    var random = Random();
    final colorList = [
      "assets/images/RapidActionCoaching.jpg",
      "assets/images/PersonalImpactCoaching.jpg",
      "assets/images/ExecutiveLeadershipCoaching.jpg",
      "assets/images/ExecutiveLeadershipteamCoaching.jpg"
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  Widget _buildTrendingProductCard(index) {
    return GestureDetector(
      onTap: () {
        Fluttertoast.showToast(
            msg: 'Click ' + services[index].name,
            toastLength: Toast.LENGTH_SHORT);
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: Colors.white,
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: new Image.asset(
                    randomAsset(),
                    width: (MediaQuery.of(context).size.width / 2) * (1.6 / 4) -
                        12 -
                        1,
                    height:
                        (MediaQuery.of(context).size.width / 2) * (1.6 / 4) -
                            12 -
                            1,
                  )),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(services[index].name,
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text(services[index].price.toString() + ' product',
                          style: TextStyle(fontSize: 9, color: _color3))
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _createAllProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Services',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RestaurantListPage(title: 'Services')));
                },
                child: Text('view all',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_COLOR),
                    textAlign: TextAlign.end),
              )
            ],
          ),
        ),
        CustomScrollView(primary: false, shrinkWrap: true, slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.625,
              ),
              delegate: services.length > 0
                  ? SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return _buildItem(index);
                      },
                      childCount: services.length,
                    )
                  // : _shimmerLoading.buildShimmerContent()
                  : SliverChildListDelegate(
                      <Widget>[
                        Container(
                          height: 100,
                          child: Center(
                            child: _shimmerLoading.buildShimmerContent(),
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ])
      ],
    );
  }

  _buildItem(index) {
    final double boxImageSize =
        ((MediaQuery.of(context).size.width) - 24) / 2 - 12;
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailRestaurantPage(service: services[index])));
            // Fluttertoast.showToast(
            //     msg: 'Click ' + _nearbyFoodData[index].name,
            //     toastLength: Toast.LENGTH_SHORT);
          },
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: new Image.asset(
                    randomAsset(),
                    width: boxImageSize,
                    height: boxImageSize,
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      services[index].name,
                      style: TextStyle(fontSize: 12, color: _color1),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$ ' + services[index].price.toString(),
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                          Text(services[index].price.toString() + ' ' + 'Sale',
                              style: TextStyle(fontSize: 11, color: SOFT_GREY))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: SOFT_GREY, size: 12),
                          Text(' ' + services[index].location,
                              style: TextStyle(fontSize: 11, color: SOFT_GREY))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          _globalWidget.createRatingBar(rating: 3, size: 12),
                          Text('(' + services[index].location + ')',
                              style: TextStyle(fontSize: 11, color: SOFT_GREY))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getBody() {
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 5,
          ),
          Container(
              child: Text(
            "RAISING CONSCIOUS LEADERS",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                fontFamily: 'Trebuchet MS'),
            textAlign: TextAlign.center,
          )),
          SizedBox(
            height: 15,
          ),
          CustomTextBox(),
          SizedBox(height: 10),
          _createAllProduct(),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}

class _Widget1 extends StatelessWidget {
  _Widget1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text("Widget 1")),
        SizedBox(height: 12),
        Center(
          child: _globalWidget.createButton(
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              buttonName: 'Back',
              onPressed: () {
                Navigator.pop(context);
              }),
        )
      ],
    );
  }
}

class _Widget2 extends StatelessWidget {
  _Widget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text("Widget 2")),
        SizedBox(height: 12),
        Center(
          child: _globalWidget.createButton(
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              buttonName: 'Back',
              onPressed: () {
                Navigator.pop(context);
              }),
        )
      ],
    );
  }
}

class _Widget3 extends StatelessWidget {
  _Widget3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text("Widget 3")),
        SizedBox(height: 12),
        Center(
          child: _globalWidget.createButton(
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              buttonName: 'Back',
              onPressed: () {
                Navigator.pop(context);
              }),
        )
      ],
    );
  }
}

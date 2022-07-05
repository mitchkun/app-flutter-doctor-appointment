import 'dart:async';
import 'dart:convert';

import 'package:doctor_app/config/apps/food_delivery/constant.dart';
import 'package:doctor_app/config/apps/food_delivery/global_style.dart';
import 'package:doctor_app/model/apps/food_delivery/services_model.dart';
import 'package:doctor_app/ui/apps/food_delivery/reusable_widget.dart';
import 'package:doctor_app/model/apps/food_delivery/restaurant_model.dart';
import 'package:doctor_app/ui/reusable/shimmer_loading.dart';
import 'package:doctor_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestaurantListPage extends StatefulWidget {
  final String title;

  const RestaurantListPage({Key? key, this.title = 'Food Around You'})
      : super(key: key);

  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  // initialize shimmer loading and reusable widget
  final _shimmerLoading = ShimmerLoading();
  final _reusableWidget = ReusableWidget();

  bool _loading = true;
  Timer? _timerDummy;

  List<ServicesModel> _restaurantData = [];
  Future<List<ServicesModel>> _getServices() async {
    List<ServicesModel> services = [];
    List<dynamic> data = [];

    http.Response response = await http.get(
        Uri.parse(apiServiceUrlGlobal + '?page=1&length=10'),
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
  void initState() {
    _getServices().then((value) => setState(() {
          _restaurantData = value;
          _loading = false;
        }));

    super.initState();
  }

  @override
  void dispose() {
    _timerDummy?.cancel();
    super.dispose();
  }

  // Future<List<ServicesModel>> _getData() async {
  //   // this timer function is just for demo, so after 1 second, the shimmer loading will disappear and show the content
  //   // _timerDummy = Timer(Duration(seconds: 1), () {
  //   // setState(() {
  //   //   _loading = false;
  //   // });
  //   // });

  //   /*
  //   Image Information
  //   width = 800px
  //   height = 600px
  //   ratio width height = 4:3
  //    */
  //   return await _getServices();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: GlobalStyle.appBarIconThemeColor,
        ),
        systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
        centerTitle: true,
        title: Text(widget.title, style: GlobalStyle.appBarTitle),
        backgroundColor: GlobalStyle.appBarBackgroundColor,
        bottom: _reusableWidget.bottomAppBar(),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: (_loading == true)
            ? _shimmerLoading.buildShimmerContent()
            : ListView.builder(
                itemCount: _restaurantData.length,
                padding: EdgeInsets.symmetric(vertical: 0),
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return _reusableWidget.buildRestaurantList(
                      context, index, _restaurantData);
                },
              ),
      ),
      floatingActionButton: _reusableWidget.fabCart(context),
    );
  }

  Future refreshData() async {
    setState(() {
      _restaurantData.clear();
      _loading = true;
      _getServices().then((value) => _restaurantData = value);
    });
  }
}

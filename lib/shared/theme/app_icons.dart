import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcons {
  //Bottom Nav Bar Icons
  static const String cashRegister = "assets/icons/cash_register.svg";
  static const String coin = "assets/icons/coin.svg";
  static const String creditCard = "assets/icons/credit_card.svg";
  static const String lineChart = "assets/icons/line_chart.svg";

  //Category Icons

  static List<IconData> highlightIcons = [
    cart,
    restaurant,
    bus,
    car,
    house,
    receipt,
    cash,
    savings,
    fitness,
    pills,
    desktop,
  ];

  static const IconData fastFood = FontAwesomeIcons.burger;
  static const IconData cart = FontAwesomeIcons.cartShopping;
  static const IconData pizza = FontAwesomeIcons.pizzaSlice;
  static const IconData restaurant = Icons.restaurant_outlined;
  static const IconData cake = Icons.cake_outlined;
  static const IconData drinks = Icons.local_bar_outlined;
  static const IconData liquor = Icons.liquor_outlined;

  static List<IconData> foodIcons = [
    fastFood,
    cart,
    pizza,
    restaurant,
    cake,
    drinks,
    liquor,
  ];

  static const IconData bus = FontAwesomeIcons.bus;
  static const IconData car = FontAwesomeIcons.car;
  static const IconData carSport = FontAwesomeIcons.carRear;
  static const IconData airplane = FontAwesomeIcons.plane;
  static const IconData bicycle = FontAwesomeIcons.bicycle;
  static const IconData truck = Icons.local_shipping_outlined;
  static const IconData train = Icons.train_outlined;
  static const IconData taxi = Icons.local_taxi_outlined;
  static const IconData bike = Icons.two_wheeler_outlined;

  static List<IconData> transportIcons = [
    bus,
    car,
    carSport,
    airplane,
    bicycle,
    truck,
    train,
    taxi,
    bike,
  ];

  static const IconData house = FontAwesomeIcons.house;
  static const IconData bed = Icons.bed_outlined;
  static const IconData ac = Icons.ac_unit_outlined;
  static const IconData lighting = Icons.electric_bolt_outlined;
  static const IconData sensors = Icons.sensors;
  static const IconData water = Icons.water_drop_outlined;
  static const IconData receipt = Icons.receipt_long_outlined;

  static List<IconData> billIcons = [
    house,
    bed,
    ac,
    lighting,
    sensors,
    water,
    receipt,
  ];

  static const IconData chartBar = FontAwesomeIcons.chartSimple;
  static const IconData chartPie = FontAwesomeIcons.chartPie;
  static const IconData chartLine = FontAwesomeIcons.chartLine;
  static const IconData cash = FontAwesomeIcons.moneyBill;
  static const IconData dollarSack = FontAwesomeIcons.sackDollar;
  static const IconData bitcoin = Icons.currency_bitcoin_outlined;
  static const IconData savings = Icons.savings_outlined;

  static List<IconData> investmentsAndIncomeIcons = [
    chartBar,
    cash,
    dollarSack,
    chartPie,
    chartLine,
    bitcoin,
    savings,
  ];

  static const IconData fitness = Icons.fitness_center;
  static const IconData heart = FontAwesomeIcons.heart;
  static const IconData medkit = FontAwesomeIcons.suitcaseMedical;
  static const IconData neurology = FontAwesomeIcons.brain;
  static const IconData dentist = FontAwesomeIcons.tooth;
  static const IconData pills = FontAwesomeIcons.pills;
  static const IconData syringe = FontAwesomeIcons.syringe;

  static List<IconData> healthIcons = [
    fitness,
    heart,
    medkit,
    neurology,
    dentist,
    pills,
    syringe,
  ];

  static const IconData desktop = FontAwesomeIcons.desktop;
  static const IconData videoGame = FontAwesomeIcons.gamepad;
  static const IconData mobile = FontAwesomeIcons.mobile;
  static const IconData tv = FontAwesomeIcons.tv;
  static const IconData headset = FontAwesomeIcons.headset;
  static const IconData mouse = FontAwesomeIcons.computerMouse;

  static List<IconData> techIcons = [
    desktop,
    videoGame,
    mobile,
    tv,
    headset,
    mouse,
  ];
}

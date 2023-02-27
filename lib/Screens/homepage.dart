import 'package:bmi/bars/leftbar.dart';
import 'package:bmi/bars/rightbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slider_controller/slider_controller.dart';

class MyBody extends StatefulWidget {
  const MyBody({super.key});

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  FocusNode nodeFirst = FocusNode();
  final TextEditingController _htextController = TextEditingController();
  final TextEditingController _wtextController = TextEditingController();
  double height = 0;
  double weight = 0;
  double _bmiN = 0;
  double _bmiNS = 0;
  String _bmiResult = "";
  String _textResult = "";
  bool hvalidate = false;
  bool wvalidate = false;
  bool iconBFatR = false;
  int group = 1;
  Color _sliderColor = Colors.blueGrey;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: rLT(title: "Metric\nUnits", value: 1),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: rLT(title: "US\nUnits", value: 2),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    focusNode: nodeFirst,
                    textInputAction: TextInputAction.next,
                    maxLength: 3,
                    controller: _htextController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp("[0-9]+"),
                      ),
                    ],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.yellow,
                    ),
                    decoration: InputDecoration(
                      counter: const Text(""),
                      border: InputBorder.none,
                      hintText: group == 1 ? "Height(cm)" : "Height(in)",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: TextField(
                    maxLength: 3,
                    controller: _wtextController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp("[0-9]+"),
                      ),
                    ],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.yellow,
                    ),
                    decoration: InputDecoration(
                      counter: const Text(""),
                      border: InputBorder.none,
                      hintText: group == 1 ? "Weight(kg)" : "Weight(lbs)",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: calcBmi,
            child: const Text(
              "Calculate",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            _bmiResult,
            style: const TextStyle(
              fontSize: 42,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              iconBFat(),
              Text(
                _textResult,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontFamily: 'vazir',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          //Slider
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: SliderController(
              isDraggable: false,
              min: 0,
              max: 100 / 2,
              sliderDecoration: SliderDecoration(
                activeColor: _sliderColor,
              ),
              value: _bmiNS,
              onChanged: (value) {},
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: resetBmi,
            child: const Text(
              "Reset",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
          ),

          const RightBar(barWidth: 90),
          const LeftBar(barWidth: 60),
          const LeftBar(barWidth: 40),
        ],
      ),
    );
  }

  void calcBmi() {
    if (_htextController.text.isEmpty || _wtextController.text.isEmpty) {
      setState(
        () {
          _textResult = "لطفا قد و وزن خود را وارد کنید";
        },
      );
    } else {
      setState(
        () {
          if (group == 1) {
            height = double.parse(_htextController.text) / 100;
            weight = double.parse(_wtextController.text);
            _bmiN = weight / (height * height);
          } else {
            height = double.parse(_htextController.text);
            weight = double.parse(_wtextController.text);
            _bmiN = (weight / (height * height)) * 703;
          }

          if (_bmiN < 10 || _bmiN > 50) {
            resetBmi();
            _textResult = "داده ورودی غلط";
            iconBFatR = false;
          } else {
            if (_bmiN <= 16) {
              _textResult = "لاغری شدید";
              _sliderColor = Colors.red;
              iconBFatR = false;
            } else if (_bmiN > 16 && _bmiN <= 17) {
              _textResult = "لاغری متوسط";
              _sliderColor = Colors.redAccent;
              iconBFatR = false;
            } else if (_bmiN > 17 && _bmiN <= 18.5) {
              _textResult = "لاغری خفیف";
              _sliderColor = Colors.red.shade100;
              iconBFatR = false;
            } else if (_bmiN > 18.5 && _bmiN <= 25) {
              _textResult = "نرمال";
              _sliderColor = Colors.green;
              iconBFatR = false;
            } else if (_bmiN > 25 && _bmiN <= 30) {
              _textResult = "اضافه وزن";
              _sliderColor = Colors.red.shade100;
              iconBFatR = true;
            } else if (_bmiN > 30 && _bmiN <= 35) {
              _textResult = "چاقی سطح یک";
              _sliderColor = Colors.red.shade400;
              iconBFatR = true;
            } else if (_bmiN > 35 && _bmiN <= 40) {
              _textResult = "چاقی سطح دو";
              _sliderColor = Colors.redAccent;
              iconBFatR = true;
            } else if (_bmiN > 40) {
              _textResult = "چاقی سطح سه";
              _sliderColor = Colors.red;
              iconBFatR = true;
            }
            _bmiResult = _bmiN.toStringAsFixed(2);
            _bmiNS = _bmiN;
          }
        },
      );
    }
  }

  void resetBmi() {
    _htextController.clear();
    _wtextController.clear();
    setState(
      () {
        _bmiN = 0;
        _bmiNS = 0;
        _bmiResult = "";
        _textResult = "";
        iconBFatR = false;
        _sliderColor = Colors.blueGrey;
        FocusScope.of(context).requestFocus(nodeFirst);
      },
    );
  }

  RadioListTile rLT({required String title, required dynamic value}) {
    return RadioListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      tileColor: Colors.white24,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      value: value,
      groupValue: group,
      onChanged: (value) {
        setState(
          () {
            group = value;
          },
        );
      },
    );
  }

  Widget iconBFat() {
    return iconBFatR == true
        ? IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 10),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(15),
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.all(15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                  ),
                  content: const Text(
                    "وعده ها را تقسیم کنید\nقبل از هر وعده، یک لیوان آب بنوشید\nغذا را خوب بجوید\nقبل از ساعت هشت، شام میل کنید\nهرصبح، یک لیوان آب با لیمو بنوشید\n...",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'vazir',
                      fontSize: 14,
                    ),
                  ),
                  action: SnackBarAction(
                    label: "OK",
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.lightbulb_circle,
              size: 34,
              color: Colors.white,
            ),
          )
        : const SizedBox.shrink();
  }
}

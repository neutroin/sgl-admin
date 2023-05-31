import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sgl_admin/constants/constants.dart';

import '../../backend/database.dart';

class SingleDataScreen extends StatefulWidget {
  const SingleDataScreen({super.key});

  @override
  State<SingleDataScreen> createState() => _SingleDataScreenState();
}

class _SingleDataScreenState extends State<SingleDataScreen> {
  TextEditingController _A = TextEditingController();
  TextEditingController _B = TextEditingController();
  TextEditingController _C = TextEditingController();
  TextEditingController _Time = TextEditingController();
  FocusNode textField1FocusNode = FocusNode();
  FocusNode textField2FocusNode = FocusNode();
  FocusNode textField3FocusNode = FocusNode();
  FocusNode textField4FocusNode = FocusNode();
  String? selectedTime; // Add this line to track the selected value
  List<String> enabledTimes = [];

  @override
  void initState() {
    super.initState();
    checkCurrentTime();
  }

  void checkCurrentTime() {
    DateTime now = DateTime.now();
    String currentTime = DateFormat('h:mm a').format(now);
    int currentIndex = timeList.indexWhere((time) => time == currentTime);
    if (currentIndex != -1 && currentIndex < timeList.length - 2) {
      setState(() {
        enabledTimes = timeList.sublist(currentIndex, currentIndex + 3);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),

          const Text(
            "Enter Values :",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10),
                  child: Center(
                    child: TextField(
                      focusNode: textField1FocusNode,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 26),
                      controller: _A,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'A', border: InputBorder.none),
                      onChanged: (value) {
                        if (value.length >= 1) {
                          textField1FocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(textField2FocusNode);
                        }
                      },
                    ),
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10),
                  child: Center(
                    child: TextField(
                      focusNode: textField2FocusNode,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 26),
                      controller: _B,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'B', border: InputBorder.none),
                      onChanged: (value) {
                        if (value.length >= 1) {
                          textField1FocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(textField3FocusNode);
                        }
                      },
                    ),
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10),
                  child: Center(
                    child: TextField(
                      focusNode: textField3FocusNode,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 26),
                      controller: _C,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'C', border: InputBorder.none),
                      onChanged: (value) {
                        if (value.length >= 1) {
                          textField1FocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(textField4FocusNode);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            "Enter Time :",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              showBottomSheet(
                  enableDrag: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 300,
                      color: Colors.grey.shade200,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close')),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: timeList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedTime = timeList[index];
                                          _Time.text = selectedTime!;
                                        });
                                        print("Selected Time : " + _Time.text);
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        timeList[index],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              height: 80,
              width: 180,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10),
                child: Center(
                    child: Text(
                  selectedTime ?? 'Tap to Select',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
              onTap: () {
                if (_A.text.isEmpty ||
                    _B.text.isEmpty ||
                    _C.text.isEmpty ||
                    _Time.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please Add All Data to Submit');
                } else {
                  DatabaseServices().updateLatestData(
                      'single', _Time.text, _A.text, _B.text, _C.text);
                  _A.clear();
                  _B.clear();
                  _C.clear();
                  _Time.clear();
                }
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text('Submit'),
                ),
              )),
          //------------Last-Update-----------//
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Last Updated Data : ',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('scores')
                  .doc('single')
                  .snapshots(),
              builder: (context, snapshot) {
                TextStyle _style =
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
                TextStyle _valueStyle = const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green);
                if (snapshot.hasData) {
                  String dataA = snapshot.data?['latest']['A'];
                  String dataB = snapshot.data?['latest']['B'];
                  String dataC = snapshot.data?['latest']['C'];
                  String dataTime = snapshot.data?['latest']['Time'];
                  String dataDate = snapshot.data?['latest']['Date'];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Date            ',
                            style: _style,
                          ),
                          Text(
                            'TIME      ',
                            style: _style,
                          ),
                          Text(
                            'A',
                            style: _style,
                          ),
                          Text(
                            'B',
                            style: _style,
                          ),
                          Text(
                            'C',
                            style: _style,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            dataDate,
                            style: _valueStyle,
                          ),
                          Text(
                            dataTime,
                            style: _valueStyle,
                          ),
                          Text(
                            dataA,
                            style: _valueStyle,
                          ),
                          Text(
                            dataB,
                            style: _valueStyle,
                          ),
                          Text(
                            dataC,
                            style: _valueStyle,
                          ),
                        ],
                      )
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              }),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/datetimetextfield.dart';
import '../widgets/field.dart';
import '../widgets/mycontainer.dart';

class DateDifferenceApp extends StatefulWidget {
  @override
  _DateDifferenceAppState createState() => _DateDifferenceAppState();
}

class _DateDifferenceAppState extends State<DateDifferenceApp> {
  final TextEditingController _noDaysController = TextEditingController();
  DateTime? _date1;
  DateTime? _date2;
  DateTime? _date3;
  final TextEditingController _noFromDayController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  DateTime? _pickedDate;
  String _result = '';
  String _noDaysresult = '';
  String _noFromDayresult = '';
  String _currentDate = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setCurrentDate();
  }

  void _setCurrentDate() {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(now);
    setState(() {
      _currentDate = formattedDate;
    });
  }

  void _calculateDifference() {
    DateTime date1 = _date1!;
    DateTime date2 = _date2!;
    //Duration difference = date2.difference(date1);
    print('Date 1 is ${date1} and Date 2 is ${date2}');
    int years = date2.year - date1.year;
    int months = date2.month - date1.month;
    int days = date2.day - date1.day;
    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      if (months < 0) months += 12;
      final daysInMonth = DateTime(date1.year, date1.month + 1, 0).day;
      if (days < 0) days += daysInMonth;
    }
    setState(() {
      _result = '';

      _result += '${years} ';
      _result += 'سنة ';
      _result+= ' ~ ';

      _result += '${months} ';
      _result += 'شهر ';
      _result+= ' ~ ';

      _result += '${days} ';
      _result += 'يوم ';

    });
  }

  void _calculateDaysAfter() {
    DateTime date = _pickedDate ?? DateTime.now();
    int days = int.tryParse(_noDaysController.text) ?? 0;
    DateTime resultDate = date.add(Duration(days: days));
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(resultDate);
    setState(() {
      _noDaysresult = '';
      _noDaysresult = ' ${formattedDate}.';
    });
  }
  void _calculateDaysAfterDate() {
    DateTime date = _date3 ?? DateTime.now();
    int days = int.tryParse(_noFromDayController.text) ?? 0;
    DateTime resultDate = date.add(Duration(days: days));
    resultDate = resultDate.subtract(Duration(days: 1));
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(resultDate);
    setState(() {
      _noFromDayresult = '';
      _noFromDayresult = ' ${formattedDate}.';
    });
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _pickedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: Text(
          'الشاشة الرئيسية',
          style: TextStyle(
              fontFamily: 'Cairo', fontWeight: FontWeight.w300, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        actions: [
          Text(_currentDate),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,

        child: SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyContainer(
                5,
                5,
                Colors.blue.shade100,
                Column(
                  children: [
                    DateTimeFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'التاريخ الأول',
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e?.day ?? 0) == 1
                          ? 'ملاحظة:  اليوم الأول من الشهر'
                          : null,
                      onDateSelected: (DateTime value) {
                        _date1 = value;
                        print(value);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DateTimeFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'التاريخ الثاني',
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e?.day ?? 0) == 1
                          ? 'ملاحظة:  اليوم الأول من الشهر'
                          : null,
                      onDateSelected: (DateTime value) {
                        _date2 = value;
                        print(value);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      color: Color(0xffde8383),

                        onPressed: (){
                        if (_date1 != null && _date2 != null) {
                          _calculateDifference();
                        }
                        }
                        , child: Text('احسب الفرق',style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w300,
                            fontSize: 24,color: Colors.white),)),
                    Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffF5F5F5),
                        ),
                        child: Text(
                      _result,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // MyContainer(5, 5, Colors.greenAccent.shade100,Column(
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //
              //         borderRadius: BorderRadius.circular(5),
              //         color: Color(0xffF5F5F5),
              //       ),
              //       child: TextFormField(
              //         validator: (value) {
              //           if (value == null || value.isEmpty) {
              //             return 'أدخل قيمة';
              //           }
              //           return null;
              //         },
              //         controller: _noDaysController,
              //         decoration: InputDecoration(
              //           labelText: 'أدخل عدد الأيام',
              //           border: OutlineInputBorder(),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       height: 10,
              //     ),
              //     MaterialButton(
              //       color: Color(0xff41e0a2),
              //         onPressed: _calculateDaysAfter, child: Text('احسب التاريخ',style: TextStyle(
              //         fontFamily: 'Cairo',
              //         fontWeight: FontWeight.w700,
              //         fontSize: 24,color: Colors.white),)),
              //
              //
              //     Container(
              //         margin: EdgeInsets.all(10),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(5),
              //           color: Color(0xffF5F5F5),
              //         ),
              //         child: Text(
              //           _noDaysresult,
              //           style: TextStyle(
              //               fontFamily: 'Cairo',
              //               fontWeight: FontWeight.w300,
              //               fontSize: 20),
              //         )),
              //   ],
              // )),
              MyContainer(5, 5, Colors.red.shade100,Column(
                children: [
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'التاريخ المطلوب',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) => (e?.day ?? 0) == 1
                        ? 'ملاحظة:  اليوم الأول من الشهر'
                        : null,
                    onDateSelected: (DateTime value) {
                      _date3 = value;
                      print(value);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffF5F5F5),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'أدخل قيمة';
                        }
                        return null;
                      },
                      controller: _noFromDayController,
                      decoration: InputDecoration(
                        labelText: 'أدخل عدد الأيام',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                      color: Color(0xaf2131da),
                      onPressed: _calculateDaysAfterDate, child: Text('احسب تاريخ العودة',style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w300,
                      fontSize: 24,color: Colors.white),)),


                  Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xffF5F5F5),
                      ),
                      child: Text(
                        _noFromDayresult,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      )),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

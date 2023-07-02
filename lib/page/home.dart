import 'dart:async';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_smart_home/service/api.dart';

import 'package:intl/intl.dart';

import '../widgets/dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List> room1 = [
    ['lamp', 'Lamp Bed', 20],
    ['lamp', 'Lamp 2', 21],
    ['fan', 'Fan 1', 16]
  ];
  List<List> room2 = [
    ['fan', 'Fan 1', 16],
    ['speaker', 'speaker', 21],
    ['tv', 'TV', 21],
    ['lamp', 'Lamp Bed', 20],
    ['lamp', 'Lamp 2', 20],
  ];
  List<List> room3 = [
    ['speaker', 'speaker', 21],
    ['tv', 'TV', 21],
    ['lamp', 'Lamp Bed', 20],
    ['lamp', 'Lamp 2', 20],
    ['fan', 'Fan 1', 16],
  ];
  Timer? timer;
  Timer? timerTimp;
  Timer? timerStatusServer;
  int roomNumber = 1;
  int statusServerbool = -11;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDateTime();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    startTime();
    // });
  }

  @override
  void dispose() {
    // context.read<AppState>().controllerCenter.dispose();
    timer!.cancel();
    timerTimp!.cancel();
    timerStatusServer!.cancel();
    super.dispose();
  }

  String time = '';
  String date = '';
  String nameDay = '';
  setDateTime() {
    DateTime now = DateTime.now();
    setState(() {
      time = DateFormat('jms').format(now);
      date = DateFormat('dd/MM/yyyy').format(now);
      nameDay = DateFormat('EEEEE', 'en_US').format(now);
    });
  }

  void startTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => setDateTime());
    timerTimp = Timer.periodic(const Duration(seconds: 15), (_) => getTimp());
    timerStatusServer =
        Timer.periodic(const Duration(seconds: 5), (_) => statusServer());
  }

  String timp = '0';
  void getTimp() async {
    var data = await ApiConnect().getTemp(17);
    setState(() {
      timp =  data.toString();
    });
  }

  void statusServer() async {
    var data = await ApiConnect().getStateServer();
    setState(() {
      // if (data != null) {
        if (data < 0) {
          statusServerbool = data;
        } else {
          statusServerbool = 1;
        }
      // } else {
      //   statusServerbool = -1;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(26, 67, 77, 0.1),
                        borderRadius: BorderRadius.circular(16)),
                    width: MediaQuery.of(context).size.width,
                    height: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset('assets/sun.png'),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Almost Cloudy'),
                            10.ph,
                            const Text(
                              '32 °C',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              time,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w100),
                            ),
                            Text(
                              nameDay,
                            ),
                            Text(
                              date,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  10.ph,
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(26, 67, 77, 0.1),
                        borderRadius: BorderRadius.circular(16)),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 41,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/timp.png',
                            ),
                            10.pw,
                            const Text('Room Temperature'),
                          ],
                        ),
                        Text(timp == 'null' ? '0 °C ' : '$timp °C')
                      ],
                    ),
                  ),
                  10.ph,
                  Expanded(
                    flex: 10,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: roomNumber == 1
                            ? room1.length
                            : roomNumber == 2
                                ? room2.length
                                : room3.length,
                        itemBuilder: (context, index) {
                          var data = roomNumber == 1
                              ? room1
                              : roomNumber == 2
                                  ? room2
                                  : room3;
                          return card(
                              data[index][2], data[index][0], data[index][1]);
                        }),
                  ),
                  104.ph
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 113,
                color: const Color(0xffF9F9F9),
                child: Row(
                  children: [
                    50.pw,
                    buttonroom('room 1', () {
                      setState(() {
                        if (roomNumber != 1) {
                          roomNumber = 1;
                        }
                      });
                    }, active: roomNumber == 1),
                    // 50.pw,
                    buttonroom(
                      'room 2',
                      () {
                        setState(() {
                          if (roomNumber != 2) {
                            roomNumber = 2;
                          }
                        });
                      },
                      active: roomNumber == 2,
                    ),
                    // 50.pw,
                    buttonroom(
                      'room 3',
                      () {
                        setState(() {
                          if (roomNumber != 3) {
                            roomNumber = 3;
                          }
                        });
                      },
                      active: roomNumber == 3,
                    ),
                    50.pw
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 10,
              child: InkWell(
                onTap: () {
                  showDialog(context: context,
                   barrierDismissible: false,
                  builder: (BuildContext context){
                  return const CustomDialogBox(
                  );});
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(0xff1A434D),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      statusServerbool == -1
                          ? Image.asset('assets/noconnect.png')
                          : statusServerbool == -11
                              ? Image.asset('assets/clickconnect.png')
                              : Image.asset('assets/connect.png'),
                      5.ph,
                      statusServerbool == -1
                          ? const Text(
                              'Failed to\nConnect',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            )
                          : statusServerbool == -11
                              ? const Text(
                                  ' Click to\nConnect',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                )
                              : const Text(
                                  'Connected',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonroom(String title, Function() onTap, {bool active = false}) {
    return Container(
      padding: const EdgeInsets.only(right: 50),
      child: InkWell(
        onTap: onTap,
        child: Opacity(
          opacity: active ? 1 : 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Image.asset('assets/room.png'), Text(title)],
          ),
        ),
      ),
    );
  }

  Map type_dvice = {
    'fan': [
      const Color(0xffFAF3EB),
      'Fan',
      'fan.png',
      const Color.fromRGBO(228, 192, 151, 1),
    ],
    'lamp': [
      const Color(0xffE6DEF6),
      'Bed Lamp',
      'lamp.png',
      const Color.fromRGBO(166, 153, 197, 1),
    ],
    'speaker': [
      const Color(0xffF4FBE2),
      'Speaker',
      'speaker.png',
      const Color.fromRGBO(174, 217, 73, 1),
    ],
    'tv': [
      const Color(0xffE9FAED),
      'TV',
      'tv.png',
      const Color.fromRGBO(93, 189, 126, 1),
    ]
  };
  Widget card(int pin, String type, String title) {
    return InkWell(
      onTap: () async {
        var statusDevice = await ApiConnect().getStatusDevice(pin);
        if (statusDevice != -1) {
          if (statusDevice == 0) {
            await ApiConnect().onDevice(pin);
          } else {
            await ApiConnect().offDevice(pin);
          }
        } else {
          log('error');
        }
        // http.Response response = await http.get(Uri.parse(uri+pin.toString()));
      },
      child: Container(
        width: 163.5,
        height: 163.5,
        decoration: BoxDecoration(
            color: type_dvice[type][0],
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/' + type_dvice[type][2]),
            10.ph,
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: type_dvice[type][3]),
            )
          ],
        ),
      ),
    );
  }
}

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}

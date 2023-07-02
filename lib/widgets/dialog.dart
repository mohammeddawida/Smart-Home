import 'package:flutter/material.dart';
import 'package:flutter_application_smart_home/page/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox(
      {super.key});

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final TextEditingController _url = TextEditingController();
  final TextEditingController _port = TextEditingController();
  String url ='';
  String port ='';
  geturlstorg()async{
    final prefs = await SharedPreferences.getInstance();
    final String? url2 = prefs.getString('url');
    final String? port2 = prefs.getString('port');
    if(url2 != null){
      setState(() {
        url = url2;
      });
    }
    if(port2 != null){
      setState(() {
        port = port2;
      });
    }else{
      setState(() {
        port = '8080';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
   
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: Constants.padding,
              top: 10,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _url,
                      initialValue: url,
                      decoration: InputDecoration(
                        labelText: 'Url',
                        hintText: 'http://192.168.1.148'
                      ),
                    ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _port,
                      decoration: InputDecoration(
                        labelText: 'Port',
                        hintText: '8080'
                      ),
                      initialValue: port,
                      
                    ))
                ],
              ),
              15.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: ()async{
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('url',_url.text);
                    await prefs.setString('port',_port.text);
                      Navigator.pop(context);
                  }, child: Text('Save')),
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('Cancel')),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
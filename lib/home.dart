import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:covid_19/API/api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;
  String countryname="All";
  bool isloading=false;
  List country=[];
  String totalcase="0";
  String infectedcase="0";
  String deathcase="0";
  String recoveredcase="0";
  String newcase="0";
  String activecase="0";
  String criticalcase="0";
  String newdeathcase="0";
  String testtotal="0";
  String day="";
  String time="";
  List stat=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
    setState(() {
      isloading=true;
    });
//    countryname="All";
    initializedata();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }
  initializedata(){
    totalcase="0";
    infectedcase="0";
    deathcase="0";
    recoveredcase="0";
    newcase="0";
    activecase="0";
    criticalcase="0";
    newdeathcase="0";
    testtotal="0";
    day="";
    time="";
    setState(() {
      isloading=true;
    });
    list_country.getdata().then((userdata)async{

      setState(() {
        country=userdata;
      });
      list_data.getdata().then((data){
        setState(() {
          stat=data;
        });

        for(int i=0;i<stat.length;i++){

          if(countryname==stat[i]['country']){
            setState(() {
              totalcase=stat[i]['cases']['total'].toString();
              recoveredcase=stat[i]['cases']['recovered'].toString();
              newcase=stat[i]['cases']['new'].toString();
              activecase=stat[i]['cases']['active'].toString();
              criticalcase=stat[i]['cases']['critical'].toString();
              newdeathcase=stat[i]['deaths']['new'].toString();
              deathcase=stat[i]['deaths']['total'].toString();
              testtotal=stat[i]['tests']['total'].toString();
              day=stat[i]['day'].toString();
              time=stat[i]['time'].toString();
            });
            break;
          }

        }
        setState(() {
          isloading=false;
        });
      }).catchError((Object error){
        isloading = false;
      });
    }).catchError((Object error){
      isloading = false;
    });

  }
  filterdata(){
    totalcase="0";
    infectedcase="0";
    deathcase="0";
    recoveredcase="0";
    newcase="0";
    activecase="0";
    criticalcase="0";
    newdeathcase="0";
    testtotal="0";
    day="";
    time="";
    setState(() {
      isloading=true;
    });
    for(int i=0;i<stat.length;i++){
      print(stat[i]);
      if(countryname==stat[i]['country']){
        print(countryname);
        totalcase=stat[i]['cases']['total'].toString();
        recoveredcase=stat[i]['cases']['recovered'].toString();
        newcase=stat[i]['cases']['new'].toString();
        activecase=stat[i]['cases']['active'].toString();
        criticalcase=stat[i]['cases']['critical'].toString();
        newdeathcase=stat[i]['deaths']['new'].toString();
        deathcase=stat[i]['deaths']['total'].toString();
        testtotal=stat[i]['tests']['total'].toString();
        day=stat[i]['day'].toString();
        time=stat[i]['time'].toString();
      }

    }
    setState(() {
      isloading=false;
    });

  }



  @override
  Widget build(BuildContext context) {
    final mainLayout=SingleChildScrollView(
        controller: controller,
        child:Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "You just Need",
              textBottom: "to stay at home.",
              offset: offset,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                      value: countryname,
                      items: country.map<DropdownMenuItem<dynamic>>((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          countryname=value;
                        });
                        filterdata();

                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Case Update\n",
                              style: kTitleTextstyle,
                            ),
                            TextSpan(
                              text: "Newest update ${time.split("T")[0]} ${time.split("T")[1].split("+")[0]}",
                              style: TextStyle(
                                color: kTextLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        "See details",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Counter(
                              color: kInfectedColor,
                              sizeup:1.5,
                              number: totalcase=="null"?int.parse("0"):int.parse(totalcase),
                              title: "Total Cases",
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Counter(
                              color: kInfectedColor,
                              number: activecase=="null"?int.parse("0"):int.parse(activecase),
                              sizeup: 1.2,
                              title: "Infected",
                            ),
                            Counter(
                              color: kDeathColor,
                              number: deathcase=="null"?int.parse("0"):int.parse(deathcase),
                              sizeup: 1.2,
                              title: "Deaths",
                            ),
                            Counter(
                              color: kRecovercolor,
                              number: recoveredcase=="null"?int.parse("0"):int.parse(recoveredcase),
                              sizeup: 1.2,
                              title: "Recovered",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Counter(
                              color: kInfectedColor,
                              number: newcase=="null"?int.parse("0"):int.parse(newcase),
                              sizeup: 1,
                              title: "New Case",
                            ),
                            Counter(
                              color: kDeathColor,
                              number: newdeathcase=="null"?int.parse("0"):int.parse(newdeathcase),
                              sizeup: 1,
                              title: "New Death",
                            ),
                            Counter(
                              color: kRecovercolor,
                              number: testtotal=="null"?int.parse("0"):int.parse(testtotal),
                              sizeup: 1,
                              title: "Total Tests",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Spread of Virus",
                        style: kTitleTextstyle,
                      ),
                      Text(
                        "See details",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(20),
                    height: 178,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/map.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));

    return Scaffold(
      body: ModalProgressHUD(child: mainLayout, inAsyncCall: isloading, color: Colors.grey,),

    );
  }
}
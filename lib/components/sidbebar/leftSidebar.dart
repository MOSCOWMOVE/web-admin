// ignore_for_file: file_names, unnecessary_cast

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:moscow_move_mobile/components/CheckBox.dart';
import 'package:moscow_move_mobile/components/Spoiler.dart';
import 'package:moscow_move_mobile/components/SportZoneInfo.dart';
import 'package:moscow_move_mobile/components/Text.dart';
import 'package:moscow_move_mobile/components/sidbebar/BaseSidebar.dart';
import 'package:universal_html/html.dart';
import 'package:csv/csv.dart';
import "dart:html";


import '../../fetch.dart';


class SportArea{
  SportArea({this.name, this.sport_org, this.cords, this.sport_types, this.square, this.address}):super();

  String name;
  String sport_org;
  List<double> cords;
  List<String> sport_types;
  double square;
  String address;
  
}

class AreaSelector{

  AreaSelector({this.name, this.selected}):super();

  String name;
  bool selected;
}


class LeftSidebar extends StatefulWidget {
  const LeftSidebar({ Key key }) : super(key: key);

  @override
  _LeftSidebarState createState() => _LeftSidebarState();
}

class _LeftSidebarState extends State<LeftSidebar> {


  LEFT_SIDEBAR_STATE activeState = LEFT_SIDEBAR_STATE.viewing;

  String active_id = "";
  Map<String, Widget> children = {};
  List<SportArea> areas = [];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    
    window.onMessage.listen((event) { 
      print(event.data);

      setState(() {
        children = {};
        areas = [];
      });
      if (active_id == event.data.toString()) return; 
      active_id = event.data.toString();


      List<String> ids = [event.data.toString()];


      if (event.data.contains(",")) {
        ids = event.data.toString().split(",");
      }


      for (int i = 0; i < ids.length; ++i) {
        fetch("api/get_sport_zone/"+ids[i]).then((e) async {
          String cords = "";
          String name = "";
          String square = "";
          String address = "";
          String dep_org = "";
          String sport_types = "";
          SportArea area = SportArea(name: "", address: "", square: 0, sport_types: [], sport_org: "", cords: []);

          area.cords = [e["position"]["longitude"], e["position"]["latitude"]];
          area.name = e["name"];
          area.square = e["square"];
          area.address = e["address"];
      //print(e);
          cords = [e["position"]["longitude"].toString(), e["position"]["latitude"].toString()].join(", ");
          name = e["name"];
          square = e["square"].toString();
          address = e["address"];
          await fetch("api/departmental_org/"+e["organization"].toString()).then((orgName) {
            //print(orgName);
            area.sport_org = orgName["name"];
            dep_org = orgName["name"];
          });
          
          for (int i = 0; i < (e["sportTypes"] as List<dynamic>).length; ++i) {
            print(i);
            await fetch(
              "api/get_sport_type/"+e["sportTypes"][i].toString()
            ).then((e) {
              area.sport_types.add(e["name"]);
              sport_types = sport_types + (sport_types.isEmpty ? "" : ", ") + e["name"];
            });
          }
          setState(() {
            areas.add(area);
            children.addAll({name: SportZoneInfo(
                name: name,
                sport_types: sport_types,
                cords: cords,
                square: square,
                address: address,
                dep_org: dep_org,
              )});
          });
        });
      }

    });
    Map<String, Widget> widgets = {};

    for (var i = 0; i < areas.length; ++i) {
      widgets.addAll({areas[i].name: SportZoneInfo(
        name: areas[i].name, 
        dep_org: areas[i].sport_org,
        address: areas[i].address,
        sport_types: areas[i].sport_types.join(", "),
        cords: areas[i].cords.join(", "),
        square: areas[i].square.toString(),
      )});
    }

    print(widgets);
    return BaseSidebar(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  activeState = LEFT_SIDEBAR_STATE.viewing;
                });
              },
              child: Mytext(
                text: "Информация", 
                fontWeight: FontWeight.w700, 
                fontSize: 12,
                color: (activeState == LEFT_SIDEBAR_STATE.viewing ? Color(0xff2B2DBA) : Color(0xff6D6E92))),
            ),
            Container(width: 24),
            GestureDetector(
              onTap: () {
                setState(() {
                  activeState = LEFT_SIDEBAR_STATE.inspecting;
                });
              },
              child: Mytext(
                text: "Аналитика", 
                fontWeight: FontWeight.w700, 
                fontSize: 12, 
                color: (activeState == LEFT_SIDEBAR_STATE.inspecting ? Color(0xff2B2DBA) : Color(0xff6D6E92)),),
            )            
          ],
        ),
        Container(
              margin: EdgeInsets.only(top:12, bottom: 24),
              height: 2,
              color: Color(0xffF3F3F3),
        ),
        activeState == LEFT_SIDEBAR_STATE.viewing ?
        ViewingState(
          children: widgets
        ) : InspectingState(widgets: areas,)
      ],
      isRight: false,
    );
  }
}


class InspectingState extends StatefulWidget {
  InspectingState({ Key key, this.widgets }) : super(key: key);

  List<SportArea> widgets;

  @override
  _InspectingStateState createState() => _InspectingStateState(widgets: widgets);
}

class _InspectingStateState extends State<InspectingState> {
  _InspectingStateState({this.widgets});
  
  
  bool isAnySelected = true;
  List<SportArea> widgets = [];
  bool is_filtering = false;

  void initState() {
    print(widget.widgets);
    setState(() {
      this.widgets = widget.widgets;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> InspectInDetailInfo;
    Map<String, String> CalculateDetailInfo;
    Map<String, int> RecomendationDetailInfo;

    if (widget.widgets != this.widgets && is_filtering == false) {
      setState(() {
        widgets = widget.widgets;
      });
    }

    if (widget.widgets.isEmpty) {
      isAnySelected = true;
    }

    if (this.widgets.isEmpty) {
      InspectInDetailInfo = {
        "Количество объектов" : 0,
        "Площадь спортивных зон": 0,
        "Количество спортивных зон": 0,
        "Количество видов спорта": 0
      };
      CalculateDetailInfo = {
        "Площадь зон": "0",
        "Количество зон": "0",
        "Количество видов спорта": "0"
      };
      RecomendationDetailInfo = {
        "Площадь зон, м2": 0,
        "Количество зон": 0,
        "Количество видов спорта": 0
      };
    }
    else {
      InspectInDetailInfo = {
        "Количество объектов" : widgets.length,
        "Площадь спортивных зон": (widgets.map((e) => e.square).reduce((value, element) => value+element)).round(),
        "Количество спортивных зон": widgets.length,
        "Количество видов спорта": (widgets.map((e) => e.sport_types).expand((element) => element).toList().length)
      };
      CalculateDetailInfo = {
        "Площадь зон": (widgets.map((e) => e.square).reduce((value, element) => element+value)/(widgets.length*3)).toStringAsFixed(3),
        "Количество зон": ((widgets.length)/(widget.widgets.length*3)).toStringAsFixed(3),
        "Количество видов спорта": ((widgets.map((e) => e.sport_types).expand((element) => element).toList().length)/(widgets.length*3)).toStringAsFixed(3)
      };
      RecomendationDetailInfo = {
        "Площадь зон, м2": 134,
        "Количество зон": 3,
        "Количество видов спорта": 10
      };
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        isAnySelected ? SelectedAreasCalculate(
          areasName: widget.widgets.map((e) => AreaSelector(name:e.name, selected: widgets.contains(e))).toList(),
          onChange: (List<AreaSelector> selectors) {
            //print(selectors.map((e) => e.selected).join((", ")));
            setState(() {
              widgets = widget.widgets.where((e) => selectors.firstWhere((element) => element.name == e.name).selected).toList();
              is_filtering = true;
            });
          }
        ) :
        Mytext(
          text: "Для проведения анализа и открытия доступа к экспорту информации выберите объект(ы) ",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xff6D6E92)
        ),
        Container(
          margin: EdgeInsets.only(top: 32),
          color: Color(0xffEFEFEF),
          height: 2,
        ),
        Container(height: 18,),
        CalculateHeader(name: "Подробно", onClick: () {
          toCsv([[
            InspectInDetailInfo["Количество объектов"].toString(),
            InspectInDetailInfo["Площадь спортивных зон"].toString(),
            InspectInDetailInfo["Количество спортивных зон"].toString(),
            InspectInDetailInfo["Количество видов спорта"].toString()
          ]], [
            "Количество объектов", 
            "Площадь спортивных зон", 
            "Количество спортивных зон", 
            "Количество видов спорта"]);
        },),
        Container(height: 24,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [     
            Mytext(
              text: "Выберите объект(ы)",
              color: Color(0xff23245C),
              underline: true,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ]
        ),
        ...InspectInDetailInfo.keys.map((key) {
          return CalculateWidget(name: key, value: InspectInDetailInfo[key].toString());
        }),

        Container(
          margin: EdgeInsets.only(top: 32),
          color: Color(0xffEFEFEF),
          height: 2,
        ),
        Container(
          height: 24
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Mytext(
                  text: "Расчет",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xff23245C),

                ),
                Container(width: 8),
                Mytext(
                  text: "на 100 тыc. чел.",
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff6D6E92)
                )
              ],
            ),
            GestureDetector(
              child: Mytext(
                text: "Экспорт",
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xff2B2DBA),
                underline: true,
              ),
              onTap: () {
                toCsv(
                  [[
                    CalculateDetailInfo["Площадь зон"].toString(),
                    CalculateDetailInfo["Количество зон"].toString(),
                    CalculateDetailInfo["Количество видов спорта"].toString()
                  ]],
                  ["Площадь зон", "Количество зон", "Количество видов спорта"]
                );
              }
            )
            
          ],
        ),
        ...CalculateDetailInfo.keys.map((key) {
          return CalculateWidget(name: key, value: CalculateDetailInfo[key].toString());
        }),
        Container(
          margin: EdgeInsets.only(top: 32),
          color: Color(0xffEFEFEF),
          height: 2,
        ),
        Container(
          height: 24
        ),
        CalculateHeader(name: "Рекомендации", onClick: () {
          toCsv(
            [[
              CalculateDetailInfo["Площадь зон"].toString(),
              CalculateDetailInfo["Количество зон"].toString(),
              CalculateDetailInfo["Количество видов спорта"].toString()
            ]],
            ["Площадь зон", "Количество зон", "Количество видов спорта"]
           );
        },),
        ...RecomendationDetailInfo.keys.map((e) => CalculateWidget(name: e, value: RecomendationDetailInfo[e].toString()))
      ]
    );
  }
}



class SelectedAreasCalculate extends StatelessWidget {
  SelectedAreasCalculate({ Key key, this.areasName, this.onChange }) : super(key: key);
  List<AreaSelector> areasName;
  Function onChange;
  @override
  Widget build(BuildContext context) {
    print(areasName);
    return Spoiler(
      name: "Объектов: " + areasName.length.toString(),
      child: Column(
        children: areasName.map((e) => 
          Container(
            child: MyCheckBox(
              length_dep: 30, 
              fontWeight: FontWeight.w600, 
              selected: e.selected, 
              text: e.name, 
              onChange: (bool sel) {
                areasName[areasName.indexOf(e)].selected = sel;
                this.onChange(areasName);
              },
            ),
            margin: EdgeInsets.only(
              top: e.name == this.areasName[0].name ? 0 : 16
            )
          )).toList() as List<Widget>
      ),
    );
  }
}


class CalculateHeader extends StatelessWidget {
  CalculateHeader({ Key key, this.name, this.onClick }) : super(key: key);
  
  String name;
  Function onClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Mytext(
          text: this.name,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xff23245C)
        ),
        GestureDetector(
          child: Mytext(
            text: "Экспорт",
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xff2B2DBA),
            underline: true,
          ),
          onTap: this.onClick,
        )
        
      ]
    );
  }
}

class CalculateWidget extends StatelessWidget {
  CalculateWidget({ Key key, this.name, this.value }) : super(key: key);
  String name;
  String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Mytext(
            text: name,
            color: Color(0xff6D6E92),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          Mytext(
            text: value,
            color: value == "0" ? Color(0xff6D6E92) : Color(0xff1672EC),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          )
        ],
      )
    );
  }
}


class ViewingState extends StatelessWidget {
  ViewingState({ Key key, this.children }) : super(key: key);

  Map<String, Widget> children;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
          height: height-100,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              children: children.keys.map((key) { 
                if (children.length > 1) {
                  return Container(
                    child: Spoiler(
                      child: children[key],
                      name: key
                    ),
                    margin: const EdgeInsets.only(bottom: 1),
                  );
                }
                else {
                  return Container(child: children[key]);
                }
              }
              ,).toList(),
            ),
          ) 
        );
  }
}


enum LEFT_SIDEBAR_STATE{
  viewing,
  inspecting 
}


void toCsv(List<List<String>> inputs, List<String> headers) {
  var csv = ListToCsvConverter().convert([headers, ...inputs]);
  var file = Blob([csv], "text/plain", "native");
  var anchorElement = AnchorElement(
      href: Url.createObjectUrlFromBlob(file).toString(),
   )..setAttribute("download", "data.csv")..click();
}
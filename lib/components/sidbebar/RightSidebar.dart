// ignore_for_file: file_names, unnecessary_cast

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moscow_move_mobile/PointOperations.dart';
import 'package:moscow_move_mobile/components/DropDownLists/BaseFilterDropDownList.dart';
import 'package:moscow_move_mobile/components/Text.dart';
import 'package:moscow_move_mobile/components/sidbebar/BaseSidebar.dart';
import 'package:http/http.dart' as http;
import 'package:moscow_move_mobile/fetch.dart';





class RightSidebar extends StatefulWidget {
  const RightSidebar({ Key key }) : super(key: key);

  @override
  _RightSidebarState createState() => _RightSidebarState();
}

class _RightSidebarState extends State<RightSidebar> {

  List<String> sportTypes = [];
  List<String> moscowDistricts = [];
  List<String> dep_orgs = [];

  List<String> sportTypesFilter = [];
  List<String> accessibilityFilter = [];
  List<String> depOrgsFilter = [];
  List<String> openedTypeFilter = [];

  void setFilteredPoints() {
    String types_sort_template = "";
    if (sportTypesFilter.isNotEmpty) {
      types_sort_template = "types="+sportTypesFilter.join(",");
    }
    String accessibility_sort_template = "";
    if (accessibilityFilter.isNotEmpty) {
      accessibility_sort_template = "accessibility="+accessibilityFilter.join(",");
    }
    String dep_orgs_sort_template = "";
    if (depOrgsFilter.isNotEmpty) {
      dep_orgs_sort_template = "dep_name="+depOrgsFilter.join(",");
    }
    String opened_type_template = "";
    if (openedTypeFilter.isNotEmpty) {
      opened_type_template = "opened_types="+openedTypeFilter.join(","); 
    }
    
    fetch_pagination("api/sort_zones?"+types_sort_template+
    (types_sort_template.isNotEmpty ? "&" : "")
    +accessibility_sort_template+
    (accessibility_sort_template.isNotEmpty ? "&" : "")+
    dep_orgs_sort_template+
    (opened_type_template.isNotEmpty ? "&" : "")+
    opened_type_template
    ).then((value) {
      SetPoints(
        (value as List<dynamic>).map((e) {
          return Point(
              id: e["zone_id"], 
              cords: [e["position"]["longitude"], 
              e["position"]["latitude"]], 
              type: e["accessibility"]["distance"], 
              area: e["square"]);
          }).toList() as List<Point>);
        });
    }
  
  void initState() {
    fetch_pagination("api/sport_types").then((e) => {
      setState(() {
        sportTypes.addAll((e as List<dynamic>).map((e) => (e["name"] as String)).toList());
      })
    });
    fetch_pagination("api/people_density").then((e) {
      setState(() {
        moscowDistricts.addAll((e as List<dynamic>).map((e) => (e["name"] as String)).toList());
      });
    });
    fetch_pagination("api/departmental_orgs").then((e) {
      setState(() {
        dep_orgs.addAll((e as List<dynamic>).map((e) => (e["name"] as String)).toList());
      });
    });

  }
  
  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    return BaseSidebar(
      children: [
        SvgPicture.asset("assets/logo.svg"),
        Container(
          child: Mytext(
            text: "Главная",
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
          margin: const EdgeInsets.only(top: 35)
        ),
        SizedBox(
          height: height - 175 - 10,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Container(
                        child: BaseFilterDropDownList(
                          checkboxes: sportTypes,
                          name: "Виды спорта",
                          onChange: (List<String> selected) {
                            sportTypesFilter = selected;
                            setFilteredPoints();
                          },
                        ),
                        margin: const EdgeInsets.only(
                          top: 30
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30
                        ),
                        child: BaseFilterDropDownList(
                          checkboxes: moscowDistricts,
                          name: "Районы",
                          onChange: (List<String> selected) {
                            
                          },
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30
                        ),
                        child: BaseFilterDropDownList(
                          checkboxes: dep_orgs,
                          name: "Ведомства",
                          onChange: (List<String> selected) {
                            depOrgsFilter = selected;
                            setFilteredPoints();
                          },
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30
                        ),
                        child: BaseFilterDropDownList(
                          checkboxes: ["Открытое", "Крытое", "Бассейн"],
                          name: "Тип зоны",
                          onChange: (List<String> selected) {
                            openedTypeFilter = selected;
                            setFilteredPoints();
                          },
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30
                        ),
                        child: BaseFilterDropDownList(
                          checkboxes: ["500", "1000", "3000", "5000"],
                          name: "Доступность",
                          onChange: (List<String> selected) {
                            accessibilityFilter = selected;
                            setFilteredPoints();
                          },
                        )
                      ),
                    ]
                  ),
                )
              ],
            )
          ) 
        ),

      ],
      isRight: true,
    );
  }
}
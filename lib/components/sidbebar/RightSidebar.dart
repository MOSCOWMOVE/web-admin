// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  Future<dynamic> getPointPaginationData(String url) {
    fetch(url).then(
      (value)  {
        if (value["next"] != null) {
          getPointPaginationData(value["next"]);
        }
        setState(() {
          sportTypes.addAll((value["results"] as List<dynamic>).map((e) => e["name"]));
        });
        }
      );
  }

  void initState() {
    getPointPaginationData("api/sport_types");
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
                          name: "Виды спорта"
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
                          checkboxes: ["Центральный", "Центральный", "Центральный"],
                          name: "Районы"
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30
                        ),
                        child: BaseFilterDropDownList(
                          checkboxes: ["Федерация спорта", "Федерация спорта", "Федерация спорта"],
                          name: "Ведомства"
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30
                        ),
                        child: BaseFilterDropDownList(
                          checkboxes: ["Открытая", "Закрытая", "Бассейн"],
                          name: "Тип зоны"
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30
                        ),
                        child: BaseFilterDropDownList(
                          checkboxes: ["500", "1000", "3000", "5000"],
                          name: "Доступность"
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
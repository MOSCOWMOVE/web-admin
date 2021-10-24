// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:moscow_move_mobile/components/Text.dart';

class SportZoneInfo extends StatelessWidget {
  var dep_org;

  var name;

  var sport_types;

  var square;

  var address;

  var cords;

  SportZoneInfo({ Key key, this.name, this.dep_org, this.address, this.sport_types, this.cords, this.square }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Mytext(
            text: this.name,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xff23245C),
          )
        ),
        Container(
          margin: EdgeInsets.only(top: 35, bottom: 3),
          child: Mytext(
            text: "Подведомственность",
            fontSize: 12,
            color: Color(0xff2B2DBA),
          )
        ),
        Mytext(
          text: this.dep_org,
          fontSize: 12,
          color: Color(0xff23245C),
          centered: false,
        ),
        Container(
          margin: EdgeInsets.only(top: 35, bottom: 3),
          child: Mytext(
            text: "Типы спортивных зон",
            fontSize: 12,
            color: Color(0xff2B2DBA),
          )
        ),
        Mytext(
          text: this.sport_types,
          fontSize: 12,
          color: Color(0xff23245C),
          centered: false,
        ),
        Container(
          margin: EdgeInsets.only(top: 35, bottom: 3),
          child: Mytext(
            text: "Площадь",
            fontSize: 12,
            color: Color(0xff2B2DBA),
          )
        ),
        Mytext(
          text: this.square,
          fontSize: 12,
          color: Color(0xff23245C),
          centered: false,
        ),
        Container(
          margin: EdgeInsets.only(top: 35, bottom: 3),
          child: Mytext(
            text: "Адрес",
            fontSize: 12,
            color: Color(0xff2B2DBA),
          )
        ),
        Mytext(
          text: address,
          fontSize: 12,
          color: Color(0xff23245C),
          centered: false,
        ),
        Container(
          margin: EdgeInsets.only(top: 35, bottom: 3),
          child: Mytext(
            text: "Координаты (Lat, Long)",
            fontSize: 12,
            color: Color(0xff2B2DBA),
          )
        ),
        Mytext(
          text: this.cords,
          fontSize: 12,
          color: Color(0xff23245C),
          centered: false,
        )
      ]
    );
  }
}
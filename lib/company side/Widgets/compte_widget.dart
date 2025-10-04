import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class CompteWidget extends StatelessWidget {
  final String codeClient;
  final String nomClient;
  final String Catrgorie;
  final String createur;
  final String date;
  final String etat;

  const CompteWidget({
    super.key,
    required this.codeClient,
    required this.createur,
    required this.Catrgorie,
    required this.nomClient,
    required this.date,
    required this.etat,
  });
  @override
  Widget build(BuildContext context) {
  return Container(
  width: 1600,
  height: 100,
  decoration: BoxDecoration(
  color: Appstyle.blanc,
  borderRadius: BorderRadius.circular(16),
  ),
  child: Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  Column(children: [
  Text(
  "Date", // "0.33Cl"
  style: Appstyle.textM.copyWith(color: Appstyle.grisC),
  ),
  Text(
  date, // "0.33Cl"
  style: Appstyle.textL_B.copyWith(color: Appstyle.noir),
  textAlign: TextAlign.center,
  ),

  ],),
  Column(children: [
  Text(
  "Code Client", // "0.33Cl"
  style: Appstyle.textM.copyWith(color: Appstyle.grisC),
  ),  Text(
  codeClient, // "181 Palette"
  style: Appstyle.textL_B.copyWith(color: Appstyle.blueF),
  textAlign: TextAlign.center,
  ),

  ],),
  Column(children: [
  Text(
  "Username", // "0.33Cl"
  style: Appstyle.textM.copyWith(color: Appstyle.grisC),
  ),
  Text(
  nomClient, // "181 Palette"
  style: Appstyle.textL_B.copyWith(color: Appstyle.noir),
  textAlign: TextAlign.center,
  ),
  ],),
  Column(children: [
  Text(
  "Status", // "0.33Cl"
  style: Appstyle.textM.copyWith(color: Appstyle.grisC),
  ),
  Text(
  etat, // "181 Palette"
  style: Appstyle.textL_B.copyWith(color: Appstyle.blueC),
  textAlign: TextAlign.center,
  ),
  ],),
  Column(children: [
  Text(
  "Categorie", // "0.33Cl"
  style: Appstyle.textM.copyWith(color: Appstyle.grisC),
  ),Text(
  Catrgorie, // "181 Palette"
  style: Appstyle.textL_B.copyWith(color: Appstyle.noir),
  textAlign: TextAlign.center,
  ),
  ],),
  Column(children: [
  Text(
  "Cree par", // "0.33Cl"
  style: Appstyle.textM.copyWith(color: Appstyle.grisC),
  ), Text(
  createur, // "181 Palette"
  style: Appstyle.textL_B.copyWith(color: Appstyle.noir),
  textAlign: TextAlign.center,
  ),
  ],),
  ],
  ),
  ),
  );
  }
  }

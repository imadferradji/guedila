import 'package:qanaty/core/theme/app_style.dart';


import 'models/produit.dart';

List<Produit> produits = [
  Produit(
    nom: "Bouteille 1.5 L",
    image: "assets/icons/eau_15l_icon.png",
    bouteillesParPalette: 100,
    prix: 22800,
    abrev: "1.5L", color: Appstyle.pie_creme,

  ), Produit(
    nom: "Bouteille 0.5 L",
    image: "assets/icons/eau_15l_icon.png",
    bouteillesParPalette: 100,
    prix: 22800,
    abrev: "0.5L", color: Appstyle.pie_orange,

  ),
  Produit(
    nom: "Bouteille 1 L",
    image: "assets/icons/eau_1l_icon.png",
    bouteillesParPalette: 120,
    prix: 18000,
    abrev: "1L", color: Appstyle.pie_blueC,
  ),
  Produit(
    nom: "Bouteille 2 L",
    image: "assets/icons/eau_2l_icon.png",
    bouteillesParPalette: 80,
    prix: 25000,
    abrev: "2L", color: Appstyle.pie_blueF,
  ),
  Produit(
    nom: "Bouteille 0.33 Cl",
    image: "assets/icons/eau_33l_icon.png",
    bouteillesParPalette: 80,
    prix: 25000,
    abrev: "0.33L", color: Appstyle.pie_move,
  ),
  Produit(
    nom: "Bouteille 0.33 L Sport",
    image: "assets/icons/eau_33l_sport_icon.png",
    bouteillesParPalette: 80,
    prix: 25000,
    abrev: "0.33L S", color: Appstyle.pie_grena,
  ),
  Produit(
    nom: "Bouteille 0.5 L Sport",
    image: "assets/icons/eau_05l_sport_icon.png",
    bouteillesParPalette: 80,
    prix: 25000,
    abrev: "0.5L S", color: Appstyle.pie_vert,
  ),
];

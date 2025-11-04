import 'models/planning.dart';
import 'produits.dart';

List<Planning> plannings = [
  Planning(
    date: '2025-10-22',
    produit: produits[0].abrev, // 1.5L
    quantite: '600',
    etat: 'Actif',
    slots: [100, 100, 100, 100, 100, 000, 000, 100], // ➕ Exemple de créneaux
  ),
  Planning(
    date: '2025-10-22',
    produit: produits[2].abrev, // 1L
    quantite: '8000',
    etat: 'Désactivé',
    slots: [1000, 1000, 1500, 0, 1500, 0, 1000, 2000],
  ),
  Planning(
    date: '2025-10-23',
    produit: produits[1].abrev, // 0.5L
    quantite: '4000',
    etat: 'Désactivé',
    slots: [500, 500, 500, 500, 500, 500, 500, 500],
  ),
  Planning(
    date: '2025-10-23',
    produit: produits[3].abrev, // 2L
    quantite: '6000',
    etat: 'Actif',
    slots: [750, 750, 750, 750, 750, 750, 750, 750],
  ),
  Planning(
    date: '2025-10-24',
    produit: produits[4].abrev, // 0.33L
    quantite: '4000',
    etat: 'Désactivé',
    slots: [500, 500, 500, 500, 500, 500, 500, 500],
  ),
  Planning(
    date: '2025-10-24',
    produit: produits[5].abrev, // 0.33L S
    quantite: '2000',
    etat: 'Actif',
    slots: [250, 250, 250, 250, 250, 250, 250, 250],
  ),
  Planning(
    date: '2025-10-25',
    produit: produits[6].abrev, // 0.5L S
    quantite: '3400',
    etat: 'Actif',
    slots: [600, 0, 400, 1000, 1000, 200, 100, 100],
  ),
];

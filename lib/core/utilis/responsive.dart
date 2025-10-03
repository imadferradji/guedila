class Responsive {
  static double sidebarWidth(double screenWidth) {
    return (screenWidth * 0.13).clamp(250, 350);
  }
  static double sidebarHeight(double screenHeight) {
    return (screenHeight * 0.9).clamp(700, 1200);
  }
  static double notificationSize(double screenHeight) {
    return (screenHeight * 0.04).clamp(22, 50);
  }
  static double produitVenduWidth(double screenWidth) {
    return (screenWidth * 0.1).clamp(120, 180);
  }
  static double produitVenduHeight(double screenHeight) {
    return (screenHeight * 0.11).clamp(130, 200);
  }
  static double virementHeight(double screenHeight) {
    return (screenHeight * 0.19).clamp(150, 400);
  }
  static double virementWidth(double screenHeight) {
    return (screenHeight * 0.23).clamp(350, 420);
  }


}

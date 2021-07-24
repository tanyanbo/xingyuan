enum TypeOfWish { INFO, PHYSICAL, ACTION }

class Wish {
  String title;
  int price;
  TypeOfWish type;
  late DateTime date;

  Wish({this.title = '', this.price = 0, this.type = TypeOfWish.INFO}) {
    this.date = DateTime.now();
  }
}

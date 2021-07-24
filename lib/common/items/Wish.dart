enum TypeOfWish { INFO, PHYSICAL, ACTION }

class Wish {
  String title;
  int price;
  TypeOfWish type;
  bool taken;
  bool completed;

  Wish(
      {this.title = '',
      this.price = 0,
      this.type = TypeOfWish.INFO,
      this.taken = false,
      this.completed = false});
}

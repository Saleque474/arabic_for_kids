import 'dart:math';

class Items {
  List<Item> items = [];

  initialize() {
    List<Item> _items = [];
    for (int i = 1; i < 29; i++) {
      Item ie = Item(i);
      ie.initialize();
      _items.add(ie);
    }
    _items.shuffle();
    items = _items;
  }
}

class Item {
  int index;
  Item(this.index);
  String get word => words[index - 1];
  String get image => "assets/images/$index.png";
  String get sound => "assets/sounds/$index.mp3";
  List<String> options = [];

  initialize() {
    Random rand = Random();
    List l = [
      "ﺃَﺳَﺪ",
      "بطة",
      "تفاح",
      "ثعبان",
      "جمال",
      "حمامة",
      "خروف",
      "دب",
      "ذرة",
      "رجل",
      "زراف",
      "سمك",
      "شجره",
      "صمدوك",
      "ضفدع",
      "طاووس",
      "ظرف",
      "علم",
      "غزلان",
      "فرولايه",
      "قرد",
      "كلب",
      "ليمون",
      "موز",
      "نحلة",
      "هرم",
      "ورد",
      "يد"
    ];
    l.remove(word);
    String op1 = l[rand.nextInt(26)];
    l.remove(op1);
    String op2 = l[rand.nextInt(25)];
    l.remove(op2);
    String op3 = l[rand.nextInt(24)];
    List<String> listOfOp = [word, op1, op2, op3];
    listOfOp.shuffle();
    options = listOfOp;
  }
}

List words = [
  "ﺃَﺳَﺪ",
  "بطة",
  "تفاح",
  "ثعبان",
  "جمال",
  "حمامة",
  "خروف",
  "دب",
  "ذرة",
  "رجل",
  "زراف",
  "سمك",
  "شجره",
  "صمدوك",
  "ضفدع",
  "طاووس",
  "ظرف",
  "علم",
  "غزلان",
  "فرولايه",
  "قرد",
  "كلب",
  "ليمون",
  "موز",
  "نحلة",
  "هرم",
  "ورد",
  "يد",
];

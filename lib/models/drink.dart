abstract class Drink {
  final String name;
  final double price;
  const Drink(this.name, this.price);
}

class GreenTea extends Drink {
  const GreenTea() : super('Green Tea', 10.0);
}

class BlackTea extends Drink {
  const BlackTea() : super('Black Tea', 10.0);
}

class Coffee extends Drink {
  const Coffee() : super('Coffee', 10.0);
}

class HotChocolate extends Drink {
  const HotChocolate() : super('Hot Chocolate', 30.0);
}

class HibiscusTea extends Drink {
  const HibiscusTea() : super('Hibiscus Tea', 20.0);
}

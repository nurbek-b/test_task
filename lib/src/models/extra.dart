

class Extra{
  String title;
  double price;
  int amount;
  double subTotal;

  Extra({
    this.title,
    this.price,
    this.amount = 0,
    this.subTotal = 0});
}


List<Extra> extras = [
  Extra(title: 'Приборы', price: 25.40),
  Extra(title: 'Соус Тар-Тар', price: 5.00),
  Extra(title: 'Соус Красный острый', price: 13.50),
  Extra(title: 'Соус матсухисо', price: 27.70),
];
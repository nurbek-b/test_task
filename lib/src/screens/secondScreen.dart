import 'package:flutter/material.dart';
import 'package:task_flutter_app/src/models/extra.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:cached_network_image/cached_network_image.dart';


class SecondScreen extends StatefulWidget {
  final String url;
  final String number;

  const SecondScreen({Key key,  @required this.url, @required this.number}): super(key: key);


  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  double total;
  int totalAmount = 0;
  List<double> subTotals = [];


  @override
  void setState(fn) {
    total = 0.0;
    totalAmount = 0;
    super.setState(fn);
    extras.forEach((element){
      totalAmount += element.amount;
      element.subTotal = element.amount * element.price;
      total += element.subTotal;});
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Second Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Big image with indicator
              Container(
                child: AspectRatio(
                  aspectRatio: 4/3,
                    child: CachedNetworkImage(
                      imageUrl: '${widget.url}',
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00AB50)),
                            strokeWidth: 5.0,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),),
              ),
              Text('Произвольный текст как заголовок',
                style: TextStyle(
                  fontSize: 25.0, fontWeight: FontWeight.bold),),
              SizedBox(height: 15),
              Text('Дополнительно', style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0,),
              Expanded(
                child: ListView.builder(
                  itemCount: extras.length,
                  itemBuilder: (ctx, i) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: <Widget>[
                          /// image
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                              ),
                              child: AspectRatio(
                                aspectRatio: 1.0/1.0,
                                child: Image.network(
                                  "${widget.url}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          /// title
                          Expanded(
                            flex: 5,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 100.0,
                                  child: Text(
                                    "${extras[i].title}",
                                    maxLines: 3,
                                    style: TextStyle(fontSize: 15.0, ),
                                  ),
                                ),
                                SizedBox(width: 30.0,),
                              /// Counter
                              Row(
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (extras[i].amount > 0){
                                          extras[i].amount -= 1;
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "${extras[i].amount}",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (extras[i].amount < 20){
                                          extras[i].amount += 1;
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(width: 5.0,),
                                  Container(
                                    child: Text("+${extras[i].price.toStringAsFixed(2)}р"),)
                                ],
                              ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Divider(),

              /// Total of cart
              Container(
                decoration: DottedDecoration(
                    shape: Shape.line, linePosition: LinePosition.bottom),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Дополнительно", style: TextStyle(fontSize: 25.0)),
                          Spacer(),
                          Text("x${totalAmount.toString()}", style: TextStyle(fontSize: 25.0),),
                          SizedBox(width: 10.0,),
                          total == null
                          ? Text('0.00р', style: TextStyle(fontSize: 25.0))
                          : Text("${total.toStringAsFixed(2)}р", style: TextStyle(fontSize: 25.0),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

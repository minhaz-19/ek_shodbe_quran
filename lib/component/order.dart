import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderElement extends StatefulWidget {
  OrderElement(
      {super.key,
      required this.order_id,
      required this.status,
      required this.price,
      required this.date});
  final String order_id;
  final String status;
  final int price;
  var date;

  @override
  State<OrderElement> createState() => _OrderElementState();
}

class _OrderElementState extends State<OrderElement> {
  var time;
  @override
  void initState() {
    time = DateFormat('h:mm a MM/dd/yyyy').format(DateTime.parse(widget.date));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text.rich(
            TextSpan(
              text: 'অর্ডার আইডি: ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black, // Customize the color as needed
              ),
              children: [
                TextSpan(
                  text: '${widget.order_id}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Text('$time'),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.status == 'Pending'
                      ? Colors.yellow[700]
                      : widget.status == 'Delivered'
                          ? Colors.green[700]
                          : Color.fromARGB(255, 98, 9, 187),
                ),
                child: Text(widget.status,
                    style: const TextStyle(color: Colors.white)),
              ),
              const Spacer(),
              Text(
                '${widget.price} ৳',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

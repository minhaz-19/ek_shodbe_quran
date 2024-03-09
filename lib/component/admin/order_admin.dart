import 'package:ek_shodbe_quran/component/admin/order_details_admin.dart';
import 'package:ek_shodbe_quran/screens/order_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminOrderElement extends StatefulWidget {
  AdminOrderElement(
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
  State<AdminOrderElement> createState() => _AdminOrderElementState();
}

class _AdminOrderElementState extends State<AdminOrderElement> {
  var time;
  @override
  void initState() {
    time = DateFormat('h:mm a MM/dd/yyyy').format(DateTime.parse(widget.date));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetails(order_id: widget.order_id)));
      },
      child: Card(
        elevation: 3,
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AdminOrderDetails(
                      order_id: widget.order_id,
                    )));
          },
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text.rich(
              TextSpan(
                text: 'অর্ডার আইডি: ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Customize the color as needed
                ),
                children: [
                  TextSpan(
                    text: widget.order_id,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
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
                            : widget.status == 'Cancelled'
                                ? Colors.red
                                : const Color.fromARGB(255, 98, 9, 187),
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
      ),
    );
  }
}

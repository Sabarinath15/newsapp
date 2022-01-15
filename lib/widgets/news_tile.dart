import 'package:flutter/material.dart';

//
import 'package:provider/provider.dart';
import '../provider/newsprovider.dart';

class NewsTile extends StatefulWidget {
  String title;
  String link;
  String published;
  bool isfav;
  int index;

  NewsTile({
    Key? key,
    required this.title,
    required this.link,
    required this.published,
    required this.isfav,
    required this.index,
  }) : super(key: key);

  @override
  _NewsTileState createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<Newsprovider>(context);
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Colors.grey,
              offset: Offset(0, 0),
            )
          ]),
      child: ListTile(
        contentPadding: const EdgeInsets.all(5),
        leading: IconButton(
          icon: widget.isfav
              ? const Icon(
                  Icons.favorite_rounded,
                  size: 35,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.favorite_border_rounded,
                  size: 35,
                  color: Colors.black45,
                ),
          onPressed: () {
            newsProvider.isfavchange(widget.index);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        subtitle: Text(widget.published),
      ),
    );
  }
}

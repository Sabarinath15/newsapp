import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/newsprovider.dart';

class FavNews extends StatelessWidget {
  const FavNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<Newsprovider>(context);
    return newsProvider.favNews.isEmpty
        ? const Center(
            child: Text(
              'No favourites yet!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
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
                    icon: const Icon(
                      Icons.favorite_rounded,
                      size: 35,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      newsProvider.removefav(index);
                    },
                  ),
                  title: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Text(
                      newsProvider.favNews.elementAt(index).title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  subtitle:
                      Text(newsProvider.favNews.elementAt(index).published),
                ),
              );
            },
            itemCount: newsProvider.favNews.length,
          );
  }
}

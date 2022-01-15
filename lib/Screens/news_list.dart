import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//
import '../widgets/news_tile.dart';
//
import '../provider/newsprovider.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  bool isfetched = true;
  bool isLoading = false;
  @override
  void didChangeDependencies() {
    if (isfetched) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Newsprovider>(context, listen: false)
          .getNews()
          .then((value) => {
                setState(() {
                  isLoading = false;
                  isfetched = false;
                })
              });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<Newsprovider>(context);
    return Container(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) => NewsTile(
                title: newsProvider.news.elementAt(index).title,
                link: newsProvider.news.elementAt(index).link,
                published: newsProvider.news.elementAt(index).published,
                isfav: newsProvider.news.elementAt(index).fav,
                index: index,
              ),
              itemCount: newsProvider.news.length,
            ),
    );
  }
}

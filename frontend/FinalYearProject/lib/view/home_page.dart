import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/models/NewsModel.dart';
import 'package:FinalYearProject/widgets/bbc_news_widget.dart';
import 'package:FinalYearProject/widgets/epa_news_widget.dart';
import 'package:FinalYearProject/widgets/ny_times_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variables to handle the news source selection
  String newsSourceSelection = "EPA News";
  bool nyTimesSelected = false;
  bool bbcSelected = false;
  bool epaSelected = true;
  bool sorted;

  //stores the bubble sort BBC Articles
  List<BbcArticles> sortedBBCArticles = new List<BbcArticles>();
  List<EpaArticles> sortedEPAArticles = new List<EpaArticles>();

  @override
  void initState() {
    super.initState();
    sorted = false;
  }

  @override
  Widget build(BuildContext context) {
    //IMPORTANT VARIABLES
    Size size = MediaQuery.of(context).size;
    Future<NewsModel> newsData = Provider.of<Future<NewsModel>>(context);
    DateTime now = new DateTime.now();
    var dateFormatter = new DateFormat.yMMMMEEEEd('en_us');
    String todaysDate = dateFormatter.format(now);

    // handles the page refresh controller
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    //function to refresh the news when pulled
    void _refreshNews() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      Provider.of<Future<NewsModel>>(context, listen: false);

      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    //updating news upon refresh
    void _onLoading() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));

      var refreshedNews = Provider.of<Future<NewsModel>>(context);

      // if failed,use loadFailed(),if no data return,use LoadNodata()
      setState(() {
        newsData = refreshedNews;
      });

      _refreshController.loadComplete();
    }

    return FutureProvider(
      create: (context) => newsData,
      child: (newsData != null)
          ? Scaffold(
              body: SmartRefresher(
                controller: _refreshController,
                onRefresh: _refreshNews,
                onLoading: _onLoading,
                child: Consumer<NewsModel>(
                  builder: (_, news, __) {
                    //initially set the bbc news to the normal order returned from api
                    news != null
                        ? sortedBBCArticles = news.data.bbcArticles
                        : null;

                    //return the news list when loaded
                    return (news != null)
                        ? SingleChildScrollView(
                            child: Column(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 10),
                                  child: Text(
                                    "Water News",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Source: $newsSourceSelection",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[500]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(todaysDate,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey[500]),
                                      textAlign: TextAlign.left),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: RaisedButton(
                                        child: Text("News Source"),
                                        color: waterBlueColour,
                                        onPressed: () {
                                          _sourceBtnPressed(size);
                                        },
                                      ),
                                    ),
                                    newsSourceSelection.contains("EPA News")
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: RaisedButton(
                                              child: Text("Newest"),
                                              color: waterBlueColour,
                                              onPressed: () {
                                                setState(() {
                                                  sorted = true;
                                                });

                                                selectionSortDescendingEPA(
                                                    news.data.epaArticles);
                                              },
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                              right: 5,
                                            ),
                                          ),
                                    newsSourceSelection.contains("EPA News")
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                            ),
                                            child: RaisedButton(
                                              child: Text("Oldest"),
                                              color: waterBlueColour,
                                              onPressed: () {
                                                setState(() {
                                                  selectionSortAscendingEPA(
                                                      news.data.epaArticles);

                                                  sorted = false;
                                                });
                                              },
                                            ),
                                          )
                                        : newsSourceSelection
                                                .contains("BBC News")
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: RaisedButton(
                                                  child: Text("Newest"),
                                                  color: waterBlueColour,
                                                  onPressed: () {
                                                    setState(() {
                                                      sorted = true;
                                                    });

                                                    bubbleSortDescending(
                                                        news.data.bbcArticles);
                                                  },
                                                ),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 5,
                                                ),
                                              ),
                                    newsSourceSelection.contains("BBC News")
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                              right: 20,
                                            ),
                                            child: RaisedButton(
                                              child: Text("Oldest"),
                                              color: waterBlueColour,
                                              onPressed: () {
                                                setState(() {
                                                  bubbleSortAscending(
                                                      news.data.bbcArticles);

                                                  sorted = false;
                                                });
                                              },
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                              right: 5,
                                            ),
                                          ),
                                  ],
                                ),
                                SingleChildScrollView(
                                  padding: EdgeInsets.only(top: 10),
                                  child: (newsSourceSelection
                                          .contains("NY Times"))
                                      ? ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: news.data.articles.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var newsJson = news
                                                .data.articles[index]
                                                .toJson();
                                            return NYTimesArticleWidget(
                                                title: newsJson['Title'],
                                                description:
                                                    newsJson['Description'],
                                                author: newsJson['Author'],
                                                imgUrl: newsJson['img_url'],
                                                siteLink:
                                                    newsJson['site_link']);
                                          })
                                      : newsSourceSelection.contains('BBC News')
                                          ? ListView.builder(
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  sortedBBCArticles.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var newsJson =
                                                    sortedBBCArticles[index]
                                                        .toJson();
                                                return BBCNewsArticleWidget(
                                                    title: newsJson['Title'],
                                                    description:
                                                        newsJson['Description'],
                                                    date: newsJson['Date'],
                                                    imgUrl: newsJson['img_url'],
                                                    siteLink:
                                                        newsJson['site_link']);
                                              })
                                          : ListView.builder(
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  news.data.epaArticles.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var newsJson = news
                                                    .data.epaArticles[index]
                                                    .toJson();
                                                return EPANewsArticleWidget(
                                                    title: newsJson['Title'],
                                                    date: newsJson['Date'],
                                                    imgUrl: newsJson['img_url'],
                                                    siteLink:
                                                        newsJson['site_link']);
                                              }),
                                )
                              ],
                            ),
                          ]))
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    sortedBBCArticles = null;
    sorted = false;
    newsSourceSelection = "BBC News";
    nyTimesSelected = false;
    bbcSelected = true;
  }

  Future<NewsModel> returnNews(Future<NewsModel> newsData) {
    return newsData;
  }

  // Swap elements in EPAArticles list for Selection Sort algorithm
  void selectionSwap(List<EpaArticles> articles, int steps, int i) {
    var temp = articles[steps];
    articles[steps] = articles[i];
    articles[i] = temp;
  }

  // Swap elements in BBCArticles list for Bule;e Sort algorithm
  void bubbleSwap(List<BbcArticles> articles, int j) {
    var temp = articles[j];
    articles[j] = articles[j + 1];
    articles[j + 1] = temp;
  }

  // Selection sort the EPA News articles (ascending)
  void selectionSortAscendingEPA(List<EpaArticles> articles) {
    if (articles == null || articles.length == 0) return;
    int n = articles.length;
    int i, steps;
    for (steps = 0; steps < n; steps++) {
      for (i = steps + 1; i < n; i++) {
        DateTime date1 = DateFormat.yMMMMd().parse(articles[steps].date);
        DateTime date2 = DateFormat.yMMMMd().parse(articles[i].date);
        if (date1.isAfter(date2)) {
          selectionSwap(articles, steps, i);
        }
      }
    }
    setState(() {
      sortedEPAArticles = articles;
    });
  }

  // Selection sort the EPA News articles (descending)
  void selectionSortDescendingEPA(List<EpaArticles> articles) {
    if (articles == null || articles.length == 0) return;
    int n = articles.length;
    int i, steps;
    for (steps = 0; steps < n; steps++) {
      for (i = steps + 1; i < n; i++) {
        DateTime date1 = DateFormat.yMMMMd().parse(articles[steps].date);
        DateTime date2 = DateFormat.yMMMMd().parse(articles[i].date);
        if (date2.isAfter(date1)) {
          selectionSwap(articles, steps, i);
        }
      }
    }
    setState(() {
      sortedEPAArticles = articles;
    });
  }

  //bubble sort the BBC News articles (descending)
  void bubbleSortDescending(List<BbcArticles> articles) {
    for (int i = 0; i < articles.length - 1; i++) {
      for (int j = 0; j < articles.length - i - 1; j++) {
        DateTime date1 =
            DateFormat('d MMM yyyy', 'en_US').parse(articles[j].date);
        DateTime date2 =
            DateFormat('d MMM yyyy', 'en_US').parse(articles[j + 1].date);

        if (date2.isAfter(date1)) {
          // Swapping using temporary variable
          bubbleSwap(articles, j);
        }
      }
    }

    setState(() {
      sortedBBCArticles = articles;
    });
  }

//bubble sort the BBC News articles (ascending)
  void bubbleSortAscending(List<BbcArticles> articles) {
    for (int i = 0; i < articles.length - 1; i++) {
      for (int j = 0; j < articles.length - i - 1; j++) {
        DateTime date1 =
            DateFormat('d MMM yyyy', 'en_US').parse(articles[j].date);
        DateTime date2 =
            DateFormat('d MMM yyyy', 'en_US').parse(articles[j + 1].date);

        if (date1.isAfter(date2)) {
          // Swapping using temporary variable
          bubbleSwap(articles, j);
        }
      }
    }

    setState(() {
      sortedBBCArticles = articles;
    });
  }

  void _sourceBtnPressed(Size size) {
    showDialog(
        context: context,
        child: Container(
          child: StatefulBuilder(
            builder: (context, state) => AlertDialog(
              content: Container(
                width: size.width,
                height: size.height / 2.6,
                child: Column(
                  children: [
                    Text(
                      "Choose a news source",
                      style: TextStyle(fontSize: 25),
                    ),
                    Card(
                      child: CheckboxListTile(
                        value: nyTimesSelected,
                        onChanged: (bool selectedVal) {
                          nyTimesSelected = selectedVal;
                          state(() {
                            setState(() {
                              if (nyTimesSelected == true) {
                                newsSourceSelection = "NY Times";
                                bbcSelected = false;
                                epaSelected = false;
                              } else if (bbcSelected == true) {
                                newsSourceSelection = "BBC News";
                                nyTimesSelected = false;
                                epaSelected = false;
                              } else if (epaSelected == true) {
                                newsSourceSelection = "EPA News";
                                bbcSelected = false;
                                nyTimesSelected = false;
                              }
                            });
                          });
                        },
                        title: Text("NY Times"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: CheckboxListTile(
                        value: bbcSelected,
                        onChanged: (bool selectedVal) {
                          bbcSelected = selectedVal;
                          state(() {
                            setState(() {
                              if (bbcSelected == true) {
                                newsSourceSelection = "BBC News";
                                nyTimesSelected = false;
                                epaSelected = false;
                              } else if (nyTimesSelected == true) {
                                newsSourceSelection = "NY Times";
                                bbcSelected = false;
                                epaSelected = false;
                              } else if (epaSelected == true) {
                                newsSourceSelection = "EPA News";
                                bbcSelected = false;
                                nyTimesSelected = false;
                              }
                            });
                          });
                        },
                        title: Text("BBC News"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: CheckboxListTile(
                        value: epaSelected,
                        onChanged: (bool selectedVal) {
                          epaSelected = selectedVal;
                          state(() {
                            setState(() {
                              if (epaSelected == true) {
                                newsSourceSelection = "EPA News";
                                nyTimesSelected = false;
                                bbcSelected = false;
                              } else if (nyTimesSelected == true) {
                                newsSourceSelection = "NY Times";
                                nyTimesSelected = true;
                                bbcSelected = false;
                                epaSelected = false;
                              } else if (bbcSelected == true) {
                                newsSourceSelection = "BBC News";
                                bbcSelected = true;
                                nyTimesSelected = false;
                                epaSelected = false;
                              }
                            });
                          });
                        },
                        title: Text("EPA News"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

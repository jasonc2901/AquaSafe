class NewsModel {
  int status;
  Data data;

  NewsModel({this.status, this.data});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Articles> articles;
  List<BbcArticles> bbcArticles;
  List<EpaArticles> epaArticles;

  Data({this.articles, this.bbcArticles, this.epaArticles});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = new List<Articles>();
      json['articles'].forEach((v) {
        articles.add(new Articles.fromJson(v));
      });
    }
    if (json['bbc_articles'] != null) {
      bbcArticles = new List<BbcArticles>();
      json['bbc_articles'].forEach((v) {
        bbcArticles.add(new BbcArticles.fromJson(v));
      });
    }
    if (json['epa_articles'] != null) {
      epaArticles = new List<EpaArticles>();
      json['epa_articles'].forEach((v) {
        epaArticles.add(new EpaArticles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    if (this.bbcArticles != null) {
      data['bbc_articles'] = this.bbcArticles.map((v) => v.toJson()).toList();
    }
    if (this.epaArticles != null) {
      data['epa_articles'] = this.epaArticles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  String title;
  String description;
  String author;
  String imgUrl;
  String siteLink;

  Articles(
      {this.title, this.description, this.author, this.imgUrl, this.siteLink});

  Articles.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    description = json['Description'];
    author = json['Author'];
    imgUrl = json['img_url'];
    siteLink = json['site_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Author'] = this.author;
    data['img_url'] = this.imgUrl;
    data['site_link'] = this.siteLink;
    return data;
  }
}

class BbcArticles {
  String title;
  String description;
  String date;
  String imgUrl;
  String siteLink;

  BbcArticles(
      {this.title, this.description, this.date, this.imgUrl, this.siteLink});

  BbcArticles.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    description = json['Description'];
    date = json['Date'];
    imgUrl = json['img_url'];
    siteLink = json['site_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Date'] = this.date;
    data['img_url'] = this.imgUrl;
    data['site_link'] = this.siteLink;
    return data;
  }
}

class EpaArticles {
  String title;
  String date;
  String imgUrl;
  String siteLink;

  EpaArticles({this.title, this.date, this.imgUrl, this.siteLink});

  EpaArticles.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    date = json['Date'];
    imgUrl = json['img_url'];
    siteLink = json['site_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Date'] = this.date;
    data['img_url'] = this.imgUrl;
    data['site_link'] = this.siteLink;
    return data;
  }
}

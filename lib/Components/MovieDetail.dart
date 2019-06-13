



class MovieDetail {
  final String title;
  final String thumbnailUrl;
  final String year;
  final String type;
  MovieDetail._({this.title, this.thumbnailUrl,this.year, this.type});
  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return new MovieDetail._(title: json['Title'], thumbnailUrl: json['Poster'],
        year: json['Year'], type: json['Type']
    );
  }
}





class AllDetail {
  String URL;
  final String ratting;
   String plot;

  AllDetail._({this.URL, this.ratting,this.plot});

  factory AllDetail.fromJson(Map<String, dynamic> json) {

    return new AllDetail._(
        URL: json['Website'], ratting: json['imdbRating'],
        plot: json['Plot']
    );
  }
}

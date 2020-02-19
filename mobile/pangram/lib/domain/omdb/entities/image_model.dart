class ImageModel {
  String title;
  String year;
  String imdbID;
  String type;
  String poster;

  ImageModel(this.title, this.year, this.imdbID, this.type, this.poster);
  ImageModel.fromJson(Map<String, dynamic> parseJson)
    : title = parseJson['Title'],
      year = parseJson['Year'],
      imdbID = parseJson['imdbID'],
      type = parseJson['Type'],
      poster = parseJson['Poster'];
  Map<String, dynamic> toJson() => {
        'title': this.title,
        'year': this.year,
        'imdbID': this.imdbID,
        'type': this.type,
        'poster': this.poster,
      };  
}
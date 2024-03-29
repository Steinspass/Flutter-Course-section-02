// Generated by https://quicktype.io

class Cast {

  List<Actor> actors = new List();

  Cast.fromJsonList(List<dynamic> jsonList){

    if(jsonList == null) return;

    jsonList.forEach( (item){
      
      final actor = Actor.fromJsonMap(item);

      actors.add(actor);

    });

  }

}




class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json){

    castId      = json['cast_id'];
    character   = json['character'];
    creditId    = json['credit_id'];
    gender      = json['gender'];
    id          = json['id'];
    name        = json['name'];
    order       = json['order'];
    profilePath = json['profile_path'];

  }

  getPosterImage(){

    if(profilePath == null){
      return 'data:image/jpeg;base64,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';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }



}



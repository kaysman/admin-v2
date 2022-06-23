class ListOfIds {
  ListOfIds({
    this.ids,
  });

  List<String>? ids;

  factory ListOfIds.fromJson(Map<String, dynamic> json) => ListOfIds(
        ids: List<String>.from(json["ids"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ids": List<dynamic>.from(ids!.map((x) => x)),
      };
}

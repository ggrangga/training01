class PangramEntity {
  String data;

  PangramEntity({this.data});

  PangramEntity copyWith(String data) => PangramEntity(data: data ?? this.data);
}
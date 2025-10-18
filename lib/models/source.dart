
class SourceData{
  final String sourceId;
  final String sourceName;
  SourceData({required this.sourceId, required this.sourceName});

 factory  SourceData.formJson(Map<String,dynamic> json){
    return SourceData(sourceId: json["id"], sourceName: json["name"]);
}
}
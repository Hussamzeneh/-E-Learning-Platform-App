// To parse this JSON data, do
//
//     final ShowFees = gradesByTypeFromJson(jsonString);

import 'dart:convert';

List<ShowFees> gradesByTypeFromJson(String str) => List<ShowFees>.from(json.decode(str).map((x) => ShowFees.fromJson(x)));

String gradesByTypeToJson(List<ShowFees> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowFees {
    String? feeName;
    String ?type;
    DateTime? created_at;
    int? benefits;
    int ? id ;
    ShowFees({
        this.feeName,
        this.id,
        this.type,
        this.created_at,
        this.benefits,
    });

    factory ShowFees.fromJson(Map<String, dynamic> json) => ShowFees(
        feeName: json["fee_name"],
        type: json["type"],
        created_at: DateTime.parse(json["created_at"]),
        benefits: json["benefits"],
        id: json["id"]
    );

    Map<String, dynamic> toJson() => {
        "fee_name": feeName,
        "type": type,
        "created_at":created_at!.toIso8601String(),
        "benefits": benefits,
        "id" : id 
    };
}

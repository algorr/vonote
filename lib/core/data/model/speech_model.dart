import 'package:equatable/equatable.dart';

class Speech extends Equatable {
  String? id;
  String? text;
  String? color;

  Speech({this.id, this.text, this.color});

  Speech.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['color'] = color;
    return data;
  }

  static var empty = Speech();

  bool get isEmpty => this == Speech.empty;
  bool get isNotEmpty => this != Speech.empty;

  @override
  List<Object?> get props => [id, text, color];
}

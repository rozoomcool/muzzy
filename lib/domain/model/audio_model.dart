import 'package:equatable/equatable.dart';

class AudioModel extends Equatable {

  final String title;
  final String author;

  @override
  List<Object?> get props => [title, author];

  const AudioModel({required this.title, required this.author});
}
// ignore: file_names,camel_case_types, prefer_const_declarations,
// ignore_for_file: prefer_const_declarations

final String tableDetails = 'details';

class detailFields {
  static final List<String> values = [id, collegeName, year, language];
  static final String id = '_id';
  static final String collegeName = 'collegeName';
  static final String year = 'year';
  static final String language = 'language';
}

// ignore: camel_case_types
class Details {
  final int? id;
  final String collegeName;
  final int year;
  final String language;
  const Details(
      {this.id,
      required this.collegeName,
      required this.year,
      required this.language});

  Details copy({int? id, String? collegeName, int? year, String? language}) =>
      Details(
          id: id ?? this.id,
          collegeName: collegeName ?? this.collegeName,
          year: year ?? this.year,
          language: language ?? this.language);

  static Details fromJson(Map<String, Object?> json) => Details(
    id: json[detailFields.id] as int?,
    collegeName: json[detailFields.collegeName] as String,
    year: json[detailFields.year] as int,
    language: json[detailFields.language] as String
  );

  Map<String, Object?> toJson() => {
        detailFields.id: id,
        detailFields.collegeName: collegeName,
        detailFields.year: year,
        detailFields.language: language
      };
}

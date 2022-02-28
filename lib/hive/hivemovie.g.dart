// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hivemovie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMovieAdapter extends TypeAdapter<HiveMovie> {
  @override
  final int typeId = 0;

  @override
  HiveMovie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMovie()
      ..adult = fields[0] as bool
      ..id = fields[1] as int
      ..originalLanguage = fields[2] as String
      ..overview = fields[3] as String
      ..posterPath = fields[4] as String
      ..releaseDate = fields[5] as String
      ..title = fields[6] as String
      ..voteAverage = fields[7] as double
      ..voteCount = fields[8] as int;
  }

  @override
  void write(BinaryWriter writer, HiveMovie obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.adult)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.originalLanguage)
      ..writeByte(3)
      ..write(obj.overview)
      ..writeByte(4)
      ..write(obj.posterPath)
      ..writeByte(5)
      ..write(obj.releaseDate)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.voteAverage)
      ..writeByte(8)
      ..write(obj.voteCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

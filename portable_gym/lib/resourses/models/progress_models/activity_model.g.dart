// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityAdapter extends TypeAdapter<Activity> {
  @override
  final int typeId = 0;

  @override
  Activity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Activity(
      englishCategoryName: fields[0] as String,
      arabicCategoryName: fields[1] as String,
      date: fields[2] as DateTime,
      period: fields[3] as DateTime,
      userDocId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Activity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.englishCategoryName)
      ..writeByte(1)
      ..write(obj.arabicCategoryName)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.period)
      ..writeByte(4)
      ..write(obj.userDocId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

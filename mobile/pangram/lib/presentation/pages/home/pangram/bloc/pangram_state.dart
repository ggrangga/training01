import 'package:demo_app/domain/pangram/entities/pangram_entity.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class PangramState {}

class PangramInitial extends PangramState {}

@immutable
class PangramDataState extends PangramState{
  final PangramEntity pangramData;

  PangramDataState({this.pangramData});
}
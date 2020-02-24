import 'package:injectable/injectable.dart';
import 'package:demo_app/domain/pangram/entities/pangram_entity.dart';
import 'package:demo_app/data/repositories/pangram_repository.dart';

@Bind.toType(PangramRepositoryImpl)
@injectable
abstract class PangramRepository {
  Future<PangramEntity> getData();
}
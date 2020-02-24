import 'package:injectable/injectable.dart';
import 'package:demo_app/domain/pangram/repositories/pangram_repository.dart';
import 'package:demo_app/data/datasources/pangram_datasource.dart';
import 'package:demo_app/domain/pangram/entities/pangram_entity.dart';

@lazySingleton
@injectable
class PangramRepositoryImpl extends PangramRepository {
  final PangramDatasource pangramDatasource;

  PangramRepositoryImpl(this.pangramDatasource);

  @override
  Future<PangramEntity> getData() async {
    return await pangramDatasource.getData();
  }
}
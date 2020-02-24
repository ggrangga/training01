import 'package:demo_app/domain/pangram/entities/pangram_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:demo_app/common/models/usecase.dart';
import 'package:demo_app/domain/pangram/repositories/pangram_repository.dart';

@lazySingleton
@injectable
class GetPangramUseCase implements UseCase<PangramEntity, NoPayload>{
  final PangramRepository pangramRepository;

  GetPangramUseCase({@required this.pangramRepository});

  @override
  Future<PangramEntity> call(NoPayload _) {
    return pangramRepository.getData();
  }
}
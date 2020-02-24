import 'package:bloc/bloc.dart';
import 'package:demo_app/common/models/usecase.dart';
import 'package:demo_app/domain/pangram/entities/pangram_entity.dart';
import 'package:demo_app/domain/pangram/usecase/pangram_usecase.dart';
import 'package:demo_app/presentation/pages/home/pangram/bloc/pangram_event.dart';
import 'package:demo_app/presentation/pages/home/pangram/bloc/pangram_state.dart';

class PangramBloc extends Bloc<PangramEvent, PangramState> {
  final GetPangramUseCase getPangramUseCase;

  PangramBloc({this.getPangramUseCase});

  @override
  PangramState get initialState => PangramInitial();

  @override
  Stream<PangramState> mapEventToState(
    PangramEvent event,
  ) async* {
    // TODO: Add Logic
    if(event is PangramEvent){
      try{
        final getData  = await getPangramUseCase(NoPayload());
        yield PangramDataState(pangramData: getData);
      }catch (e){
        print(e);
      }
    }
  }
}

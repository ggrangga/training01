import 'package:flutter/material.dart';
import 'package:demo_app/presentation/pages/home/pangram/bloc/pangram_event.dart';
import 'package:demo_app/presentation/pages/home/pangram/bloc/pangram_state.dart';
import 'package:demo_app/presentation/pages/home/pangram/bloc/pangram_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PangramScreen extends StatefulWidget {
  PangramScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PangramScreen();
}

class _PangramScreen extends State<PangramScreen> {
  String _textParagraph;
  void initState() {
    super.initState();
    BlocProvider.of<PangramBloc>(context).add(PangramDataEvent());
    //_textParagraph = 'hello world';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<PangramBloc, PangramState>(
          builder: (context, state) {
        if (state is PangramDataState) {
          _textParagraph = state.pangramData.toString();
          return _buildPangram();
        }
        return Center(child: CircularProgressIndicator());
      }, listener: (context, state) {
        print('listener state : $state');
      }),
    );
  }

  Widget _buildPangram() {
    if (_textParagraph == null) {
      return Center(child: Text('Pangram Not Found'));
    }
    return new Container(
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(5.0),
      child: SingleChildScrollView(  
        child: new Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: new FractionalOffset(0.0, 0.0),
                child: IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 10.0)),
              Container(
                child: Text(
                  _textParagraph,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
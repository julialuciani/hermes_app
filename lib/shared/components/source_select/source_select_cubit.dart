import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/components/source_select/source_select_state.dart';

class SourceSelectCubit extends Cubit<SourceSelectState> {
  SourceSelectCubit() : super(SourceSelectInitial());
}

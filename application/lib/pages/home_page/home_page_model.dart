import '/components/card17_project_widget.dart';
import '/components/smallgrid_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Model for Card17Project component.
  late Card17ProjectModel card17ProjectModel1;
  // Model for Card17Project component.
  late Card17ProjectModel card17ProjectModel2;
  // Model for smallgrid component.
  late SmallgridModel smallgridModel1;
  // Model for smallgrid component.
  late SmallgridModel smallgridModel2;
  // Model for smallgrid component.
  late SmallgridModel smallgridModel3;
  // Model for smallgrid component.
  late SmallgridModel smallgridModel4;
  // Model for smallgrid component.
  late SmallgridModel smallgridModel5;
  // Model for smallgrid component.
  late SmallgridModel smallgridModel6;

  @override
  void initState(BuildContext context) {
    card17ProjectModel1 = createModel(context, () => Card17ProjectModel());
    card17ProjectModel2 = createModel(context, () => Card17ProjectModel());
    smallgridModel1 = createModel(context, () => SmallgridModel());
    smallgridModel2 = createModel(context, () => SmallgridModel());
    smallgridModel3 = createModel(context, () => SmallgridModel());
    smallgridModel4 = createModel(context, () => SmallgridModel());
    smallgridModel5 = createModel(context, () => SmallgridModel());
    smallgridModel6 = createModel(context, () => SmallgridModel());
  }

  @override
  void dispose() {
    card17ProjectModel1.dispose();
    card17ProjectModel2.dispose();
    smallgridModel1.dispose();
    smallgridModel2.dispose();
    smallgridModel3.dispose();
    smallgridModel4.dispose();
    smallgridModel5.dispose();
    smallgridModel6.dispose();
  }
}

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'smallgrid_model.dart';
export 'smallgrid_model.dart';

class SmallgridWidget extends StatefulWidget {
  const SmallgridWidget({
    super.key,
    required this.icon,
    required this.name,
  });

  final Widget? icon;
  final String? name;

  @override
  State<SmallgridWidget> createState() => _SmallgridWidgetState();
}

class _SmallgridWidgetState extends State<SmallgridWidget> {
  late SmallgridModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SmallgridModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Material(
        color: Colors.transparent,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          width: 160.0,
          height: 160.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [FlutterFlowTheme.of(context).primary, Color(0xFFFFBB6E)],
              stops: [0.0, 1.0],
              begin: AlignmentDirectional(0.41, -1.0),
              end: AlignmentDirectional(-0.41, 1.0),
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: widget!.icon!,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: Text(
                  valueOrDefault<String>(
                    widget!.name,
                    'Name',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

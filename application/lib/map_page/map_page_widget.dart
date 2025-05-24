import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'map_page_model.dart';
export 'map_page_model.dart';

class MapPageWidget extends StatefulWidget {
  const MapPageWidget({super.key});

  static String routeName = 'mapPage';
  static String routePath = '/mapPage';

  @override
  State<MapPageWidget> createState() => _MapPageWidgetState();
}

class _MapPageWidgetState extends State<MapPageWidget> {
  late MapPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      await _model.googleMapsController.future.then(
        (c) => c.animateCamera(
          CameraUpdate.newLatLng(currentUserLocationValue!.toGoogleMaps()),
        ),
      );
      _model.nearbyPlacesresponse = await NearbySearchCall.call(
        latlng:
            functions.locationToLatLng(currentUserLocationValue?.toString()),
        type: valueOrDefault<String>(
          FFAppState().placeType,
          'restaurant',
        ),
      );

      if ((_model.nearbyPlacesresponse?.succeeded ?? true)) {
        FFAppState().LatLon = functions
            .listDoubleToLatLng(
                NearbySearchCall.placeLattitude(
                  (_model.nearbyPlacesresponse?.jsonBody ?? ''),
                )?.toList(),
                NearbySearchCall.placeLongtitude(
                  (_model.nearbyPlacesresponse?.jsonBody ?? ''),
                )?.toList())!
            .toList()
            .cast<LatLng>();
        FFAppState().bottomSheet = false;
        safeSetState(() {});
      }
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 30.0,
            ),
            onPressed: () async {
              context.goNamed(HomePageWidget.routeName);
            },
          ),
          title: Text(
            '${FFAppState().placeType} results',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.interTight(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primary,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [
            FlutterFlowIconButton(
              borderRadius: 100.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.my_location,
                color: FlutterFlowTheme.of(context).primary,
                size: 30.0,
              ),
              onPressed: () async {
                currentUserLocationValue = await getCurrentUserLocation(
                    defaultLocation: LatLng(0.0, 0.0));
                await _model.googleMapsController.future.then(
                  (c) => c.animateCamera(
                    CameraUpdate.newLatLng(
                        currentUserLocationValue!.toGoogleMaps()),
                  ),
                );
              },
            ),
          ],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    FlutterFlowGoogleMap(
                      controller: _model.googleMapsController,
                      onCameraIdle: (latLng) =>
                          _model.googleMapsCenter = latLng,
                      initialLocation: _model.googleMapsCenter ??=
                          currentUserLocationValue!,
                      markers: FFAppState()
                          .LatLon
                          .map(
                            (marker) => FlutterFlowMarker(
                              marker.serialize(),
                              marker,
                              () async {
                                FFAppState().bottomSheet = true;
                                safeSetState(() {});
                              },
                            ),
                          )
                          .toList(),
                      markerColor: GoogleMarkerColor.violet,
                      mapType: MapType.normal,
                      style: GoogleMapStyle.dark,
                      initialZoom: 14.0,
                      allowInteraction: true,
                      allowZoom: true,
                      showZoomControls: false,
                      showLocation: false,
                      showCompass: false,
                      showMapToolbar: false,
                      showTraffic: false,
                      centerMapOnMarkerTap: true,
                    ),
                    if (FFAppState().bottomSheet)
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: PointerInterceptor(
                          intercepting: isWeb,
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 16.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          NearbySearchCall.placeName(
                                            (_model.nearbyPlacesresponse
                                                    ?.jsonBody ??
                                                ''),
                                          )?.elementAtOrNull(
                                              functions.indexMarkerIdentifier(
                                                  _model.googleMapsCenter,
                                                  functions
                                                      .listDoubleToLatLng(
                                                          NearbySearchCall
                                                              .placeLattitude(
                                                            (_model.nearbyPlacesresponse
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )?.toList(),
                                                          NearbySearchCall
                                                              .placeLongtitude(
                                                            (_model.nearbyPlacesresponse
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )?.toList())
                                                      ?.toList())!),
                                          'name',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 24.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  (NearbySearchCall.placeRating(
                                                    (_model.nearbyPlacesresponse
                                                            ?.jsonBody ??
                                                        ''),
                                                  )?.elementAtOrNull(functions
                                                          .indexMarkerIdentifier(
                                                              _model
                                                                  .googleMapsCenter,
                                                              functions
                                                                  .listDoubleToLatLng(
                                                                      NearbySearchCall
                                                                          .placeLattitude(
                                                                        (_model.nearbyPlacesresponse?.jsonBody ??
                                                                            ''),
                                                                      )?.toList(),
                                                                      NearbySearchCall.placeLongtitude(
                                                                        (_model.nearbyPlacesresponse?.jsonBody ??
                                                                            ''),
                                                                      )?.toList())
                                                                  ?.toList())!))
                                                      ?.toString(),
                                                  '-',
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    PointerInterceptor(
                      intercepting: isWeb,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 12.0),
                              child: FlutterFlowChoiceChips(
                                options: [
                                  ChipData(
                                      'Restaurant   ', Icons.restaurant_sharp),
                                  ChipData('Cafe   ', Icons.coffee_sharp),
                                  ChipData('Bar   ', Icons.local_bar),
                                  ChipData('Park   ', Icons.park),
                                  ChipData('Museum   ', Icons.museum),
                                  ChipData('Cinema   ', Icons.movie),
                                  ChipData('Shopping   ', Icons.shopping_bag),
                                  ChipData('Hotel   ', Icons.hotel)
                                ],
                                onChanged: (val) async {
                                  safeSetState(() => _model.choiceChipsValue =
                                      val?.firstOrNull);
                                  currentUserLocationValue =
                                      await getCurrentUserLocation(
                                          defaultLocation: LatLng(0.0, 0.0));
                                  _model.nearbyPlacesresponseCopy =
                                      await NearbySearchCall.call(
                                    latlng: functions.locationToLatLng(
                                        currentUserLocationValue?.toString()),
                                    type: valueOrDefault<String>(
                                      _model.choiceChipsValue,
                                      'restaurant',
                                    ),
                                  );

                                  if ((_model.nearbyPlacesresponseCopy
                                          ?.succeeded ??
                                      true)) {
                                    FFAppState().LatLon = functions
                                        .listDoubleToLatLng(
                                            NearbySearchCall.placeLattitude(
                                              (_model.nearbyPlacesresponseCopy
                                                      ?.jsonBody ??
                                                  ''),
                                            )?.toList(),
                                            NearbySearchCall.placeLongtitude(
                                              (_model.nearbyPlacesresponseCopy
                                                      ?.jsonBody ??
                                                  ''),
                                            )?.toList())!
                                        .toList()
                                        .cast<LatLng>();
                                    FFAppState().bottomSheet = false;
                                    safeSetState(() {});
                                  }

                                  safeSetState(() {});
                                },
                                selectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  iconColor: FlutterFlowTheme.of(context).info,
                                  iconSize: 16.0,
                                  labelPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 0.0, 4.0),
                                  elevation: 3.0,
                                  borderRadius: BorderRadius.circular(26.0),
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  iconColor: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  iconSize: 16.0,
                                  labelPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 0.0, 4.0),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(26.0),
                                ),
                                chipSpacing: 12.0,
                                rowSpacing: 8.0,
                                multiselect: false,
                                alignment: WrapAlignment.start,
                                controller:
                                    _model.choiceChipsValueController ??=
                                        FormFieldController<List<String>>(
                                  [],
                                ),
                                wrapped: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

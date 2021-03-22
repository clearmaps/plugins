// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:kakao_maps_flutter/kakao_maps_flutter.dart';

import 'page.dart';

class PlaceCirclePage extends KakaoMapExampleAppPage {
  PlaceCirclePage() : super(const Icon(Icons.linear_scale), 'Place circle');

  @override
  Widget build(BuildContext context) {
    return const PlaceCircleBody();
  }
}

class PlaceCircleBody extends StatefulWidget {
  const PlaceCircleBody();

  @override
  State<StatefulWidget> createState() => PlaceCircleBodyState();
}

class PlaceCircleBodyState extends State<PlaceCircleBody> {
  PlaceCircleBodyState();

  KakaoMapController? controller;
  Map<CircleId, Circle> circles = <CircleId, Circle>{};
  int _circleIdCounter = 1;
  CircleId? selectedCircle;

  // Values when toggling circle color
  int fillColorsIndex = 0;
  int strokeColorsIndex = 0;
  List<Color> colors = <Color>[
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.pink,
  ];

  // Values when toggling circle stroke width
  int widthsIndex = 0;
  List<int> widths = <int>[10, 20, 5];

  void _onMapCreated(KakaoMapController controller) {
    this.controller = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onCircleTapped(CircleId circleId) {
    setState(() {
      selectedCircle = circleId;
    });
  }

  void _remove(CircleId circleId) {
    setState(() {
      if (circles.containsKey(circleId)) {
        circles.remove(circleId);
      }
      if (circleId == selectedCircle) {
        selectedCircle = null;
      }
    });
  }

  void _add() {
    final int circleCount = circles.length;

    if (circleCount == 12) {
      return;
    }

    final String circleIdVal = 'circle_id_$_circleIdCounter';
    _circleIdCounter++;
    final CircleId circleId = CircleId(circleIdVal);

    final Circle circle = Circle(
      circleId: circleId,
      consumeTapEvents: true,
      strokeColor: Colors.orange,
      fillColor: Colors.green,
      strokeWidth: 5,
      center: _createCenter(),
      radius: 50000,
      onTap: () {
        _onCircleTapped(circleId);
      },
    );

    setState(() {
      circles[circleId] = circle;
    });
  }

  void _toggleVisible(CircleId circleId) {
    final Circle circle = circles[circleId]!;
    setState(() {
      circles[circleId] = circle.copyWith(
        visibleParam: !circle.visible,
      );
    });
  }

  void _changeFillColor(CircleId circleId) {
    final Circle circle = circles[circleId]!;
    setState(() {
      circles[circleId] = circle.copyWith(
        fillColorParam: colors[++fillColorsIndex % colors.length],
      );
    });
  }

  void _changeStrokeColor(CircleId circleId) {
    final Circle circle = circles[circleId]!;
    setState(() {
      circles[circleId] = circle.copyWith(
        strokeColorParam: colors[++strokeColorsIndex % colors.length],
      );
    });
  }

  void _changeStrokeWidth(CircleId circleId) {
    final Circle circle = circles[circleId]!;
    setState(() {
      circles[circleId] = circle.copyWith(
        strokeWidthParam: widths[++widthsIndex % widths.length],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final CircleId? selectedId = selectedCircle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 350.0,
            height: 300.0,
            child: KakaoMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(52.4478, -3.5402),
                zoom: 7.0,
              ),
              circles: Set<Circle>.of(circles.values),
              onMapCreated: _onMapCreated,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        TextButton(
                          child: const Text('add'),
                          onPressed: _add,
                        ),
                        TextButton(
                          child: const Text('remove'),
                          onPressed: (selectedId == null)
                              ? null
                              : () => _remove(selectedId),
                        ),
                        TextButton(
                          child: const Text('toggle visible'),
                          onPressed: (selectedId == null)
                              ? null
                              : () => _toggleVisible(selectedId),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        TextButton(
                          child: const Text('change stroke width'),
                          onPressed: (selectedId == null)
                              ? null
                              : () => _changeStrokeWidth(selectedId),
                        ),
                        TextButton(
                          child: const Text('change stroke color'),
                          onPressed: (selectedId == null)
                              ? null
                              : () => _changeStrokeColor(selectedId),
                        ),
                        TextButton(
                          child: const Text('change fill color'),
                          onPressed: (selectedId == null)
                              ? null
                              : () => _changeFillColor(selectedId),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  LatLng _createCenter() {
    final double offset = _circleIdCounter.ceilToDouble();
    return _createLatLng(51.4816 + offset * 0.2, -3.1791);
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }
}

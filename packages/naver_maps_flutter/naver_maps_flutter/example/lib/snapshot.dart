// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:naver_maps_flutter/naver_maps_flutter.dart';

import 'page.dart';

const CameraPosition _kInitialPosition =
    CameraPosition(target: LatLng(37.3591784, 127.1048319), zoom: 11.0);

class SnapshotPage extends NaverMapExampleAppPage {
  SnapshotPage()
      : super(const Icon(Icons.camera_alt), 'Take a snapshot of the map');

  @override
  Widget build(BuildContext context) {
    return _SnapshotBody();
  }
}

class _SnapshotBody extends StatefulWidget {
  @override
  _SnapshotBodyState createState() => _SnapshotBodyState();
}

class _SnapshotBodyState extends State<_SnapshotBody> {
  NaverMapController? _mapController;
  Uint8List? _imageBytes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 180,
            child: NaverMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: _kInitialPosition,
            ),
          ),
          TextButton(
            child: Text('Take a snapshot'),
            onPressed: () async {
              final imageBytes = await _mapController?.takeSnapshot();
              setState(() {
                _imageBytes = imageBytes;
              });
            },
          ),
          Container(
            decoration: BoxDecoration(color: Colors.blueGrey[50]),
            height: 180,
            child: _imageBytes != null ? Image.memory(_imageBytes!) : null,
          ),
        ],
      ),
    );
  }

  void onMapCreated(NaverMapController controller) {
    _mapController = controller;
  }
}

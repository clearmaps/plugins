// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naver_maps_flutter/naver_maps_flutter.dart';
import 'page.dart';

const CameraPosition _kInitialPosition =
    CameraPosition(target: LatLng(37.3591784, 127.1048319), zoom: 11.0);

class LiteModePage extends NaverMapExampleAppPage {
  LiteModePage() : super(const Icon(Icons.map), 'Lite mode');

  @override
  Widget build(BuildContext context) {
    return const _LiteModeBody();
  }
}

class _LiteModeBody extends StatelessWidget {
  const _LiteModeBody();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: SizedBox(
            width: 300.0,
            height: 300.0,
            child: NaverMap(
              initialCameraPosition: _kInitialPosition,
              liteModeEnabled: true,
            ),
          ),
        ),
      ),
    );
  }
}

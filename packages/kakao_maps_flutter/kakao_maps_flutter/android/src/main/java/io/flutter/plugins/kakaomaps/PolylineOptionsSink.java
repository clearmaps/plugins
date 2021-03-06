// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.kakaomaps;

import com.naver.maps.geometry.LatLng;
import com.naver.maps.model.Cap;
import com.naver.maps.model.PatternItem;

import java.util.List;

/** Receiver of Polyline configuration options. */
interface PolylineOptionsSink {

  void setConsumeTapEvents(boolean consumetapEvents);

  void setColor(int color);

  void setEndCap(Cap endCap);

  void setGeodesic(boolean geodesic);

  void setJointType(int jointType);

  void setPattern(List<PatternItem> pattern);

  void setPoints(List<LatLng> points);

  void setStartCap(Cap startCap);

  void setVisible(boolean visible);

  void setWidth(float width);

  void setZIndex(float zIndex);
}

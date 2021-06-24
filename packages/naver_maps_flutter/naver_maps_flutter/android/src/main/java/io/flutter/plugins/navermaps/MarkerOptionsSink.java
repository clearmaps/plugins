// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.navermaps;

import com.naver.maps.geometry.LatLng;
import com.naver.maps.map.NaverMap;
import com.naver.maps.model.BitmapDescriptor;

/** Receiver of Marker configuration options. */
interface MarkerOptionsSink {
  void setAlpha(float alpha);

  void setAnchor(float u, float v);

  void setConsumeTapEvents(boolean consumeTapEvents);

  void setDraggable(boolean draggable);

  void setFlat(boolean flat);

  void setIcon(BitmapDescriptor bitmapDescriptor);

  void setInfoWindowAnchor(float u, float v);

  void setInfoWindowText(String title, String snippet);

  void setPosition(LatLng position);

  void setRotation(float rotation);

  void setRemove(boolean remove);

  void setVisible(boolean visible);

  void setZIndex(float zIndex);
}

// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.kakaomaps;

import androidx.annotation.Nullable;
import androidx.lifecycle.Lifecycle;

interface LifecycleProvider {

  @Nullable
  Lifecycle getLifecycle();
}

// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "tools/gn/source_file_type.h"

#include "tools/gn/filesystem_utils.h"
#include "tools/gn/source_file.h"

SourceFileType GetDefaultSourceFileType(const SourceFile& file) {
  base::StringPiece extension = FindExtension(&file.value());
  if (extension == "cc" || extension == "cpp" || extension == "cxx" ||
      extension == "c++" || extension == "C")
    return SOURCE_CPP;
  if (extension == "h" || extension == "hpp" || extension == "hxx" ||
      extension == "hh" || extension == "h++" || extension == "H")
    return SOURCE_H;
  if (extension == "c")
    return SOURCE_C;
  if (extension == "m")
    return SOURCE_M;
  if (extension == "mm" || extension == "M")
    return SOURCE_MM;
  if (extension == "rc")
    return SOURCE_RC;
  if (extension == "S" || extension == "s" || extension == "sx")
    return SOURCE_S;
  if (extension == "asm")
    return SOURCE_ASM;
  if (extension == "o" || extension == "obj")
    return SOURCE_O;
  if (extension == "ld")
    return SOURCE_LINK;
  if (extension == "def")
    return SOURCE_DEF;

  return SOURCE_UNKNOWN;
}

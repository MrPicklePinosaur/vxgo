// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// +build vxworks,amd64

#include "textflag.h"

TEXT _rt0_amd64_vxworks(SB),NOSPLIT,$-8
	JMP	_rt0_amd64(SB)

TEXT _rt0_amd64_vxworks_lib(SB),NOSPLIT,$0
	JMP	_rt0_amd64_lib(SB)

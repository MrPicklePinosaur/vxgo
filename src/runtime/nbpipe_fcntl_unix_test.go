// Copyright 2019 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

//go:build dragonfly || freebsd || linux || netbsd || openbsd || vxworks

package runtime_test

import (
	"internal/syscall/unix"
	"syscall"
)

func fcntl(fd uintptr, cmd int, arg uintptr) (uintptr, syscall.Errno) {
	res, _, err := syscall.Syscall(unix.FcntlSyscall, fd, uintptr(cmd), arg)
	return res, err
}

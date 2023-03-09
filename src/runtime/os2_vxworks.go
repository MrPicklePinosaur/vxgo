// +build vxworks

package runtime

import (
	_ "internal/abi"
	_ "internal/goarch"
	_ "unsafe"
)

//go:cgo_import_dynamic libc_taskParamCtl taskParamCtl "private/taskSysCallP.h"

type libcFunc uintptr

var (
	libc_taskParamCtl libcFunc
)

//go:nosplit
func TaskParamCtl() libcFunc {
    return libc_taskParamCtl
}

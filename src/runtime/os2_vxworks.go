// +build vxworks

package runtime

import (
	_ "internal/abi"
	_ "internal/goarch"
	"unsafe"
)

//go:cgo_import_dynamic libc_taskParamCtl taskParamCtl "libc.so.1"
//go:cgo_import_dynamic libc_dummy dummy "libc.so.1"

//go:linkname libc_taskParamCtl libc_taskParamCtl
//go:linkname libc_dummy libc_dummy

type libcFunc uintptr

var (
	libc_taskParamCtl,
	libc_dummy,
	libc_putchar libcFunc
)

//go:nosplit
//go:cgo_unsafe_args
func taskparamctl(tid uint32, options uint32, tlsbase uintptr) uint64 {

	_g_ := getg()

	_g_.m.libcall.fn = uintptr(unsafe.Pointer(&libc_taskParamCtl))
	_g_.m.libcall.n = 3
	_g_.m.scratch = mscratch{}
	_g_.m.scratch.v[0] = uintptr(tid)
	_g_.m.scratch.v[1] = uintptr(options)
	_g_.m.scratch.v[2] = tlsbase
	_g_.m.libcall.args = uintptr(unsafe.Pointer(&_g_.m.scratch))
	asmcgocall(unsafe.Pointer(&asmsysvicall6x), unsafe.Pointer(&_g_.m.libcall))

	ret := uint64(_g_.m.libcall.r1)

    return ret
}

func TaskParamCtlPtr() *libcFunc {
	return &libc_taskParamCtl
}

//go:nosplit
func Putchar() libcFunc {
    return libc_putchar
}

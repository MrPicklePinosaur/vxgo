
// +build vxworks

package runtime_test

import (
	"fmt"
	"testing"
	. "runtime"
)

func TestTaskParamCtl(t *testing.T) {
	fmt.Printf("%v\n", TaskParamCtlPtr())
}

func TestPutchar(t *testing.T) {
	fmt.Printf("%v\n", Putchar())
}

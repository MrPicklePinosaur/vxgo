
// +build vxworks

package runtime_test

import (
	"testing"
	. "runtime"
)

func TestTaskParamCtl(t *testing.T) {
	TaskParamCtl()
}

package main

import (
	"fmt"
	"github.com/ning1875/common-tools-private"
)

func main() {

	ip := common_tools_private.GetLocalIp()
	fmt.Println("ip", ip)

}

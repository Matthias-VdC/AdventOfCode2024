package main

import (
	"fmt"
	"rules/rules"
)

func main() {
	fmt.Println("Hello world!")
	message := rules.Hello("Matthias")
	fmt.Println(message)
}

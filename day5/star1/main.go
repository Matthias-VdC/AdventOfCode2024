package main

import (
	"fmt"
	"io/ioutil"
	"rules/mods"
	"strings"
)

func main() {
	fmt.Println("Hello world!")
	message := mods.Hello("Matthias")
	fmt.Println(message)
	content, err := ioutil.ReadFile("input")
	if err != nil {
		fmt.Println("Err")
	}
	fmt.Println(string(content))
	strings.Split(string(content), "|")

}

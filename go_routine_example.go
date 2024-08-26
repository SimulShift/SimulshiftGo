package main

import (
	"fmt"
	"time"
)

// A function that will be run as a goroutine
func printNumbers() {
	for i := 1; i <= 5; i++ {
		fmt.Println(i)
		time.Sleep(1 * time.Second) // simulate some work
	}
}

func example() {
	go printNumbers() // start the goroutine

	// Main goroutine continues executing
	for i := 10; i <= 15; i++ {
		fmt.Println(i)
		time.Sleep(500 * time.Millisecond) // simulate some work
	}
}

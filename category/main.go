//goose postgres "user=postgres password=postgres dbname=postgres sslmode=disable" status

//goose postgres "user=postgres password=kali dbname=category_system sslmode=disable" create init_db sql

//goose postgres "user=postgres password=postgres dbname=postgres sslmode=disable" up

//goose postgres "user=postgres password=kali dbname=category_system sslmode=disable" status
package main

import "fmt"

func main() {
	fmt.Println("hello")
}

### Домашнее задание к занятию "7.5. Основы golang"

С `golang` в рамках курса, мы будем работать не много, поэтому можно использовать любой IDE. 
Но рекомендуем ознакомиться с [GoLand](https://www.jetbrains.com/ru-ru/go/).  

#### Задача 1. Установите golang.
1. Воспользуйтесь инструкций с официального сайта: [https://golang.org/](https://golang.org/).
2. Так же для тестирования кода можно использовать песочницу: [https://play.golang.org/](https://play.golang.org/).
```bash
% go version
go version go1.16.1 darwin/arm64
```

#### Задача 2. Знакомство с gotour.
У Golang есть обучающая интерактивная консоль [https://tour.golang.org/](https://tour.golang.org/). 
Рекомендуется изучить максимальное количество примеров. В консоли уже написан необходимый код, 
осталось только с ним ознакомиться и поэкспериментировать как написано в инструкции в левой части экрана.  

#### Задача 3. Написание кода. 
Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода 
на своем компьютере, либо использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные 
у пользователя, а можно статически задать в коде.
    Для взаимодействия с пользователем можно использовать функцию `Scanf`:
    ```
    package main
    
    import "fmt"
    
    func main() {
        fmt.Print("Enter a number: ")
        var input float64
        fmt.Scanf("%f", &input)
    
        output := input * 2
    
        fmt.Println(output)    
    }
    ```
```bash
package main

import "fmt"

func MtoF(m float64)(f float64) {
    f = m * 3.281
    return
}

func main() {
    fmt.Print("Input length in meters: ")
    var input float64
    fmt.Scanf("%f", &input)

    output := MtoF(input)

    fmt.Printf("Footage: %v\n", output)
}
```
 
2. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:
    ```
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    ```
```bash
package main

import "fmt"
import "sort"

func GetMin (toSort []int)(minNum int) {
	sort.Ints(toSort)
	minNum = toSort[0]
	return
}

func main() {
	x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
	y := GetMin(x)
	fmt.Printf("The smallest number in the list: %v\n", y)
}
```
3. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть `(3, 6, 9, …)`.

```bash
package main

import "fmt"

func FilterList ()(devidedWithNoReminder []int) {
	for i := 1;  i <= 100; i ++ {
		if	i % 3 == 0 { 
			devidedWithNoReminder = append(devidedWithNoReminder, i)
		}
	}	
	return
}

func main() {
	toPrint := FilterList()
	fmt.Printf("Numbers from 1 to 100 that are divisible by 3 without a remainder: %v\n", toPrint)
}
```

В виде решения ссылку на код или сам код. 

#### Задача 4. Протестировать код (не обязательно).

Создайте тесты для функций из предыдущего задания. 

```bash
package main

import "testing"

func TestMain(t *testing.T) {
	var v float64
	v = MtoF(21)
	if v != 68.901 {
		t.Error("Expected 68.901, got ", v)
	}
}
```
```bash
% go test MtoF.go MtoF_test.go 
ok      command-line-arguments  0.391s
```
```bash
package main

import "testing"

func TestMain(t *testing.T) {
	var v int
	v = GetMin([]int{63,70,37,34,83})
	if v != 34 {
		t.Error("Expected 34, got ", v)
	}
}
```
```bash
% go test GetMin.go GetMin_test.go 
ok      command-line-arguments  0.438s
```
```bash
package main

import "fmt"
import "testing"

func TestMain(t *testing.T) {
	var v []int
	v = FilterList()
	if v[3] != 12 || v[19] != 60 {
		s := fmt.Sprintf("Expected values 12 and 60, got %v and %v", v[3], v[19])
		t.Error(s)
	}
}
```
```bash
% go test FilterList.go FilterList_test.go
ok      command-line-arguments  0.431s
```
---

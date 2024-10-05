package airportrobot

import "fmt"

type Greeter interface {
	LanguageName() string
	Greet(visitorName string) string
}

// Italian
type Italian struct{}

func (greeter Italian) LanguageName() string {
	return "Italian"
}

func (greeter Italian) Greet(visitorName string) string {
	return fmt.Sprintf("Ciao %s!", visitorName)
}

// Portuguese
type Portuguese struct{}

func (greeter Portuguese) LanguageName() string {
	return "Portuguese"
}

func (greeter Portuguese) Greet(visitorName string) string {
	return fmt.Sprintf("Olá %s!", visitorName)
}

// Functions
func SayHello(visitorName string, greeter Greeter) string {
	const template string = "I can speak %s: %s"

	return fmt.Sprintf(
		template, greeter.LanguageName(), greeter.Greet(visitorName),
	)
}

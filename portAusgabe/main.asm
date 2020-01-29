;
; portAusgabe.asm
;
; Created: 18.12.2019 10:09:43
; Author : rene
;


; Replace with your application code

; Pull-Up Widerstand für PORTB konfigurieren
ldi r17, 0xFF
out PORTB, r17
; PORTB als Eingabe konfigurieren
ldi r17, 0x00
out DDRB, r17
; PORTA als Ausgabe konfigurieren
ldi r17, 0xFF
out DDRA, r17

; Lesbarkeits Aliase
.def eingabe = r17
.def kopie = r18
.def ausgabeReg = r16

; Start Program
endlos:
	; PINB in r17 lesen
	in eingabe, PINB
	; r17 in r18 kopieren
	mov kopie, eingabe

	; Überprüfen ob Bit 3 gesetzt ist
	andi kopie, 0b00000100
	brbc SREG_Z, reset_belegt

	; r16 zu 0b10000000 setzten
	set_belegt:
		sbr ausgabeReg, 0b10101010 ; 0b10000000
		cbr ausgabeReg, 0b01010101 ; 0b01111111

	; r16 an PORTA ausgeben zum Anfang des Programms springen
	ausgabe:
		out PORTA, ausgabeReg
		jmp endlos

	; r16 auf 0b00000000 setzten und dann ausgeben
	reset_belegt:
		cbr ausgabeReg, 0b10101010 ; 0b11111111
		sbr ausgabeReg, 0b01010101
		jmp ausgabe

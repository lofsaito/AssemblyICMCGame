
jmp main

main:
	loadn r1, #tela1linha0 ; endereco da primeira linha da tela
	loadn r6, #40 ;criterio de parada da impressao de telas, ultima tela a ser impressa, voltar para a primeira
	loadn r3, #31  ;incremento da coluna da tela, para shifitar a tela
	loadn r5, #32  ;tecla espaco
	loadn r4, #643 ;posicao inicial do carrinho na tela -200 sobe a rua +200 desce
	store atualpos, r4 ;armazena posição inicial do carrinho na variavel global atualpos
	loadn r4, #479
	store bot1position, r4 ;armazena a posição inicial do bot1 na variavel global correspondente
	loadn r4, #679
	store bot2position, r4 ;armazena a posição inicial do bot2 na variavel global correspondente
	loadn r4, #879
	store bot3position, r4 ;armazena a posição inicial do bot3 na variavel global correspondente
	loadn r4, #0
	store botsizecounter, r4
	
	
	loadn r2, #1536 ;cor do mapa
	call imprimeTela
	loadn r2, #0 ;cor da escrita na tela
	loadn r1, #start
    call Imprimestr
	loadn r1, #tela1linha0
	loadn r2, #1536 ;cor do mapa
	

	;loop tela inicial antes de apertar espaco para comecar
	loopinit:
		inchar r4
		cmp r4, r5
	jne loopinit
	loadn r5, #1
	
	
		loop:
		store screen, r1
		;call colisao
		call imprimeTela
		;load r4, colisaoflag
		;cmp r4, r5
		;jeq endfunc
		inc r7 ;incrementa contador para indicar quando a tela deve voltar ao inicio
		add r1, r1, r3  ;anda uma coluna para frente a partir da posicao atual da tela
		;store screen, r1 ;referencia para colisao
		cmp r6, r7 ;criterio para reset
		jeq reset
		call delay
		jmp loop
	reset:
		loadn r1, #tela1linha0 ;reinicia a sequencia de telas
		store screen, r1
		loadn r7, #0
		jmp loop
	halt
	
	
botsGerador:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	loadn r6, #40
	load r0, bot1position
	
	
	loadn r2, #1280 ;cor do carrinho 
	loadn r1, #carlinha0
    call Imprimestr
    ;loadn r2, #0 ;cor do carrinho
    add r0, r0, r6
	loadn r1, #carlinha1
    call Imprimestr
    ;loadn r2, #0 ;cor do carrinho 
    add r0, r0, r6
	loadn r1, #carlinha2
    call Imprimestr
    ;loadn r2, #2048 ;cor do carrinho 
    add r0, r0, r6
	loadn r1, #carlinha3
    call Imprimestr
	
	;3 bots um para cada via da pista
	;primeira via posição inicial do bot 479, final 440
	;segunda via posição inicial do bot 679, final 640
	;terceira via posição inicial do bot 879, final 840
	
botsGeradorFim:	
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts	
	
imprimeCarro:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	loadn r4, #119
	loadn r5, #115
	;load r0, atualpos
	loadn r6, #40
	
	inchar r3 ;captura tecla da tela para verificar se troca via da pista
	cmp r3, r4
	ceq subir
	
	cmp r3, r5
	ceq descer
	
	load r0, atualpos
	
	loadn r2, #0 ;cor do carrinho 
	loadn r1, #carlinha0
    call Imprimestr
    ;loadn r2, #0 ;cor do carrinho
    add r0, r0, r6
	loadn r1, #carlinha1
    call Imprimestr
    ;loadn r2, #0 ;cor do carrinho 
    add r0, r0, r6
	loadn r1, #carlinha2
    call Imprimestr
    ;loadn r2, #2048 ;cor do carrinho 
    add r0, r0, r6
	loadn r1, #carlinha3
    call Imprimestr
	
	;inchar r3 ;captura tecla da tela para verificar pulo
	;cmp r3, r4
	;ceq jumpactive
	;call gravidade ;chama funcao gravidade
	;call jump ;chama funcao pulo
	
	;loadn r1, #'H'

	;outchar r1, r5 ;imprime personagem na tela
	;call colisao
	
	
imprimeCarroFim:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts	
	
subir:
	push r0
	push r1
	push r2
	loadn r2, #443
	;643 - 200 = 443 max top
	loadn r1, #200
	load r0, atualpos
	cmp r0, r2
	jeq subirFim
	sub r0, r0, r1
	store atualpos, r0
	
subirFim:
	pop r2
	pop r1
	pop r0
	rts
	

descer:
	push r0
	push r1
	push r2
	loadn r2, #843
	;643 + 200 = 843 max bottom
	loadn r1, #200
	load r0, atualpos
	cmp r0, r2
	jeq descerFim
	add r0, r0, r1
	store atualpos, r0

descerFim:
	pop r2
	pop r1
	pop r0
	rts
	
imprimeTela:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	loadn r0, #0 ; pos inicial OBS: TEM QUE SER O COMECO DA Tela
	loadn r3, #1 ; Incremento da pos da tela
	loadn r4, #31 ; Incremento do ponteiro das linhas da tela
	loadn r5, #40 ; Limite da tela, criterio de parada
	loadn r7, #12
	
	ImprimeTelaLoop:
		call Imprimecoluna
		
		add r0, r0, r3 ; Incrementa pos para a segunda linha na tela --> r0 = r0 + 40
		add r1, r1, r4 ; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 ...)
		cmp r7, r0
		ceq imprimeCarro
		 ;call botsGerador
		cmp r0, r5 ; compara r0 com 1200
		jne ImprimeTelaLoop ; Enquanto r0 < 1200
		
	
	pop r7
	pop r6
	pop	r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	
	rts

Imprimestr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

ImprimestrLoop:	
	loadi r4, r1 ; passa o conteudo do end. da string para r4
	cmp r4, r3 ; compara com o criterio de parada
	jeq ImprimestrSai ; se for igual termina
	add r4, r2, r4 ; add cor
	outchar r4, r0 ; imprime na tela na pos armazenada por r0
	inc r0 ; caminha a pos na tela
	inc r1 ; caminha o ponteiro da str
	jmp ImprimestrLoop
	
ImprimestrSai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
Imprimecoluna:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5
	
	loadn r3, #'\0'	; Criterio de parada4
	;loadn r5, #40 ;incremento de 40 para pegar a proxima posição a ser impressa

ImprimecolunaLoop:	
	loadi r4, r1 ; passa o conteudo do end. da string para r4
	cmp r4, r3 ; compara com o criterio de parada
	jeq ImprimecolunaSai ; se for igual termina
	add r4, r2, r4 ; add cor
	outchar r4, r0 ; imprime na tela na pos armazenada por r0
	add r0, r0, r5 ; caminha a pos na tela
	inc r1 ; caminha o ponteiro da str
	jmp ImprimecolunaLoop
	
ImprimecolunaSai:	
	pop r5
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
delay:
	push r0
	push r1

	loadn r0, #5
decx:
	loadn r1, #3000
decy:
	dec r1
	jnz decy
	dec r0
	jnz decx

	pop r1
	pop r0
	rts	

flagrodar: var #1
atualpos: var #1
gameover: string "            GAME OVER                   "
start: string "       Press Space To Start             "
screen: var #1 
bot1position: var #1	;posição da tela na via 1 bot1
bot2position: var #1	;posição da tela na via 2 bot2
bot3position: var #1	;posição da tela na via 3 bot3
botsizecounter: var #1


tela1linha0:   string "          -    -    -    -    "
tela1linha1:   string "          -              -    "
tela1linha2:   string "          -    -    -    -    "
tela1linha3:   string "          -              -    "
tela1linha4:   string "          -    -    -    -    "
tela1linha5:   string "          -              -    "
tela1linha6:   string "          -    -    -    -    "
tela1linha7:   string "          -              -    "
tela1linha8:   string "          -    -    -    -    "
tela1linha9:   string "          -              -    "
tela1linha10:  string "          -    -    -    -    "
tela1linha11:  string "          -              -    "
tela1linha12:  string "          -    -    -    -    "
tela1linha13:  string "          -              -    "
tela1linha14:  string "          -    -    -    -    "
tela1linha15:  string "          -              -    "
tela1linha16:  string "          -    -    -    -    "
tela1linha17:  string "          -              -    "
tela1linha18:  string "          -    -    -    -    "
tela1linha19:  string "          -              -    "
tela1linha20:  string "          -    -    -    -    "
tela1linha21:  string "          -              -    "
tela1linha22:  string "          -    -    -    -    "
tela1linha23:  string "          -              -    "
tela1linha24:  string "          -    -    -    -    "
tela1linha25:  string "          -              -    "
tela1linha26:  string "          -    -    -    -    "
tela1linha27:  string "          -              -    "
tela1linha28:  string "          -    -    -    -    "
tela1linha29:  string "          -              -    "
tela1linha30:  string "          -    -    -    -    "
tela1linha31:  string "          -              -    "
tela1linha32:  string "          -    -    -    -    "
tela1linha33:  string "          -              -    "
tela1linha34:  string "          -    -    -    -    "
tela1linha35:  string "          -              -    "
tela1linha36:  string "          -    -    -    -    "
tela1linha37:  string "          -              -    "
tela1linha38:  string "          -    -    -    -    "
tela1linha39:  string "          -              -    "

tela1linha40:	string "          -    -    -    -    "
tela1linha41:	string "          -              -    "
tela1linha42:	string "          -    -    -    -    "
tela1linha43:	string "          -              -    "
tela1linha44:	string "          -    -    -    -    "
tela1linha45:	string "          -              -    "
tela1linha46:	string "          -    -    -    -    "
tela1linha47:	string "          -              -    "
tela1linha48:	string "          -    -    -    -    "
tela1linha49:	string "          -              -    "
tela1linha50:	string "          -    -    -    -    "
tela1linha51:	string "          -              -    "
tela1linha52:	string "          -    -    -    -    "
tela1linha53:	string "          -              -    "
tela1linha54:	string "          -    -    -    -    "
tela1linha55:	string "          -              -    "
tela1linha56:	string "          -    -    -    -    "
tela1linha57:	string "          -              -    "
tela1linha58:	string "          -    -    -    -    "
tela1linha59:	string "          -              -    "
tela1linha60:	string "          -    -    -    -    "
tela1linha61:	string "          -              -    "
tela1linha62:	string "          -    -    -    -    "
tela1linha63:	string "          -              -    "
tela1linha64:	string "          -    -    -    -    "
tela1linha65:	string "          -              -    "
tela1linha66:	string "          -    -    -    -    "
tela1linha67:	string "          -              -    "
tela1linha68:	string "          -    -    -    -    "
tela1linha69:	string "          -              -    "
tela1linha70:	string "          -    -    -    -    "
tela1linha71:	string "          -              -    "
tela1linha72:	string "          -    -    -    -    "
tela1linha73:	string "          -              -    "
tela1linha74:	string "          -    -    -    -    "
tela1linha75:	string "          -              -    "
tela1linha76:	string "          -    -    -    -    "
tela1linha77:	string "          -              -    "
tela1linha78:	string "          -    -    -    -    "
tela1linha79:	string "          -              -    "

carlinha0:	string " +@ - @| "
carlinha1:	string "[<[##]>>]"
carlinha2:	string "[<[##]>>]"
carlinha3:	string " +@ - @| "

botlinha0: string " || "
botlinha1: string "|--|"
botlinha2: string "O--O"
botlinha3: string "|--|"
botlinha4: string " () "
botlinha5: string "|()|"
botlinha6: string "O--O"
botlinha7: string "|--|"
botlinha8: string " -- "

randposition: var #8
static randposition + #0, #0
static randposition + #1, #2
static randposition + #2, #0
static randposition + #3, #1
static randposition + #4, #2
static randposition + #5, #1
static randposition + #6, #0
static randposition + #7, #2
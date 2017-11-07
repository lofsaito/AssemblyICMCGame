
jmp main

main:
	loadn r4, #1
	store selectedCar, r4		;persistencia das escolhas do jogador apos reiniciar o jogo
	store selectedColor, r4
	resetgame:
		loadn r7, #0 ;inicializacao de flags
		store colisaoflag, r7
		loadn r6, #40 ;criterio de parada da impressao de telas, ultima tela a ser impressa, voltar para a primeira
		loadn r3, #31  ;incremento da coluna da tela, para shifitar a tela
		loadn r4, #643 ;posicao inicial do carrinho na tela -200 sobe a rua +200 desce
		store atualpos, r4 ;armazena posição inicial do carrinho na variavel global atualpos
		loadn r4, #12
		store altura, r4 ;altura inicial do carro na tela logica
		
		;===============tela inicial================
		
		call movecursor ;função responsavel por imprimir o menu inicial e mover o cursor na tela
		
		;==============fim tela inicial===============
		loadn r2, #1536 ;cor do mapa
		loadn r1, #tela1linha0 ; endereco da primeira linha da tela
		loadn r5, #1
		loadn r6, #200 ;criterio de parada da impressao de telas, ultima tela a ser impressa, voltar para a primeira
		
		;==============Loop principal do jogo==========
			loop:
			store screen, r1
			call imprimeTela
			load r4, colisaoflag
			cmp r4, r5
			jeq endfunc
			inc r7 ;incrementa contador para indicar quando a tela deve voltar ao inicio
			add r1, r1, r3  ;anda uma coluna para frente a partir da posicao atual da tela
			;store screen, r1 ;referencia para colisao
			cmp r6, r7 ;criterio para reset
			jeq reset
			jmp loop
		reset:
			loadn r1, #tela1linha0 ;reinicia a sequencia de telas
			store screen, r1
			loadn r7, #0
			jmp loop
			
		endfunc:
			call explosion
			loadn r1, #gameover
			loadn r0, #81
			loadn r2, #2304
			call Imprimestr
			loadn r1, #restart
			loadn r0, #161
			loadn r2, #0
			call Imprimestr
			
			loadn r5, #32
			loopend:
				call fireexplosion
				inchar r4
				cmp r4, r5
			jne loopend
			jmp resetgame
			
	halt
	
	
pausar:
	push r0
	push r1
	push r2
	push r3
	loadn r1, #'p'
	
	loadn r0, #' '
	loadn r1, #pause
	loadn r0, #81
	loadn r2, #768
	call Imprimestr
	loadn r1, #'p'
	pausarLoop:
		inchar r0
		cmp r0, r1
	jne pausarLoop

pausarFim:
	pop r3
	pop r2
	pop r1
	pop r0
	rts

explosion:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	loadn r7, #2
	loadn r6, #40	
	
	loadn r5, #1
	load r4, selectedColor
	cmp r5, r4
	jeq whiteexplosion
	inc r5
	cmp r5, r4
	jeq redexplosion
	loadn r2, #512 ;cor do carrinho 
	jmp printexplosion
	
	whiteexplosion: 
		loadn r2, #0 ;cor do carrinho 
		jmp printexplosion
	redexplosion:
		loadn r2, #2304 ;cor do carrinho 
	
	printexplosion:
		load r0, atualpos
		sub r0, r0, r6
		loadn r1, #explosion0
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #explosion1
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #explosion2
	    call Imprimestr 
	    add r0, r0, r6
		loadn r1, #explosion3
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #explosion4
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #explosion5
	    call Imprimestr
	    
	    load r0, atualpos
	    sub r0, r0, r6
	    sub r0, r0, r6
	    sub r0, r0, r7
	    
	    call delay
	    
	    loadn r1, #explosion6
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #explosion7
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #explosion8
	    call Imprimestr 
	    add r0, r0, r6
		loadn r1, #explosion9
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #explosion10
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #explosion11
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #explosion12
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #explosion13
	    call Imprimestr

explosionFim:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
fireexplosion:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	loadn r6, #40
	loadn r7, #2
	
	load r0, atualpos
    sub r0, r0, r6
    sub r0, r0, r6
    sub r0, r0, r7
    
    
    loadn r2, #2816 ;cor do carrinho 
    
    loadn r1, #explosion6
    call Imprimestr
    add r0, r0, r6
	loadn r1, #explosion7
    call Imprimestr
    add r0, r0, r6
	loadn r1, #explosion8
    call Imprimestr 
    add r0, r0, r6
	loadn r1, #explosion9
    call Imprimestr
    add r0, r0, r6
	loadn r1, #explosion10
    call Imprimestr
    add r0, r0, r6
	loadn r1, #explosion11
    call Imprimestr
    add r0, r0, r6
	loadn r1, #explosion12
    call Imprimestr
    add r0, r0, r6
	loadn r1, #explosion13
    call Imprimestr
    
    call delay
    
	load r0, atualpos
    sub r0, r0, r6
    sub r0, r0, r6
    sub r0, r0, r7
    
    loadn r2, #2304 ;cor do carrinho 
    
    loadn r1, #explosion6
    call Imprimestr
    add r0, r0, r6
	loadn r1, #explosion7
    call Imprimestr
    add r0, r0, r6
	loadn r1, #explosion8
    call Imprimestr 
    add r0, r0, r6
	loadn r1, #explosion9
    call Imprimestr
    add r0, r0, r6
	loadn r1, #explosion10
    call Imprimestr
    add r0, r0, r6
	loadn r1, #explosion11
    call Imprimestr
    add r0, r0, r6
	loadn r1, #explosion12
    call Imprimestr
    add r0, r0, r6
	loadn r1, #explosion13
    call Imprimestr
    call delay
	
fireexplosionFim:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

movecursor:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	
	telaInicialLoop:
		loadn r1, #starttela1linha0 ; endereco da primeira linha da tela
		loadn r2, #768 ;cor do mapa
		call imprimeTelaInit ;imprime a tela inicial
		
		loadn r4, #327		;posição inicial do cursor na tela
		store cursor, r4
		
		;imprime opições do menu da tela inicial
		loadn r2, #0
		loadn r0, #321
		loadn r1, #start
		call Imprimestr
		loadn r0, #441
		loadn r1, #selection
		call Imprimestr
		loadn r2, #3584
		loadn r0, #121
		loadn r1, #gamename
		call Imprimestr
		loadn r0, #804
		loadn r1, #text0
		call Imprimestr
		loadn r0, #884
		loadn r1, #text1
		call Imprimestr
		loadn r0, #924
		loadn r1, #text2
		call Imprimestr
		
		;carrega e imprime o cursor na tela
		loadn r5, #'>'
		load r4, cursor
		
		outchar r5, r4
		
		loadn r0, #327 ;posição da primeira opição da tela inicial
		loadn r1, #447 ;posição da segunda opição da tela inicial
		loadn r5, #32  ;tecla espaco
		
		loadn r3, #119	;letra w move para cima
		loadn r4, #115	; letra s move para baixo
		
		;loop para mover o cursor na tela
		cursorloop:
			inchar r2 ;captura tecla da tela para verificar se troca via da pista
			cmp r2, r3
			ceq cursorup
		
			cmp r2, r4
			ceq cursordown
			
			cmp r2, r5
			jeq checkPosition
			jmp cursorloop
			
		;verifica posição do cursor na tela quando o jogador aperta espaço
		;utilizada para selecionar uma opição na tela
		checkPosition:
			load r6, cursor
			cmp r0, r6
			jeq movecursorFim ;começa jogo
			cmp r1, r6
			ceq carCustomize ;tela para customizar o carrinho
	jmp telaInicialLoop
	
movecursorFim:
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
carCustomize:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	;============Imprime primeira versão da tela de customização do carrinho=============
	loadn r6, #40
	loadn r1, #starttela1linha0
	
	loadn r2, #768 ;cor do mapa
	call imprimeTelaInit
	
	loadn r4, #327
	store cursor, r4
	
	loadn r2, #0
	loadn r0, #321
	loadn r1, #selectcolor
	call Imprimestr
	loadn r0, #441
	loadn r1, #selectcar
	call Imprimestr
	
	loadn r2, #0
	loadn r0, #335
	load r4, selectedColor
	loadn r3, #1
	cmp r3, r4
	jeq startwhitecolor
	inc r3
	cmp r3, r4
	jeq startredcolor
	loadn r1, #cor3string
	call Imprimestr
	jmp typeselect
	
	startwhitecolor:
		loadn r1, #cor1string
		call Imprimestr
		jmp typeselect
	startredcolor:
		loadn r1, #cor2string
		call Imprimestr
	
	typeselect:
		loadn r0, #460
		load r4, selectedCar
		loadn r3, #1
		cmp r3, r4
		jeq starttype1
		inc r3
		cmp r3, r4
		jeq starttype2
		loadn r1, #carmodel3
		call Imprimestr
		jmp checkcartoprint
		
		starttype1:
			loadn r1, #carmodel1
			call Imprimestr
			jmp checkcartoprint
		starttype2:
			loadn r1, #carmodel2
			call Imprimestr
	
	checkcartoprint:
		call changecar
		loadn r0, #801
		loadn r1, #voltar
		call Imprimestr
		loadn r2, #3584
		loadn r0, #121
		loadn r1, #gamename
		call Imprimestr
		
		loadn r5, #'>'
		load r4, cursor
		
		outchar r5, r4
		
		;============Fim da impressão da primeira versão da tela de customização do carrinho=============
		
		loadn r5, #32  ;tecla espaco
		
		loadn r3, #119 ;W cursor para cima
		loadn r4, #115 ;S cursor para baixo
		loadn r0, #97 ;A cursor para esquerda
		loadn r1, #100 ;D cursor para direita 
		
	;loop da tela de customização do carrinho
	customizeloop:
		inchar r2 ;captura tecla da tela para verificar se troca via da pista
		cmp r2, r3
		ceq cursoruptwo
	
		cmp r2, r4
		ceq cursordowntwo
	
		cmp r2, r0
		jeq checkcursorleft
		cmp r2, r1
		jeq checkcursorright
		
		cmp r2, r5
		jeq checkcursorspace
		jmp customizeloop
	
	;verifica opição selecionada, cor ou tipo do carrinho, mudando para o lado esquerdo	
	checkcursorleft:
		loadn r0, #327
		loadn r1, #447
		load r6, cursor
		cmp r0, r6
		ceq colorChangeleft
		cmp r1, r6
		ceq carSelectleft
		loadn r0, #97 ;cursor para esquerda
		loadn r1, #100 ;cursor para direita 
		jmp customizeloop
	
	;verifica opição selecionada, cor ou tipo do carrinho, mudando para o lado direito
	checkcursorright:
		loadn r0, #327
		loadn r1, #447
		load r6, cursor
		cmp r0, r6
		ceq colorChangeright
		cmp r1, r6
		ceq carSelectright
		loadn r0, #97 ;cursor para esquerda
		loadn r1, #100 ;cursor para direita 
		jmp customizeloop
		
	;caso o jogador pressione espaço verifica se é para sair da tela de customização do carrinho
	checkcursorspace:	
		loadn r7, #807
		load r6, cursor
		cmp r7, r6
		jeq carCustomizeFim
		jmp customizeloop
		
carCustomizeFim:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
;função que muda a cor do carrinho quando o jogador apertou A(esquerda)
colorChangeleft:
	push r0
	push r1
	push r2
	push r3
	push r4
	
	load r4, selectedColor
	loadn r3, #1

	cmp r3, r4
	jeq colorChangeleftFim
	inc r3
	cmp r3, r4
	jeq whitecolor
	inc r3
	cmp r3, r4
	jeq redcolor
	
	whitecolor:
		loadn r2, #0
		loadn r0, #335
		loadn r1, #cor1string
		call Imprimestr
		loadn r3, #1
		store selectedColor, r3
		call changecar
		jmp colorChangeleftFim
		
	redcolor:
		loadn r2, #0
		loadn r0, #335
		loadn r1, #cor2string
		call Imprimestr
		loadn r3, #2
		store selectedColor, r3
		call changecar
		jmp colorChangeleftFim
		
colorChangeleftFim:		
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;função que muda a cor do carrinho quando o jogador apertou D(direita)
colorChangeright:
	push r0
	push r1
	push r2
	push r3
	push r4
	
	;min 1 max 3
	load r4, selectedColor
	loadn r3, #1

	cmp r3, r4
	jeq redcolor
	inc r3
	cmp r3, r4
	jeq greencolor
	jmp colorChangerightFim
		
	redcolor:
		loadn r2, #0
		loadn r0, #335
		loadn r1, #cor2string
		call Imprimestr
		loadn r3, #2
		store selectedColor, r3
		call changecar
		jmp colorChangeleftFim
	
	greencolor:
		loadn r2, #0
		loadn r0, #335
		loadn r1, #cor3string
		call Imprimestr
		loadn r3, #3
		store selectedColor, r3
		call changecar

colorChangerightFim:
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;função que muda o tipo do carrinho quando o jogador apertou A(esquerda)
carSelectleft:
	push r0
	push r1
	push r2
	push r3
	push r4
	
	;min 1 max 3
	load r4, selectedCar
	loadn r3, #1
	
	cmp r3, r4
	jeq carSelectleftFim
	inc r3
	cmp r3, r4
	jeq type1
	inc r3
	cmp r3, r4
	jeq type2
	
	type1:
		loadn r2, #0
		loadn r0, #460
		loadn r1, #carmodel1
		call Imprimestr
		loadn r3, #1
		store selectedCar, r3
		call changecar
		jmp carSelectleftFim
		
	type2:
		loadn r2, #0
		loadn r0, #460
		loadn r1, #carmodel2
		call Imprimestr
		loadn r3, #2
		store selectedCar, r3
		call changecar

carSelectleftFim:
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;função que muda o tipo do carrinho quando o jogador apertou D(direita)	
carSelectright:
	push r0
	push r1
	push r2
	push r3
	push r4
	
	;min 1 max 3
	load r4, selectedCar
	loadn r3, #1
	
	cmp r3, r4
	jeq type2
	inc r3
	cmp r3, r4
	jeq type3
	jmp carSelectrightFim
		
	type2:
		loadn r2, #0
		loadn r0, #460
		loadn r1, #carmodel2
		call Imprimestr
		loadn r3, #2
		store selectedCar, r3
		call changecar
		jmp carSelectleftFim
		
	type3:
		loadn r2, #0
		loadn r0, #460
		loadn r1, #carmodel3
		call Imprimestr
		loadn r3, #3
		store selectedCar, r3
		call changecar

carSelectrightFim:
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;função responsavel por imprimir o carrinho na tela há mudança de cor ou tipo	
changecar:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	loadn r5, #1
	loadn r6, #40
	load r4, selectedColor
	cmp r5, r4
	jeq whitecar
	inc r5
	cmp r5, r4
	jeq redcar
	loadn r2, #512 ;cor do carrinho 
	jmp reprintcar
	
	whitecar: 
		loadn r2, #0 ;cor do carrinho 
		jmp reprintcar
	redcar:
		loadn r2, #2304 ;cor do carrinho 
	
	reprintcar:
		loadn r5, #1
		load r4, selectedCar
		
		cmp r5, r4
		jeq type1car
		inc r5
		cmp r5, r4
		jeq type2car
		loadn r0, #575
		loadn r1, #car3linha0
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #car3linha1
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #car3linha2
	    call Imprimestr 
	    add r0, r0, r6
		loadn r1, #car3linha3
	    call Imprimestr
	    jmp changecarFim
	    
	    type1car:
			loadn r0, #575
			loadn r1, #carlinha0
		    call Imprimestr
		    add r0, r0, r6
			loadn r1, #carlinha1
		    call Imprimestr
		    add r0, r0, r6
			loadn r1, #carlinha2
		    call Imprimestr 
		    add r0, r0, r6
			loadn r1, #carlinha3
		    call Imprimestr
		    jmp changecarFim
		    
		type2car:
			loadn r0, #575
			loadn r1, #car2linha0
		    call Imprimestr
		    add r0, r0, r6
			loadn r1, #car2linha1
		    call Imprimestr
		    add r0, r0, r6
			loadn r1, #car2linha2
		    call Imprimestr 
		    add r0, r0, r6
			loadn r1, #car2linha3
		    call Imprimestr
	
changecarFim:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;sobe cursor
cursorup:
	push r0
	push r1
	
	loadn r1, #' '
	
	load r0, cursor
	outchar r1, r0
	
	loadn r0, #327
	loadn r1, #'>'
	
	outchar r1, r0
	store cursor, r0
	
	pop r1
	pop r0
	rts

;desce cursor	
cursordown:
	push r0
	push r1
	
	loadn r1, #' '
	
	load r0, cursor
	outchar r1, r0
	
	loadn r0, #447
	loadn r1, #'>'
	
	outchar r1, r0
	store cursor, r0
	
	pop r1
	pop r0
	rts

;sobe cursor quando a posição é  a ultima da tela de customização do carrinho
cursoruptwo:
	push r0
	push r1
	push r2
	
	loadn r2, #807
	loadn r1, #' '
	load r0, cursor
	outchar r1, r0
	
	loadn r1, #'>'
	
	
	cmp r0, r2
	jeq uptwo
	loadn r0, #327
	outchar r1, r0
	store cursor, r0
	jmp cursoruptwoFim
	
	uptwo:
		loadn r0, #447
		outchar r1, r0
		store cursor, r0
		


cursoruptwoFim:
	pop r2
	pop r1
	pop r0
	rts

;desce cursor quando a posição é  a ultima da tela de customização do carrinho	
cursordowntwo:
	push r0
	push r1
	push r2
	
	loadn r1, #' '
	
	load r0, cursor
	outchar r1, r0
	
	loadn r2, #447
	loadn r1, #'>'
	cmp r0, r2
	jeq downtwo
	loadn r2, #807
	cmp r0, r2
	jeq downtwo
	loadn r0, #447
	
	outchar r1, r0
	store cursor, r0
	jmp cursordowntwoFim
		
	downtwo:
		loadn r0, #807
		outchar r1, r0
		store cursor, r0
		
cursordowntwoFim:	
	pop r2
	pop r1
	pop r0
	rts
	
colisaoactive:
	push r0
	loadn r0, #1
	store colisaoflag, r0 
	pop r0
	rts
	
colisao:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	load r1, screen
	
	loadn r2, #346  
	load r5, altura
	add r1, r1, r2
	add r1, r1, r5

	loadn r6, #'#'
	
	loadi r3, r1
	cmp r3, r6
	ceq colisaoactive
	
	;contador tamanho do carro
	loadn r5, #0 
	loadn r7, #8
	colisaoLoop:
		loadn r4, #31
		sub r1, r1, r4
		loadi r3, r1
		cmp r3, r6
		ceq colisaoactive
		inc r5
		cmp r5, r7
		jle colisaoLoop		

colisaoFim:
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
	loadn r6, #40
	loadn r7, #'p'
	
	inchar r3 ;captura tecla da tela para verificar se troca via da pista
	cmp r3, r4
	ceq subir
	
	cmp r3, r5
	ceq descer
	
	;cmp r3, r7
	;ceq pausar
	
	load r0, atualpos
	
	loadn r5, #1
	load r4, selectedColor
	cmp r5, r4
	jeq whitecarprint
	inc r5
	cmp r5, r4
	jeq redcarprint
	loadn r2, #512 ;cor do carrinho 
	jmp printcar
	
	whitecarprint: 
		loadn r2, #0 ;cor do carrinho 
		jmp printcar
	redcarprint:
		loadn r2, #2304 ;cor do carrinho 
	
	printcar:
		loadn r5, #1
		load r4, selectedCar
		
		cmp r5, r4
		jeq type1carprint
		inc r5
		cmp r5, r4
		jeq type2carprint
		loadn r1, #car3linha0
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #car3linha1
	    call Imprimestr
	    add r0, r0, r6
		loadn r1, #car3linha2
	    call Imprimestr 
	    add r0, r0, r6
		loadn r1, #car3linha3
	    call Imprimestr
	    jmp colisaoCheck
	    
	    type1carprint:
			loadn r1, #carlinha0
		    call Imprimestr
		    add r0, r0, r6
			loadn r1, #carlinha1
		    call Imprimestr
		    add r0, r0, r6
			loadn r1, #carlinha2
		    call Imprimestr 
		    add r0, r0, r6
			loadn r1, #carlinha3
		    call Imprimestr
		    jmp colisaoCheck
		    
		type2carprint:
			loadn r1, #car2linha0
		    call Imprimestr
		    add r0, r0, r6
			loadn r1, #car2linha1
		    call Imprimestr
		    add r0, r0, r6
			loadn r1, #car2linha2
		    call Imprimestr 
		    add r0, r0, r6
			loadn r1, #car2linha3
		    call Imprimestr
		    
	colisaoCheck:   
		call colisao
		
	cmp r3, r7
	ceq pausar
	
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
	push r3
	loadn r2, #443
	;643 - 200 = 443 max top
	loadn r1, #200
	load r0, atualpos
	cmp r0, r2
	jeq subirFim
	sub r0, r0, r1
	store atualpos, r0
	load r0, altura
	loadn r3, #6
	sub r0, r0, r3
	store altura, r0
	
subirFim:
	pop r3
	pop r2
	pop r1
	pop r0
	rts

descer:
	push r0
	push r1
	push r2
	push r3
	loadn r2, #843
	;643 + 200 = 843 max bottom
	loadn r1, #200
	load r0, atualpos
	cmp r0, r2
	jeq descerFim
	add r0, r0, r1
	store atualpos, r0
	load r0, altura
	loadn r3, #6
	add r0, r0, r3
	store altura, r0

descerFim:
	pop r3
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
		
		add r0, r0, r3 ; Incrementa pos para a segunda linha na tela --> r0 = r0 + 1
		add r1, r1, r4 ; incrementa o ponteiro para o comeco da proxima linha na memoria (30 + 1 ...)
		cmp r7, r0
		ceq imprimeCarro
		cmp r0, r5 ; compara r0 com 40
		jne ImprimeTelaLoop ; Enquanto r0 < 40
	
	pop r7
	pop r6
	pop	r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
imprimeTelaInit:
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

ImprimeTelaInitLoop:
	call Imprimecoluna
	
	add r0, r0, r3 ; Incrementa pos para a segunda linha na tela --> r0 = r0 + 1
	add r1, r1, r4 ; incrementa o ponteiro para o comeco da proxima linha na memoria (30 + 1 ...)
	cmp r0, r5 ; compara r0 com 40
	jne ImprimeTelaInitLoop ; Enquanto r0 < 40
	
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

	loadn r0, #50
decx:
	loadn r1, #800000
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
gameover: string "               DERROTA!                 "
restart: string "      espaco para voltar ao menu        "
gamename: string "          SAO CARLOS STREET           "
start: string "         Iniciar um novo jogo         "
selection: string "         Customize seu carro          "
voltar: string "           Salvar e Voltar            "
pause: string "             ::PAUSADO::               "

text0: string " Nenhum carro eh indestrutivel!"
text1: string "    Sobreviva aos buracos nas   "
text2: string "    ruas de Sao Carlos. "

selectcolor: string "           Cor: < Branco >            "
selectcar: string "          Carro: < Tipo 1 >           "

cor1string: string " < Branco >  "  ;#0
cor2string: string " < Vermelho >"  ;#2304
cor3string: string " < Verde >   "  ;512

carmodel1: string "Tipo 1"
carmodel2: string "Tipo 2"
carmodel3: string "Tipo 3"
               
screen: var #1 
colisaoflag: var #1
altura: var #1
score: var #1
cursor: var #1
selectedCar: var #1
selectedColor: var #1

starttela1linha0:   string "##############################"
starttela1linha1:   string "#                            #"
starttela1linha2:   string "#                            #"
starttela1linha3:   string "#                            #"
starttela1linha4:   string "#                            #"
starttela1linha5:   string "#                            #"
starttela1linha6:   string "#                            #"
starttela1linha7:   string "#                            #"
starttela1linha8:   string "#                            #"
starttela1linha9:   string "#                            #"
starttela1linha10:  string "#                            #"
starttela1linha11:  string "#                            #"
starttela1linha12:  string "#                            #"
starttela1linha13:  string "#                            #"
starttela1linha14:  string "#                            #"
starttela1linha15:  string "#                            #"
starttela1linha16:  string "#                            #"
starttela1linha17:  string "#                            #"
starttela1linha18:  string "#                            #"
starttela1linha19:  string "#                            #"
starttela1linha20:  string "#                            #"
starttela1linha21:  string "#                            #"
starttela1linha22:  string "#                            #"
starttela1linha23:  string "#                            #"
starttela1linha24:  string "#                            #"
starttela1linha25:  string "#                            #"
starttela1linha26:  string "#                            #"
starttela1linha27:  string "#                            #"
starttela1linha28:  string "#                            #"
starttela1linha29:  string "#                            #"
starttela1linha30:  string "#                            #"
starttela1linha31:  string "#                            #"
starttela1linha32:  string "#                            #"
starttela1linha33:  string "#                            #"
starttela1linha34:  string "#                            #"
starttela1linha35:  string "#                            #"
starttela1linha36:  string "#                            #"
starttela1linha37:  string "#                            #"
starttela1linha38:  string "#                            #"
starttela1linha39:  string "##############################"

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
tela1linha31:  string "          -     ####     -    "
tela1linha32:  string "          -    -    -    -    "
tela1linha33:  string "          -              -    "
tela1linha34:  string "          -####-    -    -    "
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
tela1linha56:	string "          -    -####-    -    "
tela1linha57:	string "          -          ####-    "
tela1linha58:	string "          -    -    -    -    "
tela1linha59:	string "          -              -    "
tela1linha60:	string "          -    -    -    -    "
tela1linha61:	string "          -              -    "
tela1linha62:	string "          -    -    -    -    "
tela1linha63:	string "          -              -    "
tela1linha64:	string "          -    -    -    -    "
tela1linha65:	string "          -              -    "
tela1linha66:	string "          -    -    -####-    "
tela1linha67:	string "          -              -    "
tela1linha68:	string "          -####-    -    -    "
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
tela1linha79:	string "          -     ####     -    "

tela1linha80:	string "          -    -    -    -    "
tela1linha81:	string "          -              -    "
tela1linha82:	string "          -    -    -    -    "
tela1linha83:	string "          -              -    "
tela1linha84:	string "          -    -    -    -    "
tela1linha85:	string "          -              -    "
tela1linha86:	string "          -    -    -    -    "
tela1linha87:	string "          -              -    "
tela1linha88:	string "          -    -    -    -    "
tela1linha89:	string "          -####          -    "
tela1linha90:	string "          -    -####-    -    "
tela1linha91:	string "          -              -    "
tela1linha92:	string "          -    -    -    -    "
tela1linha93:	string "          -              -    "
tela1linha94:	string "          -    -    -    -    "
tela1linha95:	string "          -              -    "
tela1linha96:	string "          -    -    -    -    "
tela1linha97:	string "          -              -    "
tela1linha98:	string "          -    -    -    -    "
tela1linha99:	string "          -              -    "
tela1linha100:	string "          -    -    -####-    "
tela1linha101:	string "          -     ####     -    "
tela1linha102:	string "          -    -    -    -    "
tela1linha103:	string "          -              -    "
tela1linha104:	string "          -    -    -    -    "
tela1linha105:	string "          -              -    "
tela1linha106:	string "          -    -    -    -    "
tela1linha107:	string "          -              -    "
tela1linha108:	string "          -    -    -    -    "
tela1linha109:	string "          -              -    "
tela1linha110:	string "          -    -    -    -    "
tela1linha111:	string "          -#### ####     -    "
tela1linha112:	string "          -    -    -    -    "
tela1linha113:	string "          -              -    "
tela1linha114:	string "          -    -    -    -    "
tela1linha115:	string "          -              -    "
tela1linha116:	string "          -    -    -    -    "
tela1linha117:	string "          -              -    "
tela1linha118:	string "          -    -    -    -    "
tela1linha119:	string "          -              -    "

tela1linha120:	string "          -    -    -    -    "
tela1linha121:	string "          -####      ####-    "
tela1linha122:	string "          -    -    -    -    "
tela1linha123:	string "          -              -    "
tela1linha124:	string "          -    -    -    -    "
tela1linha125:	string "          -              -    "
tela1linha126:	string "          -    -    -    -    "
tela1linha127:	string "          -              -    "
tela1linha128:	string "          -    -    -    -    "
tela1linha129:	string "          -              -    "
tela1linha130:	string "          -    -    -    -    "
tela1linha131:	string "          -     #### ####-    "
tela1linha132:	string "          -    -    -    -    "
tela1linha133:	string "          -              -    "
tela1linha134:	string "          -    -    -    -    "
tela1linha135:	string "          -              -    "
tela1linha136:	string "          -    -    -    -    "
tela1linha137:	string "          -              -    "
tela1linha138:	string "          -    -    -    -    "
tela1linha139:	string "          -              -    "
tela1linha140:	string "          -    -    -    -    "
tela1linha141:	string "          -#### ####     -    "
tela1linha142:	string "          -    -    -    -    "
tela1linha143:	string "          -              -    "
tela1linha144:	string "          -    -    -    -    "
tela1linha145:	string "          -              -    "
tela1linha146:	string "          -    -    -    -    "
tela1linha147:	string "          -              -    "
tela1linha148:	string "          -    -    -    -    "
tela1linha149:	string "          -              -    "
tela1linha150:	string "          -    -    -    -    "
tela1linha151:	string "          -     #### ####-    "
tela1linha152:	string "          -    -    -    -    "
tela1linha153:	string "          -              -    "
tela1linha154:	string "          -    -    -    -    "
tela1linha155:	string "          -              -    "
tela1linha156:	string "          -    -    -    -    "
tela1linha157:	string "          -              -    "
tela1linha158:	string "          -    -    -    -    "
tela1linha159:	string "          -              -    "

tela1linha160:	string "          -    -    -    -    "
tela1linha161:	string "          -     ####     -    "
tela1linha162:	string "          -####-    -    -    "
tela1linha163:	string "          -              -    "
tela1linha164:	string "          -    -    -    -    "
tela1linha165:	string "          -              -    "
tela1linha166:	string "          -    -    -    -    "
tela1linha167:	string "          -              -    "
tela1linha168:	string "          -    -    -    -    "
tela1linha169:	string "          -              -    "
tela1linha170:	string "          -    -    -    -    "
tela1linha171:	string "          -          ####-    "
tela1linha172:	string "          -####-    -    -    "
tela1linha173:	string "          -              -    "
tela1linha174:	string "          -    -    -    -    "
tela1linha175:	string "          -              -    "
tela1linha176:	string "          -    -    -    -    "
tela1linha177:	string "          -              -    "
tela1linha178:	string "          -    -    -    -    "
tela1linha179:	string "          -              -    "
tela1linha180:	string "          -    -    -    -    "
tela1linha181:	string "          -     ####     -    "
tela1linha182:	string "          -    -    -    -    "
tela1linha183:	string "          -              -    "
tela1linha184:	string "          -    -    -    -    "
tela1linha185:	string "          -              -    "
tela1linha186:	string "          -    -    -    -    "
tela1linha187:	string "          -              -    "
tela1linha188:	string "          -    -    -    -    "
tela1linha189:	string "          -              -    "
tela1linha190:	string "          -    -    -    -    "
tela1linha191:	string "          -####          -    "
tela1linha192:	string "          -    -    -####-    "
tela1linha193:	string "          -              -    "
tela1linha194:	string "          -    -    -    -    "
tela1linha195:	string "          -              -    "
tela1linha196:	string "          -    -    -    -    "
tela1linha197:	string "          -              -    "
tela1linha198:	string "          -    -    -    -    "
tela1linha199:	string "          -              -    "

tela1linha200:	string "          -    -    -    -    "
tela1linha201:	string "          -              -    "
tela1linha202:	string "          -    -    -    -    "
tela1linha203:	string "          -              -    "
tela1linha204:	string "          -    -    -    -    "
tela1linha205:	string "          -              -    "
tela1linha206:	string "          -    -    -    -    "
tela1linha207:	string "          -              -    "
tela1linha208:	string "          -    -    -    -    "
tela1linha209:	string "          -              -    "
tela1linha210:	string "          -    -    -    -    "
tela1linha211:	string "          -              -    "
tela1linha212:	string "          -    -    -    -    "
tela1linha213:	string "          -              -    "
tela1linha214:	string "          -    -    -    -    "
tela1linha215:	string "          -              -    "
tela1linha216:	string "          -    -    -    -    "
tela1linha217:	string "          -              -    "
tela1linha218:	string "          -    -    -    -    "
tela1linha219:	string "          -              -    "
tela1linha220:	string "          -    -    -    -    "
tela1linha221:	string "          -              -    "
tela1linha222:	string "          -    -    -    -    "
tela1linha223:	string "          -              -    "
tela1linha224:	string "          -    -    -    -    "
tela1linha225:	string "          -              -    "
tela1linha226:	string "          -    -    -    -    "
tela1linha227:	string "          -              -    "
tela1linha228:	string "          -    -    -    -    "
tela1linha229:	string "          -              -    "
tela1linha230:	string "          -    -    -    -    "
tela1linha231:	string "          -     ####     -    "
tela1linha232:	string "          -    -    -    -    "
tela1linha233:	string "          -              -    "
tela1linha234:	string "          -####-    -    -    "
tela1linha235:	string "          -              -    "
tela1linha236:	string "          -    -    -    -    "
tela1linha237:	string "          -              -    "
tela1linha238:	string "          -    -    -    -    "
tela1linha239:	string "          -              -    "

carlinha0:	string " +@ - @| "
carlinha1:	string "[<[#o]>>]"
carlinha2:	string "[<[#o]>>]"
carlinha3:	string " +@ - @| "

car2linha0:	string " (0 - 0> "
car2linha1:	string "|#(|o)##|"
car2linha2:	string "|#(|o)##|"
car2linha3:	string " (0 - 0> "

car3linha0:	string " +0 - 0| "
car3linha1:	string "<@#|o]|@>"
car3linha2:	string "<@#|o]|@>"
car3linha3:	string " +0 - 0| "


explosion0: string "+  0   >"
explosion1: string "  0   -  |"
explosion2:	string "|#(x8)#   #  |"
explosion3:	string "|#(x8) # # |"
explosion4: string "   -   0"
explosion5: string "0  +  |  "

explosion6: string "+     0       >"
explosion7: string "    0      -      |"
explosion8:	string "  #  x 8   )    #"
explosion9:	string "|    (      #       |"
explosion10: string "  # (  8    #   |"
explosion11: string "          "
explosion12: string "|   x  )     # "
explosion13: string "   -        0"

explosionclear0:  string "               "
explosionclear1:  string "                   "
explosionclear2:  string "                 "
explosionclear3:  string "                     "
explosionclear4:  string "                 "
explosionclear5:  string "         "
explosionclear6:  string "               "
explosionclear7:  string "             "
; Vitoria C. dos S. Camelo
; Tentando passar em Arquitetura I
; No meio, acho que fiquei feliz

; inicia stack do programa com 128 B
pilha	segment stack
	db	128 dup(?)	
pilha	ends


; secao dos dados
dados	segment
boas_vindas db 'Seja bem vindo a calculadora de notas!#'
msg_nota1   db 'Digite a primeira nota (000 a 100): #'
nota	    db  0			; nota para imprimir
nota1	    db  0			; dw 0
nota2	    db	0
nota3	    db	0
qtde_notas  db  3
media	    db  0
;erro	    db  0
dezena	    db  0
unidade	    db  0
resto 	    db  0
minuendo    db  125
subtraendo  db  0
resto_media db  0			; resto da media/2
media_parcial db 0			; guarda media+media/2
msg_nota2   db 'Digite a segunda nota (000 a 100): #'
msg_nota3   db 'Digite a terceira nota (000 a 100): #'
msg_media   db 'Sua media e #'
msg_reprovou db 'Sinto muito, voce reprovou #'
msg_final   db 'Nota que voce precisa tirar na prova final: #'
carac	    db ','

dados ends

; ------ aqui comeca o codigo --------
codigo	segment
	assume	ss:pilha, cs:codigo, ds:dados, es:dados

; padrao dos codigos
inicio	proc	far
	push	ds			; guarda ds na pilha
	xor	ax,ax
	push	ax			; 0 na pilha
	mov	ax,dados
	mov	ds,ax			; ds guarda $segmento_de_dados
	mov	es,ax			; ex = ds
	
	; ---- inicio factual ----
	call	limpa_tela		; limpa tela
	mov	dx,0
	call	posiciona_cursor	; move cursor para inicio
	lea	bx, boas_vindas 	; primeira mensagem

PrintBoasVindas:	
	mov	al,[bx]
	cmp	al,'#'
	jz      PrepararNota1 
	call	imprimir;  	
	inc	bx
	jmp	PrintBoasVindas

; ----------------- Nota 1 -----------------
PrepararNota1:		
	lea     di, msg_nota1
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call    imprimir
	jmp     PedirNota1

PedirNota1: 
	mov     al,[di]
	cmp     al,'#'
	jz      ReceberNota1 		;ReceberNota1 | fim
	call    imprimir
	inc     di
	jmp     PedirNota1

ReceberNota1:
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call	imprimir
	call	teclado
	mov	nota, al		; receber digito 1
	; - centena
	sub	al, 30h
	mov	bl, 100
	mul	bl
	mov	nota1, al
	lea	di, nota
	mov	al, [di]
	call	imprimir		; escrever digito 1
	; - dezena
	call	teclado
	mov	nota, al		; receber digito 2
	sub	al, 30h
	mov	bl, 10
	mul	bl
	mov	bl, nota1
	add	al, bl
	mov	nota1, al
	lea	di, nota
	mov	al, [di]
	call	imprimir		; escrever digito 2
	; - unidade
	call	teclado
	mov	nota, al		; receber digito 3
	sub 	al, 30h
	mov	bl, nota1
	add	al, bl
	mov	nota1, al
	lea	di, nota
	mov	al, [di]
	call	imprimir		; escrever digito 3
	jmp	PrepararNota2

; ----------------- Nota 2 -----------------
PrepararNota2:
	lea     di, msg_nota2
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call    imprimir
	jmp     PedirNota2

PedirNota2: 
	mov     al,[di]
	cmp     al,'#'
	jz      ReceberNota2 		;ReceberNota1 | fim
	call    imprimir
	inc     di
	jmp     PedirNota2

ReceberNota2:
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call	imprimir
	call	teclado
	mov	nota, al		; receber digito 1
	; - centena
	sub	al, 30h
	mov	bl, 100
	mul	bl
	mov	nota2, al
	lea	di, nota
	mov	al, [di]
	call	imprimir		; escrever digito 1
	; - dezena
	call	teclado
	mov	nota, al		; receber digito 2
	sub	al, 30h
	mov	bl, 10
	mul	bl
	mov	bl, nota2
	add	al, bl
	mov	nota2, al
	lea	di, nota
	mov	al, [di]
	call	imprimir		; escrever digito 2
	; - unidade
	call	teclado
	mov	nota, al		; receber digito 3
	sub 	al, 30h
	mov	bl, nota2
	add	al, bl
	mov	nota2, al
	lea	di, nota
	mov	al, [di]
	call	imprimir		; escrever digito 3
	jmp	PrepararNota3

; ----------------- Nota 3 -----------------
PrepararNota3:
	lea     di, msg_nota3
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call    imprimir
	jmp     PedirNota3

PedirNota3: 
	mov     al,[di]
	cmp     al,'#'
	jz      ReceberNota3 		;ReceberNota1 | fim
	call    imprimir
	inc     di
	jmp     PedirNota3

ReceberNota3:
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call	imprimir
	call	teclado
	mov	nota, al		; receber digito 1
	; - centena
	sub	al, 30h
	mov	bl, 100
	mul	bl
	mov	nota3, al
	lea	di, nota
	mov	al, [di]
	call	imprimir		; escrever digito 1
	; - dezena
	call	teclado
	mov	nota, al		; receber digito 2
	sub	al, 30h
	mov	bl, 10
	mul	bl
	mov	bl, nota3
	add	al, bl
	mov	nota3, al
	lea	di, nota
	mov	al, [di]
	call	imprimir		; escrever digito 2
	; - unidade
	call	teclado
	mov	nota, al		; receber digito 3
	sub 	al, 30h
	mov	bl, nota3
	add	al, bl
	mov	nota3, al
	lea	di, nota
	mov	al, [di]
	call	imprimir		; escrever digito 3


; ----------------- Media -----------------
	; - nota1
	xor	al, al
	xor	ah, ah
	xor	bl, bl
	xor	bh, bh
	mov	al, nota1		; gera ascii correto
	mov 	bl, 3
	mov	ah, 0

Nota1MaiorQue3:
	cmp	al, bl
	jl	ProcessarNota2
	sub	al, bl
	add	ah, 1
	jmp 	Nota1MaiorQue3

ProcessarNota2:
	mov	resto, al		; ascii correto ah, al
	mov	al, nota2
	jmp	Nota2Maiorque3

Nota2MaiorQue3:
	cmp	al, bl
	jl	ProcessarNota3
	sub	al, bl
	add	ah, 1
	jmp 	Nota2MaiorQue3

ProcessarNota3:
	mov	bh, resto		; ascii correto ah, al, bh
	add	bh, al
	mov	resto, bh
	mov	al, nota3
	jmp	Nota3Maiorque3

Nota3Maiorque3:
	cmp	al, bl
	jl	ProcessarResto
	sub	al, bl
	add	ah, 1
	jmp 	Nota3MaiorQue3

ProcessarResto:
	mov	bh, resto
	add	bh, al
	mov	al, bh
	jmp	RestoMaiorQue3

RestoMaiorQue3:
	cmp	al, bl
	jl	ProcessarResultado
	sub	al, bl
	add	ah, 1
	jmp 	RestoMaiorQue3

; ----------------- Imprimir media -----------------
ProcessarResultado:
	mov	resto, al	; ascii correto ah, al
	mov	al, ah 		; eh menor ou igual 100
	mov	bl, 100
	cmp	al, bl
	je	Media100	
	mov 	bl, 10
	mov	ah, 0
	mov	bh, 0		; usar para menor que 10
	jmp 	ResultadoMaiorQue10

Media100:
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call    imprimir
	mov	al, 31h
	call	imprimir
	mov	al, 30h
	call	imprimir
	mov	al, 30h
	call	imprimir
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call    imprimir
	;---- mensagem "Parabens" de forma bruta
	mov	al, 50h
	call	imprimir
	mov	al, 61h
	call	imprimir
	mov	al, 72h
	call	imprimir
	mov	al, 61h
	call	imprimir
	mov	al, 62h
	call	imprimir
	mov	al, 65h
	call	imprimir
	mov	al, 6eh
	call	imprimir
	mov	al, 73h
	call	imprimir
	;----
	jmp	fim

ResultadoMaiorQue10:
	cmp	al, bl
	jl	ImprimirMedia
	sub	al, bl		
	add	ah, 1			; ate 10
	jmp 	ResultadoMaiorQue10

ImprimirMedia:
	; ascii ah, al correto
	mov	unidade, al		; no maximo 9
	mov	dezena, ah
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call	imprimir
	; ---- msg Media=
	mov	al, 4dh
	call	imprimir
	mov	al, 65h
	call	imprimir
	mov	al, 64h
	call	imprimir	
	mov	al, 69h
	call	imprimir
	mov	al, 61h
	call	imprimir
	mov	al, 3dh
	call	imprimir
	; ---- impressao 
	mov	al, dezena
	add	al, 30h
	call	imprimir		; imprimir dezena
	mov	al, unidade
	add	al, 30h
	call	imprimir		; imprimir unidade
	mov	al, 2eh
	call	imprimir
	; ---- processa resto
	mov	al, resto		; so pode ser 0, 1 ou 2
	mov	bl, 0
	cmp	al, bl
	je	Resto0
	mov	bl, 1
	cmp	al, bl
	je	Resto1
	mov	bl, 2
	cmp	al, bl
	je	Resto2
	
Resto0:
	mov	resto, 0
	mov	al, 30h
	call	imprimir
	jmp	Decisao
	
Resto1:
	mov	resto, 3
	mov	al, 33h
	call	imprimir
	jmp	Decisao

Resto2:
	mov 	resto, 7
	mov	al, 37h
	call	imprimir
;	jmp	fim

Decisao:
	mov	al, dezena
	cmp	al, 4
	jl	PreparaReprovou
	cmp	al, 7
	jl 	PreparaMsgFinal
	jmp	fim	

PreparaReprovou:
	lea     di, msg_reprovou
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call    imprimir
	jmp     Reprovou

Reprovou:
	mov     al,[di]
	cmp     al,'#'
	jz      FimDistante		
	call    imprimir
	inc     di
	jmp     Reprovou

PreparaMsgFinal:
	lea     di, msg_final
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call    imprimir
	jmp     MsgFinal

MsgFinal:
	mov     al,[di]
	cmp     al,'#'
	jz      FimDistante; NotaFinal		; FimDistante  		
	call    imprimir
	inc     di
	jmp     MsgFinal

FimDistante:
	ret				; relative jump out of range

NotaFinal:
	; final = 125 - media+(media/2) | nao considera resto agora
	; condicional para resto 1 e 2
	; - recompondo media sem resto
	mov	al, dezena
	mov	bl, 10
	mul	bl
	mov	bl, unidade
	add	al, bl
	mov	media, al
	mov	bl, 2
	mov	ah, 0
	
MediaSobre2:
	cmp	al, bl
	jl	ProcessarFinal
	sub	al, bl		
	add	ah, 1			; ate 10
	jmp 	MediaSobre2

ProcessarFinal:
	; - calculo do resto de media+media/2
	mov	bl, 50			
	mul	bl			; 0 ou 5 no resto
	mov	resto_media, al
	mov	al, resto
	mov	bh, resto
	mov	bl, 5
	mul	bl	
	mov	resto, al		; metades 0, 15, 35
	mov	al, bh
	mov	bl, 10
	mul	bl			; 0 - 0, 3 - 30, 7 - 70
	mov	bl, resto
	add	al, bl			; somar com a metade
	mov	resto, al
	mov	bl, resto_media
	add	al, bl
	mov	resto, al		; todos os restos
	; 125 - media+media/2)
	mov	al, ah
	mov	bl, media
	add	al, bl
	mov	minuendo, al
	mov	al, subtraendo
	mov	bl, minuendo
	sub	al, bl			; 125 - media+media/2
	mov	subtraendo, al		; ainda precisa tirar restos
	; - escolha dos metodos para restos
	mov	al, resto
	;cmp	al, 0
	;jz 	SubtracaoComum
	cmp	al, 99
	jg	SubtracaoCom2
	; - subtracao com 1
	mov	al, subtraendo
	mov	bl, 1
	sub	al, bl
	mov	subtraendo, al		; antes do ponto
	mov	al, 100
	mov	bl, resto
	sub	al, bl
	mov	resto, al		; para imprimir depois do ponto
	jmp	DezUniFinal
	; - hora de processar saida
	
SubtracaoCom2:				; para casos como 155
	mov	al, subtraendo
	mov	bl, 2			; pegar emprestado
	sub	al, bl
	mov	subtraendo, al		; antes do ponto
	mov	al, 200			
	mov	bl, resto
	sub	al, bl
	mov	resto, al		; depois do ponto

DezUniFinal:				; dezena e unidade da final
	mov 	bl, 10
	mov	ah, 0
	mov	bh, 0		; usar para menor que 10
	;jmp 	FinalMaiorQue10	; parecido com print(media)
	
FinalMaiorQue10:
	cmp	al, bl
	jl	ImprimirFinal
	sub	al, bl		
	add	ah, 1			; ate 10
	jmp 	ResultadoMaiorQue10

ImprimirFinal:
	mov	unidade, al		; no maximo 9
	mov	dezena, ah
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call	imprimir
	; ---- impressao 
	mov	al, dezena
	add	al, 30h
	call	imprimir		; imprimir dezena
	mov	al, unidade
	add	al, 30h
	call	imprimir		; imprimir unidade
	mov	al, 2eh
	call	imprimir
	; ---- processa resto
	mov	al, resto
	mov 	bl, 10
	mov	ah, 0
	mov	bh, 0		; usar para menor que 10
	jmp 	RestoMaiorQue10	; parecido com print(media)

RestoMaiorQue10:
	cmp	al, bl
	jl	ImprimirResto
	sub	al, bl		
	add	ah, 1			; ate 10
	jmp 	RestoMaiorQue10

ImprimirResto:
	mov	unidade, al		; no maximo 9
	mov	dezena, ah
	mov     al,0dh			; inicio da linha
	call	imprimir;  	
        mov     al,0ah			; proxima linha
	call	imprimir
	; ---- impressao 
	mov	al, dezena
	add	al, 30h
	call	imprimir		; imprimir dezena
	mov	al, unidade
	add	al, 30h
	call	imprimir		; imprimir unidade

fim:	ret
inicio	endp

imprimir proc	near
	push	si
	push	bx
	push	di
	push	cx
	mov	bx,0
	mov	ah,14
	int	10h
	pop	cx
	pop	di
	pop	bx
	pop	si
	ret
imprimir endp

limpa_tela proc near
      push AX
      push BX
      push CX
      push DX
      xor al,al
      xor cx,cx
      mov dh,24
      mov dl,79
      mov bh,07h
      mov ah,06
      int 10h
      pop DX
      pop CX
      pop BX
      pop AX
      ret
limpa_tela endp

; dl,dh posiciona o cursor
posiciona_cursor proc near
    push AX
    push BX
    push cx
    xor BX,BX
    mov AH,2
    int 10h
    pop cx
    pop bx
    pop ax
    ret
posiciona_cursor endp

teclado proc near
    ; guardar tudo para nao perder
    push    di
    push    bx
    push    si
    push    cx

    ;prepara os parâmetros pra chamada correta da interrupção
    mov     ah,0		; selecionar entrada (?)
    int     16h			; al - caractere lido

    ; restaura registradores
    pop     cx
    pop     si
    pop     bx
    pop     di
    ret
teclado endp

codigo	ends
	end	inicio	

; -------- rascunho -------
;SubtracaoComum:
	; tratar mensagem antes do ponto
;	mov 	bl, 10
;	mov	ah, 0
;	mov	bh, 0		; usar para menor que 10
;	jmp 	FinalMaiorQue10	; parecido com print(media)

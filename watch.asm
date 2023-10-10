.model small
.stack

.data
    hours DB 1    ; Number of iterations for outer loop
    minutes DB 2    ; Number of iterations for middle loop
    seconds DB 9  ; Number of iterations for inner loop
    colon Db ":"
    msg db ?
    temp db ?
    req db 10,13, "Please Enter the number in 2 digits$"
    hr DB 10,13, "Enter the number of hours: $"
    min DB 10,13, "Enter the number of minutes: $"
    sec DB 10,13, "Enter the number of seconds: $"
    over db 10,13, "Time is UP !!! $"

.code

;procedure to clear the screen
clear proc
    mov ah,00   ; sets Set Video Mode function  
    mov al,02   ; sets to 80x25 color text mode
    int 10h     ; the BIOS will clear the screen and set the video mode to color text mode.
RET
clear ENDP

;procedure to print the numbers    
print proc 
    aam            ; -> AH is quotient (1) = AL / 10 , AL is remainder (2) = AL % 10
    add ax,'00'    ;Convertinh AL and AH value to ascii
    push ax
    
    mov dl, ah              ; printing the tens
    mov ah, 02h         
    int 21h
    
    pop dx
    
    mov ah, 02h             ;printing the units
    int 21h
RET
print ENDP

;procedure to move to new line
newline proc
  mov dx,13                 ;move to the beginning of the current line
  mov ah,02
  int 21h  
  mov dx,10                 ;  move down to the next line
  mov ah,02
  int 21h
RET
newline endp

;Procedure for inserting a delay of 1 second
delay proc
    MOV CX, 0FH             ;specify the number of microseconds to delay
    MOV DX, 4240H           ;specify the address of a table that contains the BIOS delay function.
    MOV AH, 86H             ;specify the function number of the BIOS delay function
    INT 15H
RET
delay endp

;procedure for seperating 
seprator proc
    mov ah,02
    mov dl,colon
    int 21h
RET
seprator endp

;procedure for inerting the space in output screen
space proc
spc_loop:
   mov ah,02
   mov dl,' '  
   int 21h
   dec msg
   jnz spc_loop
RET
space endp

;procedure for inputtig 2-digit decimal values
read proc 
    mov ah,01     ;inputting 1st digit
    int 21h
    sub al,'0'
    mov dl,10
    mul dl
    
    mov temp,al  ;if any other register s used here like bl,dl,cl then it will stop execution of delay
    
    mov ah,01     ;inputting second digit
    int 21h
    sub al,'0'
    
    add temp,al
    mov al,temp
RET
read endp

disp macro xx
    mov ah,09
    lea dx,xx
    int 21h
endm

.startup
disp req

call newline

disp hr
call read      ;reading hours
mov hours,al   ;storing the decimal value in variables

call newline

disp min
call read       ;reading minutes
mov minutes,al  ;storing the decimal value in variables

call newline

disp sec
call read        ;reading seconds
mov seconds,al   ;storing the decimal value in variables

watch_loop:
    call clear     ;clearing the previous output 
    
    call newline   ;Positioning the output
    call newline
    call newline
    
    mov msg,35   ;if we declared msg earlier it wont be reinitiated
    call space
    
    mov al,hours  ;printig the hours
    call print
    
    call seprator
    
    mov al,minutes  ;printig the seconds
    call print
    
    call seprator
    
    mov al,seconds  ;printig the seconds
    call print
    
    call delay      ;calling the delay
    
    dec seconds
    jge watch_loop  ;jump if greater than or equal to zero(equal to because clock shows 00 instead of 60)
    
    mov seconds,59
    
    dec minutes
    jge watch_loop
    
    mov minutes,59
    
    dec hours
    jge watch_loop

disp over
    
.exit
end
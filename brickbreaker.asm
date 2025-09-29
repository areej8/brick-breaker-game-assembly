INCLUDE Irvine32.inc
include macros.inc
includelib winmm.lib
PlaySound PROTO, pszSound:PTR BYTE, hmod:DWORD, fdwSound:DWORD 


MAX_NAME_LENGTH  equ 6
MAX_NAMES        equ 11
MAX_LEVELS equ 10
MAX_LEVEL_LENGTH equ 3

.data
mainTrack byte "brickbreakerOST.wav", 0

totalTime DWORD 1440        
timeString BYTE "Time Left: 00:00", 0

    namesFile db "names.txt", 0
    levelsFile db "levels.txt", 0
    scoresFile db "scores.txt", 0
    namesArray byte 256 dup(0)
    scoresArray dword 128 dup(0)
    levelsArray byte 256 dup(0)
    buffer byte 256 dup(0)
    nameCount DWORD 0
    temPCount dword 0
    scoreCount DWORD 10
    
    levelCount DWORD 3
    
    newline db 0Dh, 0Ah, 0
    fileHandle DWORD ?
    username byte "aree", 0
    levelAt byte 1
    score dw 0
    scoreStr db 8 dup(0)
    levelStr db 2 dup(0)

    msg1 byte "WELCOME TO ICE BREAKER!!", 0
    msg2 byte "Enter your name: ", 0
    spacer byte "===============================================", 0
    msg3 byte "====MAIN MENU====", 0
    menuPlay byte " Play (P) ", 0

    menuInstruction byte " Instruction (I) ", 0
    instStatement1 byte "1) In the brick breaker game, the player moves a paddle from side to side to hit a BALL.", 0
    instStatement2 byte "2) The game objective is to eliminate all of the BRICKS at the top of the screen by hitting them with the BALL.", 0
    instStatement3 byte "3) But if the ball hit the bottom ENCLOSURE, the player loses and the game ends!", 0
    instStatement4 byte "4) To win the game, all the BRICKS must be eliminated.", 0 
    instStatement5 byte "5) The game is split into many levels, which must be completed in sequence." , 0
    instStatement6 byte "6) There will be a time limit of 4 minutes and the remaining time will be shown with the counter.", 0
    instStatement7 byte "7) The purpose of this game is to complete all the levels without losing all lives.", 0
    instStatement8 byte "8) The player will have a maximum of 3 lives. ", 0

    menuScoreBoard byte " ScoreBoard (S) ", 0
    menuExit byte " Exit (E) ", 0
    menuChoice byte "Choose an option: ", 0
    invalidChoice byte "Invalid choice! Please try again.", 0

    scrLine1 db " ____  ____  ____  ____  _____ ____  ____  ____  ____  ____ ", 0
    scrLine2 db "/ ___\/   _\/  _ \/  __\/  __//  _ \/  _ \/  _ \/  __\/  _ \", 0
    scrLine3 db "|    \|  /  | / \||  \/||  \  | | //| / \|| / \||  \/|| | \|", 0
    scrLine4 db "\___ ||  \_ | \_/||    /|  /_ | |_\\| \_/|| |-|||    /| |_/|", 0
    scrLine5 db "\____/\____/\____/\_/\_\\____\\____/\____/\_/ \|\_/\_\\____/", 0

    bLine1 BYTE "  ____  _____  _____ _____ _  __  ____  _____  ______          _  ________ _____  ", 0
    bLine2 BYTE " |  _ \|  __ \|_   _/ ____| |/ / |  _ \|  __ \|  ____|   /\   | |/ /  ____|  __ \ ", 0
    bLine3 BYTE " | |_) | |__) | | || |    | ' /  | |_) | |__) | |__     /  \  | ' /| |__  | |__) |", 0
    bLine4 BYTE " |  _ <|  _  /  | || |    |  <   |  _ <|  _  /|  __|   / /\ \ |  < |  __| |  _  / ", 0
    bLine5 BYTE " | |_) | | \ \ _| || |____| . \  | |_) | | \ \| |____ / ____ \| . \| |____| | \ \ ", 0
    bLine6 BYTE " |____/|_|  \_\_____\_____|_|\_\ |____/|_|  \_\______/_/    \_\_|\_\______|_|  \_\ ", 0

    gameOver1 BYTE " GGG    A   M   M EEEE       OOO  V   V EEEE RRRR", 0
    gameOver2 BYTE "G      A A  MM MM E         O   O V   V E    R   R", 0
    gameOver3 BYTE "G  GG AAAAA M M M EEEE      O   O V   V EEEE RRRR", 0
    gameOver4 BYTE "G   G A   A M   M E         O   O  V V  E    R  R", 0
    gameOver5 BYTE " GGG  A   A M   M EEEE       OOO    V   EEEE R   R", 0


    level2_1 BYTE " L     EEEE V   V EEEE L         222", 0
    level2_2 BYTE " L     E    V   V E    L        2   2", 0
    level2_3 BYTE " L     EEEE V   V EEEE L          22 ", 0
    level2_4 BYTE " L     E     V V  E    L         2   ", 0
    level2_5 BYTE " LLLL  EEEE   V   EEEE LLLL     22222", 0


    level3_1 BYTE " L     EEEE V   V EEEE L         333 ", 0
    level3_2 BYTE " L     E    V   V E    L        3   3", 0
    level3_3 BYTE " L     EEEE V   V EEEE L          33 ", 0
    level3_4 BYTE " L     E     V V  E    L        3   3", 0
    level3_5 BYTE " LLLL  EEEE   V   EEEE LLLL      333 ", 0


    youWin1 BYTE " Y   Y  OOO  U   U       W   W III N   N !", 0
    youWin2 BYTE "  Y Y  O   O U   U       W   W  I  NN  N !", 0
    youWin3 BYTE "   Y   O   O U   U       W W W  I  N N N !", 0
    youWin4 BYTE "   Y   O   O U   U       WW WW  I  N  NN !", 0
    youWin5 BYTE "   Y    OOO   UUU        W   W III N   N !", 0

    Hline BYTE " ", 0
    Vline BYTE "|", 0
    Space BYTE " ", 0
    SpaceP BYTE "  ", 0
    paddleX byte 35
    paddleY byte 23
    paddleWidth byte 10
    paddleHeight byte 1

    ballChar byte "O"

    bricksX BYTE 2
    bricksY BYTE 1
    ballX BYTE ?
    ballY BYTE ?

    ballDirX byte -1
    ballDirY byte -1

    bricksWidth BYTE 7
    brickSpacing BYTE 1
    rowSpacing BYTE 1
    brickRows BYTE 4
    brickCols BYTE 13
    brickStartX byte 0
    brickStartY byte 0
    tempX BYTE ?
    tempY BYTE ?

    row word ?
    col word ? 
    remainingBricks byte 52
    bricksStatusRow1 word 13 dup(?)
    bricksStatusRow2 word 13 dup(?)
    bricksStatusRow3 word 13 dup(?)
    bricksStatusRow4 word 13 dup(?)

lives byte 3
.code
main PROC
   INVOKE PlaySound, offset mainTrack, NULL, 1
    call Clrscr
    
    mov eax, 6
    call SetTextColor
    mov dh, 10
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine1
    call WriteString

    mov dh, 11
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine2
    call WriteString

    mov dh, 12
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine3
    call WriteString

    mov dh, 13
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine4
    call WriteString

    mov dh, 14
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine5
    call WriteString

    mov dh, 15
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine6
    call WriteString

    mov eax, 3000
    call Delay

    call Clrscr

    mov eax, 6
    call SetTextColor
    mov dh, 0
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine1
    call WriteString

    mov dh, 1
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine2
    call WriteString

    mov dh, 2
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine3
    call WriteString

    mov dh, 3
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine4
    call WriteString

    mov dh, 4
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine5
    call WriteString

    mov dh, 5
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine6
    call WriteString

    mov eax, 3
    call SetTextColor
    mov dh, 10
    mov dl, 50
    call Gotoxy
    mov edx, OFFSET msg1
    call WriteString

    mov eax, 6
    call SetTextColor
    mov dh, 13
    mov dl, 38
    call Gotoxy
    mov edx, OFFSET msg2
    call WriteString

    lea edx, userName
    mov ecx, 10
    call ReadString


    call Crlf
    call Clrscr

menuLoop:
    call DrawMenu
    call GetUserChoice
    call play
main ENDP

DrawMenu PROC
    call Clrscr

    mov eax, 6
    call SetTextColor
    mov dh, 0
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine1
    call WriteString

    mov dh, 1
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine2
    call WriteString

    mov dh, 2
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine3
    call WriteString

    mov dh, 3
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine4
    call WriteString

    mov dh, 4
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine5
    call WriteString

    mov dh, 5
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET bLine6
    call WriteString

    mov eax, 11
    call SetTextColor
    mov dh, 7
    mov dl, 38
    call Gotoxy
    mov edx, OFFSET spacer
    call WriteString

    mov eax, 2
    call SetTextColor
    mov dh, 8
    mov dl, 53
    call Gotoxy
    mov edx, OFFSET msg3
    call WriteString

    mov eax, 3
    call SetTextColor
    mov dh, 10
    mov dl, 38
    call Gotoxy
    mov edx, OFFSET menuPlay
    call WriteString

    mov eax, 5
    call SetTextColor
    mov dh, 12
    mov dl, 38
    call Gotoxy
    mov edx, OFFSET menuInstruction
    call WriteString

    mov eax, 6
    call SetTextColor
    mov dh, 14
    mov dl, 38
    call Gotoxy
    mov edx, OFFSET menuScoreBoard
    call WriteString

    mov eax, 14
    call SetTextColor
    mov dh, 16
    mov dl, 38
    call Gotoxy
    mov edx, OFFSET menuExit
    call WriteString

    mov eax, 11
    call SetTextColor
    mov dh, 17
    mov dl, 38
    call Gotoxy
    mov edx, OFFSET spacer
    call WriteString

    ret
DrawMenu ENDP

GetUserChoice PROC
    mov dh, 18
    mov dl, 38
    call Gotoxy
    mov edx, OFFSET menuChoice
    call WriteString

    call ReadChar
    
    cmp al, 'P'
    je PlayGame
    cmp al, 'I'
    je InstructionGame
    cmp al, 'S'
    je ScoreBoardGame
    cmp al, 'E'
    je ExitProgram

    mov dh, 17
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET invalidChoice
    call WriteString
    ret

    PlayGame:
    call Play
    call GetUserChoice

    InstructionGame:
    call Instruction
    call GetUserChoice

    ScoreBoardGame:
    call ScoreBoard
    call GetUserChoice

GetUserChoice  ENDP

uWin PROC

    call Clrscr   
  
    mov eax, white + (black * 16)  
    call SetTextColor

    mov dh, 8
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET youWin1
    call WriteString
    call Crlf

    mov dh, 9
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET youWin2
    call WriteString
    call Crlf

    mov dh, 10
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET youWin3
    call WriteString
    call Crlf

    mov dh, 11
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET youWin4
    call WriteString
    call Crlf

    mov dh, 12
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET youWin5
    
    call waitmsg
    call createAndWriteFile
    exit
uWin ENDP

drawBricks PROC
    push ax
    push bx
    push cx
    push dx

    mov dh, bricksY          ; Initial row position (Y-coordinate)
    mov cl, brickRows        ; Total number of rows

rowLoop:
    push cx                  ; Save row counter
    mov dl, bricksX          ; Starting X-coordinate for bricks

    mov bl, brickCols        ; Total bricks in one row

    ; Set text color based on row
    mov al, dh
    cmp al, 0
    je SetBlue
    cmp al, 2
    je SetRed
    cmp al, 4
    je SetCyan
    cmp al, 6
    je SetYellow
    jmp DefaultColor

SetBlue:
    mov eax, black + (blue * 16)  ; Black background, Blue foreground
    call SetTextColor
    jmp DrawRow

SetRed:
    mov eax, black + (red * 16)   ; Black background, Red foreground
    call SetTextColor
    jmp DrawRow

SetCyan:
    mov eax, black + (cyan * 16)  ; Black background, Cyan foreground
    call SetTextColor
    jmp DrawRow

SetYellow:
    mov eax, black + (green * 16) ; Black background, Yellow foreground
    call SetTextColor
    jmp DrawRow

DefaultColor:
    mov eax, black + (white * 16) ; Black background, White foreground
    call SetTextColor

DrawRow:
columnLoop:
    ; Draw a single brick
    push dx
    mov tempX, dl            ; Store X-coordinate
    mov tempY, dh            ; Store Y-coordinate

    call Gotoxy              ; Move cursor to current position
    mwrite "       ",0

    pop dx
    add dl, bricksWidth      ; Move to next brick's X-coordinate
    add dl, brickSpacing     ; Add spacing between bricks
    dec bl                   ; Decrement brick counter
    jnz columnLoop           ; Repeat for the next brick in the row

    pop cx
    add dh, 1                ; Move to the next row
    add dh, rowSpacing       ; Add spacing between rows
    dec cl                   ; Decrement row counter
    jnz rowLoop              ; Repeat for the next row

    ; Reset text color to default
    mov eax, black + (white * 16)
    call SetTextColor

    pop dx
    pop cx
    pop bx
    pop ax
    ret
drawBricks ENDP

Play PROC
    call Clrscr
    mov paddleX, 35
    mov paddleY, 23
    mov bricksX, 8
    mov bricksY, 0
    mov ballX, 25
    mov ballY, 13
    mov ballDirX, 1           ; Initial direction: moving right
    mov ballDirY, -1          ; Initial direction: moving upward
    mov dl, 52                ; Set column (X-coordinate)
    mov dh, 26                ; Set row (Y-coordinate)
    call Gotoxy               ; Move cursor to specified position
    mwrite "LEVEL 1"          ; Write "LEVEL 1" at the cursor position
    mov dl, 110               ; Set column (X-coordinate)
    mov dh, 26                ; Set row (Y-coordinate)
    call Gotoxy               ; Move cursor to specified position
    mov edx, OFFSET username
    call writeString
    call drawBricks
    call drawPaddle
    call DrawLives
    call displayScore
    ; Initialize totalTime with 240 seconds (4 minutes)
    call displayTime          ; Initial display of the timer

GameLoop:
    call updateTime           ; Update the time (decrement by 1 second)
    call drawBall
    call MovePaddle           ; Handle paddle movement
    call moveBall             ; Handle ball movement
    ; Removed duplicate call to updateTime

    cmp totalTime, 0          ; Check if time has run out
    je EndGame                ; If time is up, end the game
    mov eax, 90
    call Delay                ; Add delay for smooth animation
    jmp GameLoop

EndGame:
   call gameOver
    ret
Play ENDP


; Procedure to Update Time
updateTime PROC
    push eax
    push ecx
 
    ; Decrement total time left (1 second)
    dec totalTime              ; Reduce time by one second
    call displayTime           ; Update and display the time on the screen

    pop ecx
    pop eax
    ret
updateTime ENDP

; Procedure to display the time in MM:SS format using writeDec
displayTime PROC
    push eax
    push ebx
    push ecx
    push edx
    
    mov eax, black
    imul eax, 16
    add eax, white
    call SetTextColor

     ; Display "Time Left: "
    mov dl, 0                  ; Column (X-coordinate for timer display)
    mov dh, 28                 ; Row (Y-coordinate for timer display)
    call Gotoxy
    mwrite "Time Left: "

    mov eax, totalTime         ; Load total time left in seconds
    shr eax, 2

    mov ebx, 60                ; Divisor for converting to minutes
    xor edx, edx               ; Clear high bits for division (remainder)
 

    div ebx                    ; EAX = minutes, EDX = seconds (remainder)
    ; Display minutes
    ;movzx eax, ah                 ; Minutes in EAX
    call writeDec              ; Write minutes (already in decimal format)
    ; Display separator ":"
    mwrite ":"
    ; Display seconds
    mov eax, edx                 ; Seconds in EAX
    call writeDec              ; Write seconds (already in decimal format)

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
displayTime ENDP


drawPaddle PROC
    push ax
    push bx
    push cx
    push dx

    ; Set paddle color to yellow text on red background
    mov eax, yellow + (red * 16)
    call SetTextColor

    ; Move to paddle's position
    mov dh, paddleY
    mov dl, paddleX
    call Gotoxy

    ; Determine paddle width
    mov cl, paddleWidth

    ; Adjust width for level 2
    cmp levelAt, 2          ; Compare levelAt with 2
    jne SkipWidthAdjustment ; If not level 2, skip adjustment
    sub cl, 2               ; Decrease width by 2
SkipWidthAdjustment:

    ; Draw the paddle line
drawPaddleLine:
    mov edx, OFFSET Hline   ; Load the address of Hline
    call WriteString        ; Print Hline at the current position
    dec cl                  ; Decrease counter
    cmp cl, 0               ; Check if counter reached zero
    jne drawPaddleLine      ; Repeat if not zero

    ; Reset text color to white on black
    mov eax, white + (black * 16)
    call SetTextColor

    ; Restore registers
    pop dx
    pop cx
    pop bx
    pop ax
    ret
drawPaddle ENDP


drawBall PROC
    mov eax, black             
    imul eax, 16                
    add eax, red
    call SetTextColor
    mov dl, ballX               
    mov dh, ballY               
    call Gotoxy                 
    mov edx, offset ballChar            
    call WriteString              
    mov eax, white              
    imul eax, 16                
    add eax, black
    call SetTextColor
    ret
drawBall ENDP

moveBall PROC

        call eraseBall

    mov al, ballDirX
    add ballX, al

    cmp ballX, 1
    jge CheckRightBall
    neg ballDirX
    mov ballX, 1
    jmp UpdateY

CheckRightBall:
    cmp ballX, 119
    jle UpdateY
    neg ballDirX
    mov ballX, 119

UpdateY:
    mov al, ballDirY
    add ballY, al
    cmp ballY, 0
    jge CheckPaddleCollision
    neg ballDirY
    mov ballY, 0
    jmp RedrawBall

CheckPaddleCollision:
    mov bl, paddleY
    sub bl, 1
    cmp ballY, bl
    jne CheckBottomBall

    mov ah, ballX
    cmp ah, paddleX
    jl CheckBottomBall
    mov al, paddleWidth
    add al, paddleX
    cmp ballX, al
    jg CheckBottomBall

    neg ballDirY
    jmp RedrawBall

CheckBottomBall:
    cmp ballY, 23
    jne RedrawBall
    call handleBallLoss
    jmp exitBall

RedrawBall:
    call drawBall
    call checkBrickCollision

exitBall:
    ret
moveBall ENDP

displayScore PROC
    push ax
    push bx
    push cx
    push dx

    ; Set the cursor to the score display position
    mov dl, 0          ; X position for score
    mov dh, 27           ; Y position for score
    call Gotoxy         ; Move cursor to the position

    ; Set text color to white on black
    mov eax, black
    imul eax, 16        ; Black background
    add eax, white      ; White text
    call SetTextColor

    mwrite "Score: " 
 
    ; Convert score to ASCII and display
    mov ax, score       ; Load score into AL
    call writeDec

    pop dx
    pop cx
    pop bx
    pop ax
    ret
displayScore ENDP

DrawLives PROC
    ; Set text color to white on black
    mov eax, black
    imul eax, 16
    add eax, white
    call SetTextColor

    ; Write "LIVES: " label
    mov dl, 0              ; Starting column (X-coordinate)
    mov dh, 26             ; Row (Y-coordinate)
    call Gotoxy            ; Set cursor position
    mwrite "LIVES: "       ; Print the label

    ; Start drawing lives as hearts
    mov cl, lives          ; Load the number of lives into CL
    mov dl, 7              ; Start after the label at column 7

DrawLoop:
    cmp cl, 0              ; Check if all lives are drawn
    je EndDraw             ; Exit loop if lives = 0

    call Gotoxy            ; Move cursor to the current position
    mov al, 03h            ; ASCII value for the heart symbol (?)
    call WriteChar         ; Draw the heart symbol
    add dl, 2              ; Move to the next column for spacing
    dec cl                 ; Decrement lives counter
    jmp DrawLoop           ; Repeat the loop

EndDraw:
    ret                    ; Exit the procedure
DrawLives ENDP


handleBallLoss PROC
   
    cmp lives, 3
    je firstLive
    cmp lives, 2
    je secondLive
    cmp lives, 1
    je thirdLive
 
firstLive:
    dec lives 
    mov dl, 11              ; Column (X-coordinate) for first life
    mov dh, 26              ; Row (Y-coordinate)
    call gotoxy
    mwrite " "              ; Erase the first life
    jmp ResetBall

secondLive:
    dec lives 
    mov dl, 9               ; Column (X-coordinate) for second life
    mov dh, 26              ; Row (Y-coordinate)
    call gotoxy
    mwrite " "              ; Erase the second life
    jmp ResetBall

thirdLive:
    dec lives 
    mov dl, 7               ; Column (X-coordinate) for third life
    mov dh, 26              ; Row (Y-coordinate)
    call gotoxy
    mwrite " "              ; Erase the third life
    call gameOver

ResetBall:
    mov ballX, 60           ; Reset ball to the center of the screen (X-axis)
    mov ballY, 12           ; Reset ball to the middle of the screen (Y-axis)
    neg ballDirY            ; Reverse Y direction to move upwards
    ret
handleBallLoss ENDP


gameOver PROC
    call Clrscr   
  
    mov eax, white + (black * 16)  
    call SetTextColor

    ; Display game over messages
    mov dh, 8
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET gameOver1
    call WriteString
    call Crlf

    mov dh, 9
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET gameOver2
    call WriteString
    call Crlf

    mov dh, 10
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET gameOver3
    call WriteString
    call Crlf

    mov dh, 11
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET gameOver4
    call WriteString
    call Crlf

    mov dh, 12
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET gameOver5
    call WriteString
    call Crlf

    call waitmsg
    call createAndWriteFile

exit
ret
gameOver ENDP

createAndWriteFile PROC
    call IntToStr

    lea esi, username
    lea edi, buffer
    mov ecx, SIZEOF username - 1
    cld
    rep movsb

    lea esi, newline
    mov ecx, SIZEOF newline - 1
    rep movsb

    invoke CreateFile, OFFSET namesFile, GENERIC_WRITE, 0, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
    mov fileHandle, eax
    invoke SetFilePointer, fileHandle, 0, 0, FILE_END
    invoke WriteFile, fileHandle, OFFSET buffer, SIZEOF username + SIZEOF newline - 2, 0, 0
    invoke CloseHandle, fileHandle

    lea esi, scoreStr
    lea edi, buffer
    mov ecx, SIZEOF scoreStr - 1
    rep movsb

    lea esi, newline
    mov ecx, SIZEOF newline - 1
    rep movsb

    invoke CreateFile, OFFSET scoresFile, GENERIC_WRITE, 0, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
    mov fileHandle, eax
    invoke SetFilePointer, fileHandle, 0, 0, FILE_END
    invoke WriteFile, fileHandle, OFFSET buffer, SIZEOF scoreStr + SIZEOF newline - 2, 0, 0
    invoke CloseHandle, fileHandle

    lea esi, buffer
    movzx eax, levelAt
    add al, '0'
    mov [esi], al
    mov levelAt, al

    mov byte ptr [esi+1], 0Ah

    invoke CreateFile, OFFSET levelsFile, GENERIC_WRITE, 0, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
    mov fileHandle, eax
    invoke SetFilePointer, fileHandle, 0, 0, FILE_END
    invoke WriteFile, fileHandle, OFFSET buffer, SIZEOF levelAt + SIZEOF newline - 2, 0, 0
    invoke CloseHandle, fileHandle

    call ReadScoresFromFile
    call ReadNamesFromFile
    call ReadLevelsFromFile
    call SortScoresDescending

createAndWriteFile ENDP

IntToStr PROC
    mov ax, score
    cmp ax, 100
    jl twoDigit
    cmp ax, 10
    jl oneDigit

    mov cx, 100
    xor dx, dx
    div cx
    add al, '0'
    mov scoreStr[0], al
    mov ax, dx
    mov cx, 10
    xor dx, dx
    div cx
    add al, '0'
    mov scoreStr[1], al
    mov ax, dx
    add al, '0'
    mov scoreStr[2], al
    mov scoreStr[3], 0
    ret

twoDigit:
    mov cx, 10
    xor dx, dx
    div cx
    add al, '0'
    mov scoreStr[0], al
    mov ax, dx
    add al, '0'
    mov scoreStr[1], al
    mov scoreStr[2], 0
    ret

oneDigit:
    add al, '0'
    mov scoreStr[0], al
    mov scoreStr[1], 0
    ret

IntToStr ENDP

ReadScoresFromFile PROC
    invoke CreateFile, OFFSET scoresFile, GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
    mov fileHandle, eax
    lea esi, buffer
    xor ebx, ebx
    xor ecx, ecx

readByteLoop:
    invoke ReadFile, fileHandle, esi, 1, OFFSET scoreCount, 0
    cmp eax, 0
    je endParse
    cmp byte ptr [esi], 0Ah     ; Check for newline
    je storeScore
    inc esi
    inc ecx
    jmp readByteLoop

storeScore:
    mov byte ptr [esi], 0       ; Null-terminate the string
    lea edi, buffer
    mov edx, offset buffer
    ;call WriteString            ; Debug: Print the buffer content
    ;call Crlf

    call ConvertStringToInt     ; Convert string to integer
    ;call WriteDec               ; Debug: Print the converted integer
    ;call Crlf
    lea edi, scoresArray
    mov [edi + ebx*4], eax      ; Store the converted number in the array
    ;call WriteDec
    ;call Crlf
    inc ebx
    cmp ebx, 10                 ; Limit to 10 scores
    je endParse
    lea esi, buffer             ; Reset buffer pointer
    xor ecx, ecx                ; Reset character counter
    jmp readByteLoop

endParse:
    invoke CloseHandle, fileHandle
    mov scoreCount, ebx         ; Update score count
    ret
ReadScoresFromFile ENDP

ConvertStringToInt PROC
    xor eax, eax
    xor ecx, ecx
    lea esi, buffer

convertLoop:
    movzx edx, byte ptr [esi + ecx]
    cmp dl, 0
    je done
    sub dl, '0'
    imul eax, eax, 10
    add eax, edx
    inc ecx
    jmp convertLoop

done:
    ret
ConvertStringToInt ENDP

ReadNamesFromFile PROC
    invoke CreateFile, OFFSET namesFile, GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
    mov fileHandle, eax
    lea esi, buffer
    xor ebx, ebx
    xor ecx, ecx

readByteLoop1:
    push ecx
    invoke ReadFile, fileHandle, esi, 1, OFFSET tempCount, 0
    cmp eax, 0
    je endParse1
    add nameCount, eax

    pop ecx
    mov edx, ebx
    imul edx, MAX_NAME_LENGTH
    add edx, ecx
    lea edi, namesArray
    mov al, byte ptr [esi]
    mov [edi + edx], al

    cmp al, 0Dh
    je storeName

    inc ecx
    jmp readByteLoop1
storeName:
    mov edx, ebx
    imul edx, MAX_NAME_LENGTH
    add edx, ecx
    lea edi, namesArray
    mov byte ptr [edi + edx], 0

    inc ebx
    cmp ebx, MAX_NAMES
    je endParse1
    xor ecx, ecx
    jmp readByteLoop1

endParse1:
    invoke CloseHandle, fileHandle
    mov nameCount, ebx
    ret
ReadNamesFromFile ENDP

ReadLevelsFromFile PROC
    invoke CreateFile, OFFSET levelsFile, GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
    mov fileHandle, eax
    lea esi, buffer
    xor ebx, ebx
    xor ecx, ecx

readByteLoop2:
    push ecx
    invoke ReadFile, fileHandle, esi, 1, OFFSET levelCount, 0
    cmp eax, 0
    je endParse2
    pop ecx

    cmp byte ptr [esi], 0Ah
    je storeLevel

    mov edx, ebx
    imul edx, MAX_LEVEL_LENGTH
    add edx, ecx
    lea edi, levelsArray
    mov al, byte ptr [esi]
    mov [edi + edx], al

    inc ecx
    jmp readByteLoop2

storeLevel:
    mov edx, ebx
    imul edx, MAX_LEVEL_LENGTH
    add edx, ecx
    lea edi, levelsArray
    mov byte ptr [edi + edx], 0
    inc ebx
    cmp ebx, MAX_LEVELS
    je endParse2
    xor ecx, ecx
    jmp readByteLoop2

endParse2:
    invoke CloseHandle, fileHandle
    mov levelCount, ebx
    ret
ReadLevelsFromFile ENDP

SortScoresDescending PROC
    mov ecx, scoreCount
    dec ecx
outerLoop:
    lea esi, scoresArray
    mov eax, ecx

innerLoop:
    mov ebx, [esi]
    mov edx, [esi + 4]
    cmp ebx, edx
    jge skipSwap

    mov [esi], edx
    mov [esi + 4], ebx

    lea esi, namesArray
    mov ebx, ecx
    sub ebx, eax
    imul ebx, MAX_NAME_LENGTH
    lea esi, [esi + ebx]

    lea edi, [esi + MAX_NAME_LENGTH]

    mov ecx, MAX_NAME_LENGTH
swapNamesLoop:
    mov al, [esi]
    mov bl, [edi]
    mov [edi], al
    mov [esi], bl
    inc esi
    inc edi
    loop swapNamesLoop

skipSwap:
    add esi, 4
    dec eax
    jnz innerLoop

    dec ecx
    jnz outerLoop

    ret
SortScoresDescending ENDP

eraseBall PROC
    ; Preserve registers
    push ax
    push bx
    push cx
    push dx

    ; Set text color to black (background color)
    mov eax, black
    imul eax, 16                ; Multiply black by 16 for text and background
    add eax, black
    call SetTextColor

    ; Move to the current ball position
    mov dl, ballX               ; Current X position of the ball
    mov dh, ballY               ; Current Y position of the ball
    call Gotoxy

    ; Erase the ball by printing a blank space
    mov edx, OFFSET space      ; space is a single space character
    call WriteString
    
    mov eax, black
    imul eax, 16
    add eax, white
    call SetTextColor
    ; Restore registers
    pop dx
    pop cx
    pop bx
    pop ax
    ret
eraseBall ENDP


MovePaddle PROC
    ; Poll for a key press
    mov eax, 0                ; Clear eax to ensure no prior input affects behavior
    call ReadKey              ; Read a key if available
    cmp al, 0                 ; Check if a valid key was captured
    je NoKeyPressed           ; Skip processing if no key was pressed

    ; Key handling logic
    cmp al, 'a'               ; Check if 'a' key is pressed for left movement
    je MoveLeft
    cmp al, 'd'               ; Check if 'd' key is pressed for right movement
    je MoveRight
    cmp al, 27                ; Check if ESC key (ASCII 27) is pressed to end the game
    je EndGame1

NoKeyPressed:
    ret                       ; Return if no key was pressed

MoveLeft:
    ; Move paddle left
    cmp paddleX, 1            ; Ensure paddle does not move out of bounds
    jle SkipLeft
    call erasePaddle
    sub paddleX, 2
    call drawPaddle
SkipLeft:
    ret

MoveRight:
    ; Move paddle right
    cmp paddleX, 110          ; Ensure paddle does not move out of bounds
    jge SkipRight
    call erasePaddle
    add paddleX, 2
    call drawPaddle
SkipRight:
    ret

EndGame1:
    ret

MovePaddle ENDP


erasePaddle PROC
    push ax
    push bx
    push cx
    push dx

    mov eax,  black + (black * 16)
    call SetTextColor

    mov dh, paddleY
    mov dl, paddleX

    call Gotoxy

    mov cl, paddleWidth
drawPaddleLine:
    mov edx, OFFSET spaceP
    call WriteString
    dec cl
    cmp cl, 0
    jne drawPaddleLine

    pop dx
    pop cx
    pop bx
    pop ax
    ret
erasePaddle ENDP

checkBrickCollision PROC
    push ax
    push bx
    push cx
    push dx

    ; Initialize the starting row (brickStartY) and end row
    mov brickStartY, 0
    mov cx, 4              ; Total number of brick rows

RowCheckLoop:
       mov dl, ballY
    cmp dl, brickStartY
    jne SkipToNextRow

    cmp levelAt, 2
    je CallCheckRowBricks2
    cmp levelAt, 3
    je CallCheckRowBricks3

    call CheckRowBricks
    jmp EndCollisionCheck

CallCheckRowBricks2:
    call CheckRowBricks2
    jmp EndCollisionCheck

CallCheckRowBricks3:
    call CheckRowBricks3
    jmp EndCollisionCheck

SkipToNextRow:
    add brickStartY, 2
    dec cx
    jnz RowCheckLoop

EndCollisionCheck:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
checkBrickCollision ENDP


CheckRowBricks PROC
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx

    mov row, 0
    mov col, 0

    movzx ax, ballY
    cmp ax, 0
    je SelectRow1
    cmp ax, 2
    je SelectRow2
    cmp ax, 4
    je SelectRow3
    cmp ax, 6
    je SelectRow4
    jmp SkipProcessBrick

SelectRow1:
    mov row, 0
    jmp DetermineColumn

SelectRow2:
    mov row, 1
    jmp DetermineColumn

SelectRow3:
    mov row, 2
    jmp DetermineColumn

SelectRow4:
    mov row, 3
    jmp DetermineColumn

DetermineColumn:
    movzx ax, ballX

    cmp ax, 8
    jl SkipProcessBrick
    cmp ax, 14
    jbe Column0

    cmp ax, 16
    jl SkipProcessBrick
    cmp ax, 22
    jbe Column1

    cmp ax, 24
    jl SkipProcessBrick
    cmp ax, 30
    jbe Column2

    cmp ax, 32
    jl SkipProcessBrick
    cmp ax, 38
    jbe Column3

    cmp ax, 40
    jl SkipProcessBrick
    cmp ax, 46
    jbe Column4

    cmp ax, 48
    jl SkipProcessBrick
    cmp ax, 54
    jbe Column5

    cmp ax, 56
    jl SkipProcessBrick
    cmp ax, 62
    jbe Column6

    cmp ax, 64
    jl SkipProcessBrick
    cmp ax, 70
    jbe Column7

    cmp ax, 72
    jl SkipProcessBrick
    cmp ax, 78
    jbe Column8

    cmp ax, 80
    jl SkipProcessBrick
    cmp ax, 86
    jbe Column9

    cmp ax, 88
    jl SkipProcessBrick
    cmp ax, 94
    jbe Column10

    cmp ax, 96
    jl SkipProcessBrick
    cmp ax, 102
    jbe Column11

    cmp ax, 104
    jl SkipProcessBrick
    cmp ax, 110
    jbe Column12

    jmp SkipProcessBrick

Column0:
    mov col, 0
    jmp ProcessBrick

Column1:
    mov col, 1
    jmp ProcessBrick

Column2:
    mov col, 2
    jmp ProcessBrick

Column3:
    mov col, 3
    jmp ProcessBrick

Column4:
    mov col, 4
    jmp ProcessBrick

Column5:
    mov col, 5
    jmp ProcessBrick

Column6:
    mov col, 6
    jmp ProcessBrick

Column7:
    mov col, 7
    jmp ProcessBrick

Column8:
    mov col, 8
    jmp ProcessBrick

Column9:
    mov col, 9
    jmp ProcessBrick

Column10:
    mov col, 10
    jmp ProcessBrick

Column11:
    mov col, 11
    jmp ProcessBrick

Column12:
    mov col, 12

ProcessBrick:
    lea edi, bricksStatusRow1
    cmp row, 1
    je SetRow2
    cmp row, 2
    je SetRow3
    cmp row, 3
    je SetRow4
    jmp AccessBrick

SetRow2:
    lea edi, bricksStatusRow2
    jmp AccessBrick

SetRow3:
    lea edi, bricksStatusRow3
    jmp AccessBrick

SetRow4:
    lea edi, bricksStatusRow4

AccessBrick:
    mov ax, col
    mov bx, 2
    imul ax, bx
    add edi, eax

    mov ax, [edi]
    cmp ax, 1
    je SkipProcessBrick

    mov word ptr [edi], 1 

    ; Erase the brick and bounce the ball
    call eraseBrick

    mov al, ballDirY  ; Load ballDirY into AX
    cmp al, 0         ; Compare ballDirY with 0
    jge SkipBounce    ; If ballDirY >= 0, skip negation

    neg ballDirY

SkipBounce:
    call drawBall
    ret

SkipProcessBrick:
    ret
CheckRowBricks ENDP

eraseBrick PROC
    ; Erase the brick at the current position
    push ax
    push bx
    push cx
    push dx

    ; Calculate Y coordinate based on row
    mov ax, row         ; Load row into AX
    imul ax, 2          ; Multiply by 2 (row spacing is 2)
    mov brickStartY, al ; Set Y coordinate

    ; Update score based on row
    mov al, brickStartY
    cmp al, 6
    je AddScore1
    cmp al, 4
    je AddScore2
    cmp al, 2
    je AddScore3
    cmp al, 0
    je AddScore4
    jmp SkipScore

AddScore1:
    add score, 1
    jmp SkipScore

AddScore2:
    add score, 2
    jmp SkipScore

AddScore3:
    add score, 3
    jmp SkipScore

AddScore4:
    add score, 4

SkipScore:
    call displayScore

        mov ax, col
    mov bx, 8
    imul ax, bx
    add al, 8
    mov brickStartX, al

    mov dl, brickStartX
    mov dh, brickStartY
    call Gotoxy

    mov eax, black
    imul eax, 16
    add eax, black
    call SetTextColor

    mov cl, 7
eraseLoop:
    mov al, ' '
    call WriteChar
    inc dl
    dec cl
    jnz eraseLoop

    dec remainingBricks

    cmp remainingBricks, 10
    jne ContinueGame
    jmp callLevel2

ContinueGame:
    pop dx
    pop cx
    pop bx
    pop ax
    ret

CallLevel2:
    ; Transition to Level 2 when the score reaches 130
    call Level2
    jmp ExitEraseBrick  ; Exit the procedure

ExitEraseBrick:
    ; Restore registers and exit
    pop dx
    pop cx
    pop bx
    pop ax
    ret
eraseBrick ENDP

changeBrickColor PROC
    ; Save registers
    push ax
    push bx
    push cx
    push dx

    ; Calculate Y coordinate based on row
    mov ax, row         ; Load row into AX
    imul ax, 2          ; Multiply by 2 (row spacing is 2)
    mov brickStartY, al ; Set Y coordinate

    ; Update score based on row
    mov al, brickStartY
    cmp al, 6
    je AddScore1
    cmp al, 4
    je AddScore2
    cmp al, 2
    je AddScore3
    cmp al, 0
    je AddScore4
    jmp SkipScore

AddScore1:
    add score, 1
    jmp SkipScore

AddScore2:
    add score, 2
    jmp SkipScore

AddScore3:
    add score, 3
    jmp SkipScore

AddScore4:
    add score, 4

SkipScore:
    call displayScore

    ; Calculate X coordinate based on col
    mov ax, col
    mov bx, 8
    imul ax, bx
    add al, 8
    mov brickStartX, al ; Set X coordinate

    ; Set the cursor position to (brickStartX, brickStartY)
    mov dl, brickStartX ; Set cursor X position
    mov dh, brickStartY ; Set cursor Y position
    call Gotoxy

    ; Change the brick color based on row
    mov ax, row
    cmp ax, 0
    je setLightBlue
    cmp ax, 1
    je setLightRed
    cmp ax, 2
    je setLightCyan
    cmp ax, 3 
    je setLightGreen
    jmp SkipColorChange

setLightBlue:
    mov eax, black + (lightBlue * 16)
    call SetTextColor
    jmp PrintBrick

setLightRed:
    mov eax, black + (lightRed * 16)
    call SetTextColor
    jmp PrintBrick

setLightCyan:
    mov eax, black + (lightCyan * 16)
    call SetTextColor
    jmp PrintBrick

setLightGreen:
    mov eax, black + (lightGreen * 16)
    call SetTextColor

PrintBrick:
    mwrite "       "    ; Print the brick block
    jmp SkipColorChange

SkipColorChange:
    ; Decrement the remaining bricks counter
    dec remainingBricks

    ; Check if all bricks are erased
    cmp remainingBricks, 0
    jne ContinueGame

    call gameOver

ContinueGame:
    
    ; Restore registers
    pop dx
    pop cx
    pop bx
    pop ax
    ret

ExitChangeBrickColor:
    ; Restore registers and exit
    pop dx
    pop cx
    pop bx
    pop ax
    ret
changeBrickColor ENDP

Level2 PROC
    call Clrscr              ; Irvine32 function to clear the screen

    mov eax, white + (black * 16)  ; Black background, Blue foreground
    call SetTextColor

    mov dh, 8
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET level2_1
    call WriteString
    call Crlf

    mov dh, 9
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET level2_2
    call WriteString
    call Crlf

    mov dh, 10
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET level2_3
    call WriteString
    call Crlf

    mov dh, 11
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET level2_4
    call WriteString
    call Crlf

    mov dh, 12
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET level2_5
    call WriteString

    call WaitMsg             ; Display "Press any key to continue..."
    
    call Play2

level2 ENDP

CheckRowBricks2 PROC
    xor ax,ax
    xor bx,bx
    xor cx,cx
    xor dx,dx
; Initialize row and col
    mov row, 0
    mov col, 0

    movzx ax, ballY
    cmp ax, 0
    je SelectRow1
    cmp ax, 2
    je SelectRow2
    cmp ax, 4
    je SelectRow3
    cmp ax, 6
    je SelectRow4
    jmp SkipProcessBrick

SelectRow1:
    mov row, 0
    jmp DetermineColumn

SelectRow2:
    mov row, 1
    jmp DetermineColumn

SelectRow3:
    mov row, 2
    jmp DetermineColumn

SelectRow4:
    mov row, 3
    jmp DetermineColumn

DetermineColumn:
    movzx ax, ballX

    cmp ax, 8
    jl SkipProcessBrick
    cmp ax, 14
    jbe Column0

    cmp ax, 16
    jl SkipProcessBrick
    cmp ax, 22
    jbe Column1

    cmp ax, 24
    jl SkipProcessBrick
    cmp ax, 30
    jbe Column2

    cmp ax, 32
    jl SkipProcessBrick
    cmp ax, 38
    jbe Column3

    cmp ax, 40
    jl SkipProcessBrick
    cmp ax, 46
    jbe Column4

    cmp ax, 48
    jl SkipProcessBrick
    cmp ax, 54
    jbe Column5

    cmp ax, 56
    jl SkipProcessBrick
    cmp ax, 62
    jbe Column6

    cmp ax, 64
    jl SkipProcessBrick
    cmp ax, 70
    jbe Column7

    cmp ax, 72
    jl SkipProcessBrick
    cmp ax, 78
    jbe Column8

    cmp ax, 80
    jl SkipProcessBrick
    cmp ax, 86
    jbe Column9

    cmp ax, 88
    jl SkipProcessBrick
    cmp ax, 94
    jbe Column10

    cmp ax, 96
    jl SkipProcessBrick
    cmp ax, 102
    jbe Column11

    cmp ax, 104
    jl SkipProcessBrick
    cmp ax, 110
    jbe Column12

    jmp SkipProcessBrick

Column0:
    mov col, 0
    jmp ProcessBrick

Column1:
    mov col, 1
    jmp ProcessBrick

Column2:
    mov col, 2
    jmp ProcessBrick

Column3:
    mov col, 3
    jmp ProcessBrick

Column4:
    mov col, 4
    jmp ProcessBrick

Column5:
    mov col, 5
    jmp ProcessBrick

Column6:
    mov col, 6
    jmp ProcessBrick

Column7:
    mov col, 7
    jmp ProcessBrick

Column8:
    mov col, 8
    jmp ProcessBrick

Column9:
    mov col, 9
    jmp ProcessBrick

Column10:
    mov col, 10
    jmp ProcessBrick

Column11:
    mov col, 11
    jmp ProcessBrick

Column12:
    mov col, 12

ProcessBrick:
    ; Access the brick's status
    lea edi, bricksStatusRow1 ; Default to Row1 address
    cmp row, 1
    je SetRow2
    cmp row, 2
    je SetRow3
    cmp row, 3
    je SetRow4
    jmp AccessBrick

SetRow2:
    lea edi, bricksStatusRow2
    jmp AccessBrick

SetRow3:
    lea edi, bricksStatusRow3
    jmp AccessBrick

SetRow4:
    lea edi, bricksStatusRow4

AccessBrick:
    mov ax, col
    mov bx, 2
    imul ax, bx
    add edi, eax

    mov ax, [edi]
    cmp ax, 2
    je SkipProcessBrick

    cmp ax, 0
    je FirstHit

    cmp ax, 1
    je SecondHit

FirstHit:
    mov word ptr [edi], 1
    call changeBrickColor
    jmp BounceBall

SecondHit:
    mov word ptr [edi], 2
    call eraseBrick2

BounceBall:
    mov al, ballDirY
    cmp al, 0
    jge SkipBounce

    neg ballDirY

SkipBounce:
    add BallY, 1
    call drawBall
    ret

SkipProcessBrick:
    ret

CheckRowBricks2 ENDP

Play2 PROC
    call Clrscr
    mov levelAt, 2

    mov lives, 3
    mov totalTime, 1440
    mov remainingBricks, 52

      lea esi, bricksStatusRow1
    mov cx, 13
    xor ax, ax
Row1Loop:
    mov [esi], ax
    add esi, 2
    loop Row1Loop

    lea esi, bricksStatusRow2
    mov cx, 13
Row2Loop:
    mov [esi], al
    add esi, 2
    loop Row2Loop

    lea esi, bricksStatusRow3
    mov cx, 13
Row3Loop:
    mov [esi], al
    add esi, 2
    loop Row3Loop

    lea esi, bricksStatusRow4
    mov cx, 13
Row4Loop:
    mov [esi], al
    add esi, 2
    loop Row4Loop

    mov paddleX, 35
    mov paddleY, 23
    mov bricksX, 8
    mov bricksY, 0
    mov ballX, 25
    mov ballY, 13
    mov ballDirX, 1
    mov ballDirY, -1
    mov dl, 52
    mov dh, 26
    call Gotoxy
    mwrite "LEVEL 2"
    mov dl, 110
    mov dh, 26
    call Gotoxy
    mov edx, OFFSET username
    call writeString
    call drawBricks
    call drawPaddle
    call DrawLives
    call displayScore
    call displayTime

GameLoop:
    call updateTime
    call drawBall
    call MovePaddle
    call moveBall

    cmp totalTime, 0
    je EndGame

    mov eax, 60
    call Delay
    jmp GameLoop


EndGame:
   call GameOver
    ret
Play2 ENDP

eraseBrick2 PROC
    ; Erase the brick at the current position
    push ax
    push bx
    push cx
    push dx

    ; Calculate Y coordinate based on row
    mov ax, row         ; Load row into AX
    imul ax, 2          ; Multiply by 2 (row spacing is 2)
    mov brickStartY, al ; Set Y coordinate

    ; Update score based on row
    mov al, brickStartY
    cmp al, 6
    je AddScore1
    cmp al, 4
    je AddScore2
    cmp al, 2
    je AddScore3
    cmp al, 0
    je AddScore4
    jmp SkipScore

AddScore1:
    add score, 1
    jmp SkipScore

AddScore2:
    add score, 2
    jmp SkipScore

AddScore3:
    add score, 3
    jmp SkipScore

AddScore4:
    add score, 4

SkipScore:
    call displayScore

       mov ax, col
    mov bx, 8
    imul ax, bx
    add al, 8
    mov brickStartX, al

    mov dl, brickStartX
    mov dh, brickStartY
    call Gotoxy

    mov eax, black
    imul eax, 16
    add eax, black
    call SetTextColor

    mov cl, 7
eraseLoop:
    mov al, ' '
    call WriteChar
    inc dl
    dec cl
    jnz eraseLoop

    dec remainingBricks

    cmp remainingBricks, 25
    jne ContinueGame
    call callLevel3


ContinueGame:
 
    ; Restore registers
    pop dx
    pop cx
    pop bx
    pop ax
    ret

CallLevel3:
    ; Transition to Level 2 when the score reaches 130
    call Level_3
    jmp ExitEraseBrick  ; Exit the procedure
ExitEraseBrick:
    ; Restore registers and exit
    pop dx
    pop cx
    pop bx
    pop ax
    ret
eraseBrick2 ENDP


changeBrickColor3 PROC
    ; Save registers
    push ax
    push bx
    push cx
    push dx

    ;cmp row, 3
    ;cmp col, 11
    ;set lightgray brick
    ;at dl, 96
    ; dh, 6
    
    
    ; Calculate Y coordinate based on row
    mov ax, row         ; Load row into AX
    imul ax, 2          ; Multiply by 2 (row spacing is 2)
    mov brickStartY, al ; Set Y coordinate

    ; Update score based on row
    mov al, brickStartY
    mov bx, col         ; Combine row (AL) and column (AH) for comparison

    ; Check for fixed bricks
    cmp al, 0           ; Row 0 checks
    je CheckRow0
    cmp al, 2           ; Row 1 checks
    je CheckRow1
    cmp al, 4           ; Row 2 checks
    je CheckRow2
    cmp al, 6           ; Row 3 checks
    je CheckRow3
    jmp DefaultScore

CheckRow0:
    cmp bx, 0           ; Column 0
    je setGrayColor
    cmp bx, 12          ; Column 12
    je setGrayColor
    jmp DefaultScore

CheckRow1:
    cmp bx, 9           ; Column 9
    je setGrayColor
    jmp DefaultScore

CheckRow2:
    cmp bx, 1           ; Column 1
    je setGrayColor
    cmp bx, 5           ; Column 5
    je setGrayColor
    jmp DefaultScore

CheckRow3:
    cmp bx, 11          ; Column 11
    je setGrayColor
    jmp DefaultScore

DefaultScore:
    cmp al, 6
    je AddScore1
    cmp al, 4
    je AddScore2
    cmp al, 2
    je AddScore3
    cmp al, 0
    je AddScore4
    jmp SkipScore

AddScore1:
    add score, 1
    jmp SkipScore

AddScore2:
    add score, 2
    jmp SkipScore

AddScore3:
    add score, 3
    jmp SkipScore

AddScore4:
    add score, 4

SkipScore:
    call displayScore

    mov ax, col
    mov bx, 8
    imul ax, bx
    add al, 8
    mov brickStartX, al

    mov dl, brickStartX
    mov dh, brickStartY
    call Gotoxy

    mov ax, row
    cmp ax, 0
    je setLightBlue
    cmp ax, 1
    je setLightRed
    cmp ax, 2
    je setLightCyan
    cmp ax, 3
    je setLightGreen
    jmp SkipColorChange

setGrayColor:
    mov ax, col
    mov bx, 8
    imul ax, bx
    add al, 8
    mov brickStartX, al

    mov dl, brickStartX
    mov dh, brickStartY
    call Gotoxy

    
    mov eax, black + (lightGray * 16)
    call SetTextColor
    jmp PrintBrick

setLightBlue:
    mov eax, black + (lightBlue * 16)
    call SetTextColor
    jmp PrintBrick

setLightRed:
    mov eax, black + (lightRed * 16)
    call SetTextColor
    jmp PrintBrick

setLightCyan:
    mov eax, black + (lightCyan * 16)
    call SetTextColor
    jmp PrintBrick

setLightGreen:
    mov eax, black + (lightGreen * 16)
    call SetTextColor

PrintBrick:
    mwrite "       "    ; Print the brick block
    jmp SkipColorChange

SkipColorChange:
    ; Restore registers
    pop dx
    pop cx
    pop bx
    pop ax
    ret

changeBrickColor3 ENDP

CheckRowBricks3  PROC
    xor ax, ax              ; Clear registers
    xor bx, bx
    xor cx, cx
    xor dx, dx

    mov row, 0
    mov col, 0

    movzx ax, ballY
    cmp ax, 0
    je SelectRow1
    cmp ax, 2
    je SelectRow2
    cmp ax, 4
    je SelectRow3
    cmp ax, 6
    je SelectRow4
    jmp SkipProcessBrick

SelectRow1:
    mov row, 0
    jmp DetermineColumn

SelectRow2:
    mov row, 1
    jmp DetermineColumn

SelectRow3:
    mov row, 2
    jmp DetermineColumn

SelectRow4:
    mov row, 3
    jmp DetermineColumn

DetermineColumn:
    xor eax,eax
    movzx ax, ballX

    cmp ax, 8
    jl SkipProcessBrick
    cmp ax, 14
    jbe Column0

    cmp ax, 16
    jl SkipProcessBrick
    cmp ax, 22
    jbe Column1

    cmp ax, 24
    jl SkipProcessBrick
    cmp ax, 30
    jbe Column2

    cmp ax, 32
    jl SkipProcessBrick
    cmp ax, 38
    jbe Column3

    cmp ax, 40
    jl SkipProcessBrick
    cmp ax, 46
    jbe Column4

    cmp ax, 48
    jl SkipProcessBrick
    cmp ax, 54
    jbe Column5

    cmp ax, 56
    jl SkipProcessBrick
    cmp ax, 62
    jbe Column6

    cmp ax, 64
    jl SkipProcessBrick
    cmp ax, 70
    jbe Column7

    cmp ax, 72
    jl SkipProcessBrick
    cmp ax, 78
    jbe Column8

    cmp ax, 80
    jl SkipProcessBrick
    cmp ax, 86
    jbe Column9

    cmp ax, 88
    jl SkipProcessBrick
    cmp ax, 94
    jbe Column10

    cmp ax, 96
    jl SkipProcessBrick
    cmp ax, 102
    jbe Column11

    cmp ax, 104
    jl SkipProcessBrick
    cmp ax, 110
    jbe Column12

    jmp SkipProcessBrick


Column0:
    mov col, 0
    jmp ProcessBrick

Column1:
    mov col, 1
    jmp ProcessBrick

Column2:
    mov col, 2
    jmp ProcessBrick

Column3:
    mov col, 3
    jmp ProcessBrick

Column4:
    mov col, 4
    jmp ProcessBrick

Column5:
    mov col, 5
    jmp ProcessBrick

Column6:
    mov col, 6
    jmp ProcessBrick

Column7:
    mov col, 7
    jmp ProcessBrick

Column8:
    mov col, 8
    jmp ProcessBrick

Column9:
    mov col, 9
    jmp ProcessBrick

Column10:
    mov col, 10
    jmp ProcessBrick

Column11:
    mov col, 11
    jmp ProcessBrick

Column12:
    mov col, 12
    jmp ProcessBrick

ProcessBrick:
    lea edi, bricksStatusRow1 ; 
    cmp row, 1
    je SetRow2
    cmp row, 2
    je SetRow3
    cmp row, 3
    je SetRow4
    jmp AccessBrick

SetRow2:
    lea edi, bricksStatusRow2
    jmp AccessBrick

SetRow3:
    lea edi, bricksStatusRow3
    jmp AccessBrick

SetRow4:
    lea edi, bricksStatusRow4

AccessBrick:
    cmp row, 3
    jne NotFixedBrick
    cmp col, 11
    jne NotFixedBrick

    mov ax, col
    mov bx, 2
    imul ax, bx
    add edi, eax

    mov word ptr [edi], 3

    mov dl, 96
    mov dh, 6
    call gotoxy
    mov eax, black + (lightGray * 16)
    call SetTextColor
    mwrite "       "
    jmp bounceball

NotFixedBrick:
    mov ax, col
    mov bx, 2
    imul ax, bx
    add edi, eax

    mov ax, [edi]

    cmp ax, 3
    jge SkipProcessBrick

    cmp ax, 0
    je FirstHit

    cmp ax, 1
    je SecondHit

    cmp ax, 2
    je ThirdHit


 
FirstHit:
    call updateScore
    jmp BounceBall

SecondHit:
    mov word ptr [edi], 2
    call changeBrickColor3
    jmp BounceBall

ThirdHit:
    mov word ptr [edi], 3
    call eraseBrick3
    jmp BounceBall

SkipProcessBrick:
    jmp Continue

bounceBall:
    add ballY, 1
    mov al, ballDirY
    cmp al, 0
    jge SkipBounce
    neg ballDirY

SkipBounce:
    call drawBall
    ret

Continue:
    ret
CheckRowBricks3 ENDP

removeFixedBricks PROC
    push ax
    push bx
    push cx
    push dx

    mov eax, black
    imul eax, 16
    add eax, black
    call SetTextColor

    mov dl, 8
    mov dh, 6
    call Gotoxy
    mwrite  "       ",0

    dec remainingBricks
    lea edi, bricksStatusRow4
    mov ax, 0
    mov bx, 2
    imul ax, bx
    add edi, eax
    mov word ptr [edi], 3 

    mov dl, 8           
    mov dh, 0           
    call Gotoxy         
    mwrite  "       ",0
   
    dec remainingBricks 

    lea edi, bricksStatusRow1  
    mov ax, 0             
    mov bx, 2               
    imul ax, bx             
    add edi, eax            
    mov word ptr [edi], 3 

    mov dl, 104         
    mov dh, 0           
    call Gotoxy
    mwrite  "       ",0
    dec remainingBricks

    lea edi, bricksStatusRow1  
    mov ax, 12             
    mov bx, 2               
    imul ax, bx             
    add edi, eax            
    mov word ptr [edi], 3 

    mov dl, 80          
    mov dh, 2           
    call Gotoxy
    mwrite  "       ",0
    dec remainingBricks

    lea edi, bricksStatusRow2 
    mov ax,  9             
    mov bx, 2               
    imul ax, bx             
    add edi, eax            
    mov word ptr [edi], 3 

    mov dl, 16          
    mov dh, 4           
    call Gotoxy
    mwrite  "       ",0
    dec remainingBricks

    lea edi, bricksStatusRow3  
    mov ax, 1             
    mov bx, 2               
    imul ax, bx             
    add edi, eax            
    mov word ptr [edi], 3 

    mov dl, 48           
    mov dh, 4            
    call Gotoxy
    mwrite  "       ",0
    dec remainingBricks  

    lea edi, bricksStatusRow3  
    mov ax, 5             
    mov bx, 2               
    imul ax, bx             
    add edi, eax

    mov word ptr [edi], 3 

    ; Restore registers
    pop dx
    pop cx
    pop bx
    pop ax
    ret
removeFixedBricks ENDP

updateScore PROC
    ; Save registers
    push ax
    push bx
    push cx
    push dx

    ; Check if row = 3 and col = 0
    cmp row, 3
    jne NotRow3
    cmp col, 0
    jne NotCol0

    lea edi, bricksStatusRow4
    cmp word ptr [edi], 0      
    jne notRow3
    ; Call removeFixedBricks
    call removeFixedBricks
    add score, 15
    mov eax, black + (black * 16)
    call SetTextColor
    jmp SkipColorChange

NotCol0:
NotRow3:

    mov word ptr [edi], 1 
    ; If row is not 3 or col is not 0, continue with existing score update logic
    ; Calculate Y coordinate based on row
    mov ax, row         ; Load row into AX
    imul ax, 2          ; Multiply by 2 (row spacing is 2)
    mov brickStartY, al ; Set Y coordinate

    ; Update score for non-fixed bricks
    cmp al, 6
    je AddScore1
    cmp al, 4
    je AddScore2
    cmp al, 2
    je AddScore3
    cmp al, 0
    je AddScore4
    jmp SkipScore

AddScore1:
    add score, 1
    jmp SkipScore

AddScore2:
    add score, 2
    jmp SkipScore

AddScore3:
    add score, 3
    jmp SkipScore

AddScore4:
    add score, 4

SkipScore:
    call displayScore

    mov ax, col         
    mov bx, 8           
    imul ax, bx         
    add al, 8           
    mov brickStartX, al 

    mov dl, brickStartX 
    mov dh, brickStartY 
    call Gotoxy         

    mov ax, row 
    cmp ax, 0          
    je setLightBlue
    cmp ax, 1          
    je setLightRed
    cmp ax, 2          
    je setLightCyan
    cmp ax, 3          
    je setLightGreen

setLightBlue:
    mov eax, black + (Blue * 16)
    call SetTextColor
    jmp PrintBrick

setLightRed:
    mov eax, black + (Red * 16)
    call SetTextColor
    jmp PrintBrick

setLightCyan:
    mov eax, black + (Cyan * 16)
    call SetTextColor
    jmp PrintBrick

setLightGreen:
    mov eax, black + (Green * 16)
    call SetTextColor
    jmp PrintBrick

PrintBrick:
    mwrite "       "    ; Print the brick block
    jmp SkipColorChange

SkipColorChange:

    pop dx
    pop cx
    pop bx
    pop ax
    ret

updateScore ENDP


eraseBrick3 PROC
    ; Save registers
    push ax
    push bx
    push cx
    push dx


    ; Calculate Y coordinate based on row
    mov ax, row         ; Load row into AX
    imul ax, 2          ; Multiply by 2 (row spacing is 2)
    mov brickStartY, al ; Set Y coordinate

    ; Update score based on row
    mov al, brickStartY
    cmp al, 6
    je AddScore1
    cmp al, 4
    je AddScore2
    cmp al, 2
    je AddScore3
    cmp al, 0
    je AddScore4
    jmp SkipScore

AddScore1:
    add score, 1
    jmp SkipScore

AddScore2:
    add score, 2
    jmp SkipScore

AddScore3:
    add score, 3
    jmp SkipScore

AddScore4:
    add score, 4

SkipScore:
    call displayScore

       mov ax, col         
    mov bx, 8           
    imul ax, bx         
    add al, 8           
    mov brickStartX, al 

    mov dl, brickStartX 
    mov dh, brickStartY 
    call Gotoxy         

    mov eax, black
    imul eax, 16        
    add eax, black      
    call SetTextColor

    mov cl, 7           
    eraseLoop:
        mov al, ' '         
        call WriteChar      
        inc dl              
        dec cl              
        jnz eraseLoop       

    dec remainingBricks 

    cmp remainingBricks, 0
    jne ContinueGame    

    ContinueGame:
        cmp score, 200
        jge callUwin        

        jmp SkipErase

CallUwin:
    call UWin
    jmp SkipErase

SkipErase:
    ; Restore registers
    pop dx
    pop cx
    pop bx
    pop ax
    ret
eraseBrick3 ENDP

drawBricks3 PROC
    push ax
    push bx
    push cx
    push dx

   mov dh, bricksY          
mov cl, brickRows        

rowLoop:
    push cx                  
    mov dl, bricksX          

    mov bl, brickCols        

columnLoop:
    push dx
    mov tempX, dl            
    mov tempY, dh            

    mov al, dh               
    mov ah, dl               

    cmp al, 0                
    je CheckCol0
    cmp al, 2                
    je CheckCol1
    cmp al, 4                
    je CheckCol6
    cmp al, 6                
    je CheckCol12
    jmp DefaultBrickColor

CheckCol0:
    cmp ah, 8                
    je SetGray
    cmp ah, 104              
    je SetGray
    jmp DefaultBrickColor
CheckCol1:
    cmp ah, 80               
    je SetGray
    jmp DefaultBrickColor

CheckCol6:
    cmp ah, 48               
    je SetGray
    
    cmp ah, 16              
    je SetGray
    jmp DefaultBrickColor

CheckCol12:
    cmp ah, 8
    je SetMagenta

    cmp ah, 96              
    je SetGray
    jmp DefaultBrickColor


SetGray:
    mov eax, black + (lightGray * 16) ; Black background, Gray foreground
    call SetTextColor
    jmp DrawBrick

SetMagenta:
    mov eax, black + (lightMagenta * 16) ; Black background, Gray foreground
    call SetTextColor
    jmp DrawBrick

DefaultBrickColor:
    ; Set default color based on row
    mov al, dh
    cmp al, 0
    je SetBlue
    cmp al, 2
    je SetRed
    cmp al, 4
    je SetCyan
    cmp al, 6
    je SetYellow
    mov eax, black + (white * 16) ; Default: Black background, White foreground
    call SetTextColor

SetBlue:
    mov eax, black + (blue * 16)  ; Black background, Blue foreground
    call SetTextColor
    jmp DrawBrick

SetRed:
    mov eax, black + (red * 16)   ; Black background, Red foreground
    call SetTextColor
    jmp DrawBrick

SetCyan:
    mov eax, black + (cyan * 16)  ; Black background, Cyan foreground
    call SetTextColor
    jmp DrawBrick

SetYellow:
    mov eax, black + (green * 16) ; Black background, Yellow foreground
    call SetTextColor
    jmp DrawBrick

DrawBrick:
    call Gotoxy              ; Move cursor to current position
    mwrite "       ", 0

    pop dx
    add dl, bricksWidth      
    add dl, brickSpacing     
    dec bl                   
    jnz columnLoop           

    pop cx
    add dh, 1                
    add dh, rowSpacing       
    dec cl                   
    jnz rowLoop              


    ; Reset text color to default
    mov eax, black + (white * 16)
    call SetTextColor

    pop dx
    pop cx
    pop bx
    pop ax
    ret
drawBricks3 ENDP



level_3 PROC
    mov eax, white + (black * 16)  
    call SetTextColor
    
    call Clrscr   
  
    mov eax, white + (black * 16)  
    call SetTextColor

    mov dh, 8
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET level3_1
    call WriteString
    call Crlf

    mov dh, 9
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET level3_2
    call WriteString
    call Crlf

    mov dh, 10
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET level3_3
    call WriteString
    call Crlf

    mov dh, 11
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET level3_4
    call WriteString
    call Crlf

    mov dh, 12
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET level3_5
    call WriteString

    call waitmsg
    call Play3
level_3 ENDP

Play3 PROC
    call Clrscr
   
    mov eax, white + (black * 16)
    call SetTextColor

    mov levelAt, 3
    mov lives, 3
  
    mov remainingBricks, 52

    ; Reset bricksStatus arrays to zero
    lea esi, bricksStatusRow1 
    mov cx, 13              ; Number of elements in the row
    xor ax, ax
Row1Loop:
    mov [esi], ax          ; Store zero at the current address
    add esi, 2
    loop Row1Loop

    lea esi, bricksStatusRow2 ; Repeat for bricksStatusRow2
    mov cx, 13
Row2Loop:
    mov [esi], al
    add esi, 2
    loop Row2Loop

    lea esi, bricksStatusRow3 ; Repeat for bricksStatusRow3
    mov cx, 13
Row3Loop:
    mov [esi], al
    add esi, 2
    loop Row3Loop

    lea esi, bricksStatusRow4 ; Repeat for bricksStatusRow4
    mov cx, 13
Row4Loop:
    mov [esi], al
    add esi, 2
    loop Row4Loop


    mov totalTime, 1440
    mov paddleX, 35
    mov paddleY, 23
    mov bricksX, 8
    mov bricksY, 0
    mov ballX, 25
    mov ballY, 13
    mov ballDirX, 1           
    mov ballDirY, -1          
    mov dl, 52                
    mov dh, 26                
    call Gotoxy               
    mwrite "LEVEL 3"          
    mov dl, 110               
    mov dh, 26                
    call Gotoxy               

    mov edx, OFFSET username
    call writeString
    call drawBricks3
    call drawPaddle
    call DrawLives
    call displayScore
    ; Initialize totalTime with 240 seconds (4 minutes)
    call displayTime          ; Initial display of the timer

GameLoop:
    call updateTime           ; Update the time (decrement by 1 second)
    call drawBall
    call MovePaddle           ; Handle paddle movement
    call moveBall             ; Handle ball movement
    ; Removed duplicate call to updateTime

    cmp totalTime, 0 
    je EndGame
   
    mov eax, 50
    call Delay                ; Add delay for smooth animation
    jmp GameLoop

EndGame:
   call GameOver
   ret
play3 ENDP

Instruction PROC
    call Clrscr

    mov eax, 6
    call SetTextColor

    mov dh, 4
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET menuInstruction
    call WriteString

    mov eax, 5
    call SetTextColor
    mov dh, 5
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET instStatement1
    call WriteString

    mov eax, 13
    call SetTextColor
    mov dh, 6
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET instStatement2
    call WriteString

    mov eax, 7
    call SetTextColor
    mov dh, 7
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET instStatement3
    call WriteString

    mov eax, 8
    call SetTextColor
    mov dh, 8
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET instStatement4
    call WriteString

    mov eax, 9
    call SetTextColor
    mov dh, 9
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET instStatement5
    call WriteString

    mov eax, 10
    call SetTextColor
    mov dh, 10
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET instStatement6
    call WriteString

    mov eax, 11
    call SetTextColor
    mov dh, 11
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET instStatement7
    call WriteString

    mov eax, 12
    call SetTextColor
    mov dh, 12
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET instStatement8
    call WriteString

    ret
Instruction ENDP

printName PROC
    ; Assume namesArray is already populated with names
    ; Assume MAX_NAME_LENGTH is 5 and MAX_NAMES is 10
    ; namesArray byte 256 dup(0)     ; Array of names (MAX_NAMES * MAX_NAME_LENGTH)

    mov esi, OFFSET namesArray      ; Load the base address of namesArray
    mov ecx, 10              ; Loop through MAX_NAMES
    xor edx, edx                    ; Clear edx to use as the character index within the current name
    xor ebx, ebx                    ; Clear ebx, will count characters processed

printLoop:
    lea ebx, [esi + edx]            ; Point to the current character in the current name
    mov al, [ebx]                   ; Load the current character
    cmp al, 0Ah                        ; Check if it's the end of the current name (NULL byte)
    je nextName                      ; If it's the end, move to the next name

    cmp al, 0                      ; Check if character is LF (Line Feed)
    je skipChar                      ; If LF, skip this character
    cmp al, 0Dh                      ; Check if character is CR (Carriage Return)
    je skipChar                      ; If CR, skip this character
    
    ; Print the valid character
    call WriteChar                  ; Write the character (assuming WriteChar is defined)
    inc edx                          ; Move to the next character in the current name
    jmp printLoop                    ; Continue processing the current name

skipChar:
    inc edx                          ; Skip the current character and move to the next one
    jmp printLoop                    ; Continue processing the next character in the current name

nextName:
    add edx, 1                       ; Move to the next name slot
    call crlf

    loop printLoop                   ; Continue looping until MAX_NAMES names are processed

    ; After printing all names, print a newline at the end
   call crlf

    ret
printName ENDP

displayScoreBoard PROC
    call Clrscr
    call printName
displayScoreBoard ENDP

ScoreBoard PROC
    call Clrscr
    mov edx, OFFSET menuScoreBoard
    call WriteString

    mov eax, 6
    call SetTextColor
    mov dh, 4
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET scrLine1
    call WriteString

    mov dh, 5
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET scrLine2
    call WriteString

    mov dh, 6
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET scrLine3
    call WriteString

    mov dh, 7
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET scrLine4
    call WriteString

    mov dh, 8
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET scrLine5
    call WriteString

     
     call displayScoreBoard
    ret
ScoreBoard ENDP


ExitProgram: 
    call Clrscr
    mov edx, OFFSET menuExit
    call WriteString
    call Crlf
    exit

END main
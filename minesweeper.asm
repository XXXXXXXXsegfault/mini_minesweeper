@WCname
.string "MINESWEEPER"
@WinName
.string "Minesweeper"


@rect
push %rbx
push %rsi
push %rdi
push %r9
mov $@_$DATA+0x200,%ebx
lea (%rbx,%r8,4),%ebx
lea (%r9,%r9,2),%r9d
lea (%r9,%r9,4),%r9d
shl $7,%r9d
add %r9d,%ebx
mov %ecx,%esi
@_rect_X1
mov %eax,%edi
@_rect_X2
mov %edx,-4(%rbx,%rdi,4)
dec %edi
jne @_rect_X2
add $1920,%ebx
dec %esi
jne @_rect_X1
pop %r9
pop %rdi
pop %rsi
pop %rbx
ret

@icons_array
.byte 0,0,0
.byte 0,0,0
.byte 0,0,0
.byte 0,0,0
.byte 0,0,0

.byte 0,0,1
.byte 0,0,1
.byte 0,0,1
.byte 0,0,1
.byte 0,0,1

.byte 1,1,1
.byte 0,0,1
.byte 1,1,1
.byte 1,0,0
.byte 1,1,1

.byte 1,1,1
.byte 0,0,1
.byte 1,1,1
.byte 0,0,1
.byte 1,1,1

.byte 1,0,1
.byte 1,0,1
.byte 1,1,1
.byte 0,0,1
.byte 0,0,1

.byte 1,1,1
.byte 1,0,0
.byte 1,1,1
.byte 0,0,1
.byte 1,1,1

.byte 1,1,1
.byte 1,0,0
.byte 1,1,1
.byte 1,0,1
.byte 1,1,1

.byte 1,1,1
.byte 0,0,1
.byte 0,0,1
.byte 0,0,1
.byte 0,0,1

.byte 1,1,1
.byte 1,0,1
.byte 1,1,1
.byte 1,0,1
.byte 1,1,1

@color_array
.long 0,0x00ff00,0x0000ff,0xff00ff,0x00ffff,0xff0000,0xffff00,0x800080,0xffffff

@p_block
push %rax
push %rcx
push %rdx
push %rbx
push %r8
push %r9
push %rsi
lea (%rax,%rax,2),%eax
lea (%rcx,%rcx,2),%ecx
lea (%rax,%rax,4),%eax
lea (%rcx,%rcx,4),%ecx
shl $1,%eax
shl $1,%ecx
mov %edx,%ebx
mov $30,%r8d
mov $30,%r9d

xchg %r8d,%eax
xchg %r9d,%ecx
mov $0x505050,%edx
call @rect
cmp $9,%bl
jb @_p_block_X1

inc %r8d
inc %r9d
mov $28,%eax
mov %eax,%ecx
mov $0xb0b0b0,%edx
call @rect

test $1,%bl
jne @_p_block_X2
add $4,%r8d
add $4,%r9d
mov $20,%eax
mov %eax,%ecx
mov $0xff0000,%edx
call @rect

jmp @_p_block_X2
@_p_block_X1
inc %r8d
inc %r9d
mov $28,%eax
mov %eax,%ecx
mov $0x0,%edx
call @rect
mov $@color_array,%edx
mov (%rdx,%rbx,4),%edx
inc %r9d
add $6,%r8d
lea (%rbx,%rbx,2),%esi
lea (%rsi,%rsi,4),%esi
add $@icons_array,%esi
mov $5,%eax
mov %eax,%ecx
mov $5,%bh
@_p_block_X1_Y1
mov $3,%bl
@_p_block_X1_Y2
cmpb $0,(%rsi)
je @_p_block_X1_Y3
call @rect
@_p_block_X1_Y3
add $5,%r8d
inc %esi
dec %bl
jne @_p_block_X1_Y2
sub $15,%r8d
add $5,%r9d
dec %bh
jne @_p_block_X1_Y1

@_p_block_X2

pop %rsi
pop %r9
pop %r8
pop %rbx
pop %rdx
pop %rcx
pop %rax
ret

@P1
push %rbp
mov %rsp,%rbp
and $0xf0,%spl
mov @_$DATA+0x90,%rcx
mov $921600,%edx
mov $@_$DATA+0x200,%r8
push %rcx
push %r8
push %rdx
push %rcx
.dllcall "gdi32.dll" "SetBitmapBits"
add $32,%rsp
mov @_$DATA+0x80,%rcx
xor %edx,%edx
xor %r8d,%r8d
mov $480,%r9d
push %rdx
pushq $0x00cc0020
push %rdx
push %rdx
pushq @_$DATA+0x88
push %r9
push %r9
push %r8
push %rdx
push %rcx
.dllcall "gdi32.dll" "BitBlt"

mov %rbp,%rsp
pop %rbp
ret

@paint_all
push %rax
push %rcx
push %rdx
push %r8
push %r9
push %r10
push %r11
mov $@_$DATA+0x100,%r8d
xor %ecx,%ecx
@_paint_all_X1
xor %eax,%eax
@_paint_all_X2
mov (%r8),%dl
and $0xf,%edx
call @p_block
inc %r8d
inc %eax
cmp $16,%eax
jb @_paint_all_X2
inc %ecx
cmp $16,%ecx
jb @_paint_all_X1

call @P1

pop %r11
pop %r10
pop %r9
pop %r8
pop %rdx
pop %rcx
pop %rax
ret

@init_mines
push %rbp
mov %rsp,%rbp
and $0xf0,%spl
push %rax
push %rcx
push %rdx
push %rbx
push %r8
push %r9
push %r10
push %r11
push %rsi
push %rdi
mov %eax,%esi
mov %ecx,%edi
xor %ecx,%ecx
push %rcx
push %rcx
.dllcall "msvcrt.dll" "time"
mov %rax,%rcx
mov %rax,(%rsp)
.dllcall "msvcrt.dll" "srand"
add $16,%rsp
mov $50,%ebx
@_init_mines_X1
.dllcall "msvcrt.dll" "rand"
movzbl %al,%eax
testb $0x10,@_$DATA+0x100(%rax)
jne @_init_mines_X1
mov %al,%cl
mov %al,%dl
shr $4,%dl
and $0xf,%cl
sub %sil,%cl
sub %dil,%dl
inc %cl
inc %dl
cmp $3,%cl
jae @_init_mines_X2
cmp $3,%dl
jb @_init_mines_X1
@_init_mines_X2
orb $0x10,@_$DATA+0x100(%rax)
dec %ebx
jne @_init_mines_X1

pop %rdi
pop %rsi
pop %r11
pop %r10
pop %r9
pop %r8
pop %rbx
pop %rdx
pop %rcx
pop %rax
mov %rbp,%rsp
pop %rbp
ret

@init_map
mov $256,%eax
@_init_map_X1
movb $9,@_$DATA+0xff(%rax)
dec %eax
jne @_init_map_X1
ret

@exit
push %rcx
push %rcx
.dllcall "msvcrt.dll" "exit"

@game_over_msg
.string "Game Over"
@game_over_win_msg
.string "You Win"

@game_over
movb $1,@_$DATA+0xe1200
and $0xf0,%spl
xor %r9d,%r9d
mov $@game_over_msg,%r8d
mov %r8d,%edx
mov %r9d,%ecx
.dllcall "user32.dll" "MessageBoxA"

mov $1,%ecx
jmp @exit

@game_over_win
movb $1,@_$DATA+0xe1200
and $0xf0,%spl
xor %r9d,%r9d
mov $@game_over_msg,%r8d
mov $@game_over_win_msg,%rdx
mov %r9d,%ecx
.dllcall "user32.dll" "MessageBoxA"

xor %ecx,%ecx
jmp @exit

@check_if_win
mov $256,%eax
@_check_if_win_X1
mov @_$DATA+0xff(%rax),%cl
test $0x10,%cl
jne @_check_if_win_X2
cmp $9,%cl
jae @check_if_win_END
@_check_if_win_X2
dec %eax
jne @_check_if_win_X1
jmp @game_over_win
@check_if_win_END
ret

@test_mine
cmp $16,%eax
jae @test_mine_X1
cmp $16,%ecx
jae @test_mine_X1
testb $0x10,@_$DATA+0x100(%r8)
je @test_mine_X1
inc %dl
@test_mine_X1
ret

@lclick
push %rax
push %rcx
push %r8
cmp $16,%eax
jae @_lclick_END
cmp $16,%ecx
jae @_lclick_END
testb $1,@_$DATA+0xa0
jne @_lclick_X1
call @init_mines
movb $1,@_$DATA+0xa0
@_lclick_X1
mov %ecx,%r8d
shl $4,%r8d
or %eax,%r8d
cmpb $9,@_$DATA+0x100(%r8)
jb @_lclick_END
testb $0x10,@_$DATA+0x100(%r8)
jne @game_over
sub $17,%r8d
dec %eax
dec %ecx
mov $0,%dl

call @test_mine
inc %eax
inc %r8d
call @test_mine
inc %eax
inc %r8d
call @test_mine
inc %ecx
add $16,%r8d
call @test_mine
inc %ecx
add $16,%r8d
call @test_mine
dec %eax
dec %r8d
call @test_mine
dec %eax
dec %r8d
call @test_mine
dec %ecx
sub $16,%r8d
call @test_mine
inc %r8d
mov %dl,@_$DATA+0x100(%r8)
test %dl,%dl
jne @_lclick_END
call @lclick
dec %ecx
call @lclick
inc %eax
call @lclick
inc %eax
call @lclick
inc %ecx
call @lclick
inc %ecx
call @lclick
dec %eax
call @lclick
dec %eax
call @lclick
@_lclick_END
pop %r8
pop %rcx
pop %rax
ret

@rclick
mov %ecx,%r8d
shl $4,%r8d
or %eax,%r8d
mov @_$DATA+0x100(%r8),%al
mov %al,%ah
and $0xf,%ah
cmp $9,%ah
jb @_rclick_END
xor $0x3,%al
mov %al,@_$DATA+0x100(%r8)
@_rclick_END
ret

@WndProc
push %rbx
push %rbp
mov %rsp,%rbp
and $0xf0,%spl
cmp $2,%edx
jne @WndProc_DESTROY
xor %ecx,%ecx
push %rcx
push %rcx
.dllcall "msvcrt.dll" "exit"
@WndProc_DESTROY
cmp $0xf,%edx
jne @WndProc_PAINT
sub $96,%rsp
push %r9
push %r8
push %rdx
push %rcx
lea 32(%rsp),%rdx
.dllcall "user32.dll" "BeginPaint"
call @paint_all
mov (%rsp),%rcx
mov 8(%rsp),%rdx
.dllcall "user32.dll" "EndPaint"
pop %rcx
pop %rdx
pop %r8
pop %r9
add $96,%rsp
jmp @WndProc_END
@WndProc_PAINT
cmp $0x202,%edx
jne @WndProc_LBUTTONUP
testb $1,@_$DATA+0xe1200
jne @WndProc_LBUTTONUP
movzwl %r9w,%eax
mov %r9d,%ecx
shr $16,%ecx
xor %edx,%edx
mov $30,%ebx
div %ebx
xchg %eax,%ecx
xor %edx,%edx
mov $30,%ebx
div %ebx
xchg %eax,%ecx
call @lclick
call @paint_all
call @check_if_win
jmp @WndProc_END
@WndProc_LBUTTONUP

cmp $0x205,%edx
jne @WndProc_RBUTTONUP
testb $1,@_$DATA+0xe1200
jne @WndProc_RBUTTONUP
movzwl %r9w,%eax
mov %r9d,%ecx
shr $16,%ecx
xor %edx,%edx
mov $30,%ebx
div %ebx
xchg %eax,%ecx
xor %edx,%edx
mov $30,%ebx
div %ebx
xchg %eax,%ecx
call @rclick
call @paint_all

jmp @WndProc_END
@WndProc_RBUTTONUP
push %r9
push %r8
push %rdx
push %rcx
.dllcall "user32.dll" "DefWindowProcA"
jmp @WndProc_END2
@WndProc_END
xor %eax,%eax
@WndProc_END2
mov %rbp,%rsp
pop %rbp
pop %rbx
ret

.entry
push %rbp
mov %rsp,%rbp
and $0xf0,%spl
movl $0x50,@_$DATA+0
movl $@WndProc,@_$DATA+0+8
movl $@WCname,@_$DATA+0+0x40
movl $0x400000,@_$DATA+0+0x18
movl $8,@_$DATA+0+0x30

mov $0x7f00,%edx
xor %ecx,%ecx
push %rdx
push %rcx
.dllcall "user32.dll" "LoadCursorA"
add $16,%rsp
mov %rax,@_$DATA+0+0x28

mov $0x7f00,%edx
xor %ecx,%ecx
push %rdx
push %rcx
.dllcall "user32.dll" "LoadIconA"
add $16,%rsp
mov %rax,@_$DATA+0+0x20

mov $@_$DATA+0,%ecx
push %rcx
push %rcx
.dllcall "user32.dll" "RegisterClassExA"
add $16,%rsp
test %rax,%rax
je @END

mov $0x100,%ecx
mov $@WCname,%edx
mov $@WinName,%r8d
mov $0x10c80000,%r9d
xor %eax,%eax
push %rax
pushq $0x400000
push %rax
push %rax
pushq $480+29
pushq $480+6
push %rax
push %rax
push %r9
push %r8
push %rdx
push %rcx
.dllcall "user32.dll" "CreateWindowExA"
add $96,%rsp
test %rax,%rax
je @END

mov %rax,%rcx
push %rcx
push %rcx
.dllcall "user32.dll" "GetDC"
add $16,%rsp
test %rax,%rax
je @END
mov %rax,@_$DATA+0x80
mov %rax,%rcx
mov %rax,%rbx
push %rcx
push %rcx
.dllcall "gdi32.dll" "CreateCompatibleDC"
add $16,%rsp
test %rax,%rax
je @END
mov %rax,@_$DATA+0x88
mov %rbx,%rcx
mov %rax,%rbx
mov $480,%rdx
mov %rdx,%r8
push %r8
push %r8
push %rdx
push %rcx
.dllcall "gdi32.dll" "CreateCompatibleBitmap"
add $32,%rbp
test %rax,%rax
je @END
mov %rax,@_$DATA+0x90
mov %rbx,%rcx
mov %rax,%rdx
push %rdx
push %rcx
.dllcall "gdi32.dll" "SelectObject"
add $16,%rsp

call @init_map

@MsgLoop
mov $@_$DATA+0x50,%ecx
xor %edx,%edx
xor %r8d,%r8d
xor %r9d,%r9d
push %r9
push %r8
push %rdx
push %rcx
.dllcall "user32.dll" "GetMessageA"
add $32,%rsp
cmp $0,%rax
jl @END_X1

push %rax
mov $@_$DATA+0x50,%ecx
push %rcx
.dllcall "user32.dll" "TranslateMessage"
add $16,%rsp
push %rax
mov $@_$DATA+0x50,%ecx
push %rcx
.dllcall "user32.dll" "DispatchMessageA"
add $16,%rsp

jmp @MsgLoop
@END_X1
mov @_$DATA+0x50+12,%eax
@END
mov %rbp,%rsp
pop %rbp
ret
.datasize 922368
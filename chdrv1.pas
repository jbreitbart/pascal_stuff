program CHdrv1;

uses dos,alles;

{S-}
var old40 : pointer;

procedure newint40; assembler;
 asm
 xor DL,1
 jmp Far Ptr old40
end;

begin
 old40:=ptr(Seg(newint40),ofs(newint40)+4);
 getintvec($40,pointer(old40^));
 setintvec ($40,@Newint40);
 keepx(0,@keepx);
end.
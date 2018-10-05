uses alles,crt;

var zu : File;
    von : File of byte;
    lv1 : Laufvar;
    ar : array [1..2048] of byte;

begin
 assign(zu,'test.a');
 rewrite(zu,1);
 assign(von,'arty.exe');
 reset(von);
 repeat
  lv1:=1;
  repeat
   read(von,ar[lv1]);
   lv1:=lv1+1;
  until (eof(von)) or (lv1=2049);
  blockwrite(zu,ar,lv1-1);
 until eof(von);
 close(zu);
 close(von);
end.
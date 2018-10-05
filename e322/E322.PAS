program eumex322;

uses dos,crt;

const hex_nib : string='0123456789ABCDEF';
      e322swv = 1400+1;   { Software-Version *1000 +1 }
      e322id = #1#0#0#0#0+chr(lo(e322swv))+chr(hi(e322swv));

var f : text;
    debug : boolean;
    i,p,e,lsr,pa,snum,snumn : integer;
    fn,op,opt,passw : string;
    dt : char;
    irq : byte;

    r_buffer : array[0..4095] of char;  { RS232 input buffer }
    bp,    { r_buffer: 1. Byte }
    bl,    { #Bytes in r_buffer }
    bls,   { start of last (open) string in r_buffer }
    lsl,   { length of last string }
    fsl,   { length of first string }
    ls_lo, { last string length pointers }
    ls_hi,
    lb1,   { last 2 bytes in buffer }
    lb2,
    bns,   { number of strings in r_buffer }
    atn    { number of atn (#2) signals }
        :integer;
    si,    { shift in (#6) }
    os     { string open }
        :boolean;
    r_crc : longint;


procedure init;
begin
  snum  := 0;
  snumn := 0;
  bp    := 0;
  bl    := 0;
  bls   := 0;
  lsl   := 0;
  fsl   := 0;
  bns   := 0;
  atn   := 0;
  si    := false;
  os    := false;
  p     := 1;
  dt    := 'K';
  passw := '0000';
  debug := false;
end;

procedure error(txt:string);
begin
  write(#7);
  writeln(txt);
  halt;
end;

function hex(v:byte):string;
begin
  hex := hex_nib[1+(v div 16)]+hex_nib[1+(v and 15)];
end;

function buf_put(b:char):integer;
var be:integer;
begin
  if bl>4090
    then error('PufferÅberlauf');
  be := (bp+bl) and 4095;
  r_buffer[be] := b;
  inc(bl);
  buf_put := be;
end;

function buf_get:char;
begin
  dec(bl);
  buf_get := r_buffer[(bp)];
  bp := (bp+1) and 4095;
end;

procedure buf_clr;
begin
  if fsl>0 then
    begin
      dec(bl,fsl);
      bp := (bp+fsl) and 4095;
      fsl := 0;
    end;  
end;

{$I RS232.INC}

procedure crc(var c:longint;v:integer);
var j: integer;
    t : boolean;
begin
  c := c xor (longint(v) shl 8) xor $e1f3;
  for j:= 7 downto 0 do
    begin
      t := c>=$8000;
      c := (c and $7fff) shl 1;
      if t then c := c xor $1021;
    end;
end;

procedure look_com;
var t : char;
    dummy : integer;
begin
  lsr := port[pa+5];
  if keypressed
    then if readkey=#27 then error('** Abbruch ** ');
  while lsr and 1 > 0 do
    begin
      t := chr(port[pa]);
      if lsr and 14 > 0 then
        begin
          write('öbertragungsfehler: ');
          if lsr and 2 > 0 then write('<OVERRUN>');
          if lsr and 4 > 0 then write('<PARITY>');
          if lsr and 8 > 0 then write('<FRAME>');
          writeln;
        end;
      if t=#2
        then
          begin
            inc(atn);
            if not os
              then begin
                     os := true;
                     ls_lo := buf_put(#0);
                     ls_hi := buf_put(#0);
                   end
              else begin
                     dec(bl,lsl+2);
                   end;
            lsl := -2;
            r_crc := 0;
          end
        else
          if os
            then
              begin
                if t=#3
                  then begin
                         os := false;
                         atn := 0;
                         if (lsl>0) and (lo(r_crc)=lb1)
                                    and (hi(r_crc)=lb2)
                           then
                             begin
                               inc(bns);
                               r_buffer[ls_lo] := chr(lo(lsl));
                               r_buffer[ls_hi] := chr(hi(lsl));
                             end
                           else
                             begin
                               write(' CRC-Fehler! ');
                               writeln(hex(hi(r_crc)),hex(lo(r_crc)),'-',
                                  hex(lb2),hex(lb1));
                             end;
                       end
                  else if (not si) and (t=#6) then si := true
                  else
                    begin
                      if si
                        then begin
                               if t<>#6 then dec(t,2);
                               si := false;
                             end;
                      inc(lsl);
                      if lsl>0 then
                        begin
                          crc(r_crc,lb1);
                          dummy := buf_put(chr(lb1));
                        end;
                      lb1 := lb2;
                      lb2 := ord(t);
                    end;
              end;
      lsr := port[pa+5];
    end;
end;

{
procedure com_req(Flags,CS,IP,AX,BX,CX,DX,SI,DI,DS,ES,BP:word); interrupt;
begin
  write('#');
  look_com;
end;
}

procedure xwrite(s:string);
var l : integer;
    c : char;
begin
 for l:= 1 to length(s) do
   begin
     look_com;
     c := s[l];
     if c in [' '..'Z','a'..'z']
       then write(c)
       else write('[',hex(ord(c)),']');
   end;
end;

procedure xwriteln(s:string);
begin
  xwrite(s);
  writeln;
end;

procedure send_byte(c:char);
begin
  repeat
    look_com;
  until lsr and 32 > 0;
  com_write(p,c);
end;

procedure send_coded(c:char);
begin
  if c in [#2,#3,#6] then
    begin
      send_byte(#6);
      if c<>#6 then inc(c,2);
    end;
  send_byte(c);
end;

procedure send_string(s:string);
var i:integer;
    w_crc : longint;
    c : char;
begin
  w_crc := 0;
  if debug then
    begin
      write(#30);
      xwriteln(s);
    end;
  send_byte(#2);
  for i:= 1 to length(s) do
    begin
      c := s[i];
      crc(w_crc,ord(c));
      send_coded(c);
    end;
  send_coded(chr(lo(w_crc)));
  send_coded(chr(hi(w_crc)));
  send_byte(#3);
end;

procedure wait_str;
var cts : boolean;
begin
  if fsl>0 then buf_clr;
  repeat
    look_com;
    cts := com_cts(p);
  until (bns>0) or (not cts);
  if cts
    then
      begin
        dec(bns);
        fsl := ord(buf_get);
        fsl := fsl + (ord(buf_get) shl 8);
      end
    else fsl := 0;    
end;

function get_string(n:integer):string;
var i:integer;
    h:string;
begin
  if n>fsl then n:=fsl;
  h := '';
  for i:=1 to n do
    begin
      h := h+buf_get;
      look_com;
    end;
  if debug then
    begin
      write(#31'(',fsl,')');
      xwriteln(h);
    end;
  dec(fsl,n);
  get_string := h;
end;

procedure caps(var t:string);
var l : integer;
begin
  for l:=1 to length(t) do
    t[l] := upcase(t[l]);
end;

procedure send_instruction(s:string);
var rstr : string;
begin
  send_string(chr(64+snumn)+chr(64+snumn)+#1+s+#0);
  wait_str;
  snum := snumn;
  snumn := (snumn+1) and 63;
  rstr := get_string(2);
  if rstr<>#$80+chr(snumn+64)
    then xwriteln(' Kommando ('+s+') nicht akzeptiert!');
end;

procedure send_answer(s:string);
var rstr : string;
begin
  send_string(chr(64+snum)+chr(snumn)+#1+s+#0);
  wait_str;
  rstr := get_string(2);
  if rstr<>#$80+chr(snumn)
    then xwriteln(' Daten ('+s+') nicht akzeptiert!');
end;

procedure send_snum;
begin
  snum := snumn;
  snumn := (snumn+1) and 63;
  send_string(#$80+chr(snumn+64));
end;

procedure send_ok;
begin
  send_string(#$80+chr(snumn));
end;

{---------------------------------------------------------}


procedure emulate;
var sl,stat : integer;
    rstr,istr,wstr,pstr : string;

begin
  com_baud(p,19200);
  com_bits(p,8,1);
  com_parity(p,'n');
  writeln('Eumex 322 Emulation');
  snum := 0;
  snumn := 0;
  stat := 0;
  repeat
    if (stat=0) or (atn>2) then
      begin
        repeat
          look_com;
        until atn>2;
        writeln('ATN empfangen');
        send_byte(#2);
        stat := 1;
      end;

    wait_str;
    rstr := get_string(3);
    if rstr='' then
      begin
        if stat=10 then close(f);
        stat:=-1;
        writeln('Verbindung abgebaut');
      end;

    if (stat>0) and (rstr=#$c0) then
      begin
        stat := 2;
        writeln('Verbindungsaufbau');
        send_string(#$c3);
        snum := 0;
        snumn := 0;
      end;

    istr := chr(snumn+64)+chr(snumn+64);

    if (stat>=2) and (rstr=istr+#2) then
      begin
        send_snum;
        writeln('sende Anlagen-ID');
        rstr := get_string(1);
        send_string(chr(64+snum)+chr(snumn)+#2+succ(rstr[1])+e322id+#0);
        wait_str;
        rstr := get_string(2);
        if rstr<>#$80+chr(snumn)
          then begin
                 writeln(' Kennung nicht akzeptiert!');
                 stat := 1;
               end
          else begin
                 stat := 0;
                 writeln('4800 Baud');
                 com_baud(p,4800);
               end;
      end;

    if (stat>=2) and (rstr = istr+#1) then
      begin
        send_snum;
        rstr := get_string(4);
        if rstr='LI G' then
          begin
            rstr := get_string(2);
            writeln('Code: ',get_string(4));
            send_answer('LI 1'#0#0);
          end
        else if (rstr='DK G') or (rstr='DA G') or (rstr='GB G') or (rstr=#0)
          then begin
                 if stat<5 then
                   begin
                     stat := 5;
                     reset(f);
                     writeln('Sende Daten');
                   end;
                 if (not eof(f)) and (stat=5)
                   then readln(f,wstr)
                   else begin
                          wstr:='ZZ';
                          close(f);
                          writeln;
                          writeln('öbertragung abgeschlossen.');
                          stat := -1;
                        end;
                 if stat>0 then write('.');
                 send_answer(wstr);
               end
        else begin
               if stat<10 then
                 begin
                   if stat=5 then close(f);
                   writeln('Empfange Daten');
                   rewrite(f);
                   stat := 10;
                 end;
               pstr := get_string(255);
               sl := length(pstr);
               if sl=255 then writeln('String zu lang!');
               if copy(pstr,sl,1)<>#0
                 then writeln('Stringende nicht erkannt!')
                 else delete(pstr,sl,1);
               if sl>1 then
                 begin
                   if pstr[sl-1] = #10 then delete(pstr,sl-1,1);
                   if copy(rstr,3,2) = ' A'
                     then writeln(f,copy(rstr,1,2),pstr)
                     else writeln(f,rstr,pstr);
                   xwriteln(rstr+pstr);
                   send_answer('');
                 end;
             end;
      end;
    if rstr = #$80+chr(snumn+$c0)
      then writeln('letzter Datensatz wurde fehlerhaft Åbertragen!');
  until stat<0;
end;

function c_eumex:boolean;
var cnt,stat : integer;
    rstr : string;
begin
  com_baud(p,4800);
  com_bits(p,8,1);
  com_parity(p,'n');
  com_rts(p,false);
  write('Verbindungsaufbau 4800 Baud');
  atn := 0;
  delay(2000);
  com_rts(p,true);
  delay(100);
  cnt := 0;
  stat := 0;
  repeat
    send_byte(#2);
    write('.');
    delay(20);
    look_com;
    inc(cnt);
    if atn>0 then stat:=1;
  until (stat>0) or (cnt>30);
  if stat>0 then
    begin
      writeln(' OK!');
      send_string(#$c0);
      wait_str;
      rstr := get_string(250);
      if rstr=#$c3
        then stat := 2;
    end;
  if stat>1 then
    begin
      snum := 0;
      snumn := 0;
      writeln('Sende Code');
      send_instruction('LI G a'+passw);
      wait_str;
      if get_string(3)=chr(snum+64)+chr(snumn)+#1 then
        begin
          send_ok;
          if get_string(4)='LI 1'
            then stat := 5
            else writeln('Code ',passw,' nicht akzeptiert!');
        end;
    end;
  if stat<5 then
      begin
        writeln(' keine Verbindung!');
        c_eumex := false;
      end;
end;

procedure r_eumex(dt:char);
var wstr,rstr : string;
    stat : integer;
begin
  writeln('Empfange Anlagendaten');
  wstr := '';
  stat := 0;
  if c_eumex
    then
      begin
        case dt of
         'K' : wstr := 'DA G';
         'W' : wstr := 'DK G';
         'G' : wstr := 'GB G';
        end;
        rewrite(f);
        writeln('Lese Daten:');
        send_instruction(wstr+#32#10);
        repeat
          wait_str;
          rstr := get_string(3);
          if rstr=chr(snum+64)+chr(snumn)+#1
            then begin
                   rstr := get_string(250);
                   if rstr <> 'ZZ'#0
                     then writeln(f,copy(rstr,1,length(rstr)-1))
                     else stat := -1;
                   xwriteln(rstr);
                   send_ok;
                   if stat>=0
                     then send_instruction('');
                 end
            else begin
                   writeln('öbertragungsfehler!');
                   stat := -10;
                 end;
        until stat<0;
        close(f);
        if stat = -1
          then writeln('Daten korrekt gelesen.');
      end;
end;

procedure w_eumex;
var wstr,rstr : string;
    stat : integer;
begin
  writeln('Sende Daten zur Anlage');
  wstr := '';
  stat := 0;
  reset(f);
  if c_eumex then
    begin
      writeln('sende Daten');
      while (not eof(f)) and (stat>=0) do
        begin
          readln(f,wstr);
          write('.');
          if copy(wstr,3,2)<>' L'
            then wstr := copy(wstr,1,2)+' A'+copy(wstr,3,length(wstr)-2);
          send_instruction(wstr);
          wait_str;
          rstr := get_string(5);
          if rstr<>chr(snum+64)+chr(snumn)+#1#0
            then xwriteln('Kommando '+wstr+' nicht akzeptiert!')
            else send_ok;
        end;
    end;
  close(f);
  writeln('öbertragung abgeschlossen.');
end;


begin
  if not (paramcount in [2..6]) then
    begin
      writeln('Eumex 322 Konfiguration V0.5 (c) H.GrÑfe 1/2000');
      writeln('Info: http://home.t-online.de/home/h.graefe');
      writeln;
      writeln('Syntax: E322 <Operation> [K|W|G] [-c#] [-p####] [-d] <Filename>');
      writeln;
      writeln(' <Operation> = S(chreibe)  - Daten in die TK-Anlage');
      writeln('               L(ese)      - Daten von der TK-Anlage');
      writeln('               E(mulation) - einer TK-Anlage');
      writeln('             Optionen fÅr Lesen: ');
      writeln('      K      = Konfiguration');
      writeln('      W      = Kurzwahlen');
      writeln('      G      = GebÅhren');
      writeln('             allgemeine Optionen:');
      writeln('      -cn    = Com-Port n (z.B. -c2), Default: 1');
      writeln('      -p#### = Codewort ####, Default: 0000');
      writeln('      -d     = Debug-Modus');
      error('');
    end;
  writeln;
  init;
  fn := paramstr(paramcount);
  for i:= 2 to paramcount-1 do
    begin
      opt := paramstr(i);
      caps(opt);
      if (copy(opt,1,1) = '-') and (length(opt)>1)
        then
          begin
            case opt[2] of
              'C' : val(copy(opt,3,1),p,e);
              'P' : passw := copy(opt,3,4);
              'D' : debug := true;
              else writeln('Option ',opt,' ungueltig!');
            end;
          end
        else if opt[1] in ['K','W','G']
               then dt := opt[1]
               else writeln('Auswahl ',opt,' ungueltig!');
    end;
  pa := com_adr(p);

{ disable serial port irq: }
  irq := port[pa+1];
  port[pa+1] := irq and $f0;

  op := paramstr(1);
  caps(op);
  assign(f,fn);
  lsr := port[pa+5];  { clear Port }
  if op=copy('EMULATION',1,length(op)) then emulate;
  if op=copy('LESE',1,length(op)) then r_eumex(dt);
  if op=copy('SCHREIBE',1,length(op)) then w_eumex;
  com_rts(p,false);

{ re-enable serial port irq: }
  port[pa+1] := irq;

  writeln;
end.

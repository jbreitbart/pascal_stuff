uses alles,crt;

type nachricht = record
                  wann : Word;
                  na : array [1..12] of string[40];
                 end;

var f : File of Nachricht;
    n : nachricht;

begin
 assign(f,'c:\pascal\data\Erde.nac');
 rewrite(f);
 n.wann:=3;
 n.na[1]:='';
 n.na[2]:='';
 n.na[3]:='';
 n.na[4]:='Versorgungsfrachter "Hemington Home"';
 n.na[5]:='ist gestern im Orionsystem verschollen.';
 n.na[6]:='Er transportierte Waffen zum Planeten';
 n.na[7]:='XF 427, noch ist unklar, ob es die';
 n.na[8]:='Terrorgruppe Freie Planeten gewesen ';
 n.na[9]:='ist. Wir halten sie am laufenden.';
 n.na[10]:='';
 n.na[11]:='';
 n.na[12]:='';
 write(f,n);
 close(f);
end.
 n.wann:=
 n.na[1]:=
 n.na[2]:=
 n.na[3]:=
 n.na[4]:=
 n.na[5]:=
 n.na[6]:=
 n.na[7]:=
 n.na[8]:=
 n.na[9]:=
 n.na[10]:=
 n.na[11]:=
 n.na[12]:=
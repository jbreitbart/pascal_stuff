uses alles,crt,graph;

type TRasse    = (Erdallianz,Schatten,Vorlonen,Mimbari,Naren,Zentauri,keine);
     TStimmung = (wutend,freundlich,neutral);
     TKlasse   = 1..10;
     TFracht   = (Geld,Menschen,Dilizium,gold,nuscht);
     TBevolk   = Record
                  Anzahl : Longint;
                  Stimmung : TStimmung;
                 end;
     TUrbevolk = record
                  janein   : Boolean;
                  Anzahl   : Longint;
                  Stimmung : TStimmung;
                 end;
     TNahrung  = record
                  wieviel     : Longint;
                  Nachwachsen : 0..20;
                 end;
     TJager    = record
                  Klasse    : TKlasse;
                  beschadig : 0..100;
                 end;
     TMineral  = record
                  anzahl : Longint;
                 end;
     TShip     = record
                  Antrieb    : TKlasse;
                  maxwaffen  : 0..20;
                  anzwaffen  : 0..20;
                  waffen     : array [0..20] of TKlasse;
                  maxfracht  : 0..150;
                  anzfracht  : 0..150;
                  Frachtraum : array [0..150] of TFracht;
                  beschadigt : 0..100;
                 end;
     TRaumst   = record
                  janein     : Boolean;
                  anzJa      : 0..100;
                  Jager      : array [0..100] of TJager;
                  anzWaf     : 0..30;
                  Waffen     : array [0..30] of TKlasse;
                  janeinbau  : Boolean;
                  bauen      : TShip;
                  beschadigt : 0..100;
                 end;
     TPlanet   = record
                  X,Y         : Word;
                  Rasse       : TRasse;
                  Urbevolk    : TUrbevolk;
                  Bevolk      : TBevolk;
                  Nahrung     : TNahrung;
                  Steuern     : 0..40;
                  Dilizium    : TMineral;
                  Gold        : TMineral;
                  Raumstation : TRaumst;
                 end;

var Planet : TPlanet;
    Datei  : file of TPlanet;
    lv1,lv2 : Laufvar;

begin
 lv1:=0;
 assign(datei,'C:\pascal\babylon\karte');
 rewrite(datei);
 grd:=detect;
 initgraph(grd,grm,'');
 Randomize;
 repeat
  planet.rasse:=keine;
  planet.x:=Random(640);
  planet.y:=Random(480);
  planet.urbevolk.janein:=zufallbuh;
  if planet.urbevolk.janein= true then begin
   planet.urbevolk.anzahl:=Random(65000);
   planet.urbevolk.stimmung:=neutral;
  end;
  planet.bevolk.anzahl:=0;
  planet.bevolk.stimmung:=neutral;
  planet.nahrung.wieviel:=1;
  planet.nahrung.nachwachsen:=Random(19);
  planet.steuern:=0;
  planet.dilizium.anzahl:=RANDOM(65000);
  planet.gold.anzahl:=Random(65000);
  planet.raumstation.janein:=false;
  planet.raumstation.anzja:=0;
  for lv2:=0 to 100 DO begin
   planet.raumstation.jager[lv2].klasse:=1;
   planet.raumstation.jager[lv2].beschadig:=0;
  end;
  planet.raumstation.anzwaf:=0;
  for lv2:=0 to 30 DO planet.raumstation.waffen[lv2]:=1;
  planet.raumstation.janeinbau:=false;
  planet.raumstation.bauen.antrieb:=1;
  planet.raumstation.bauen.maxwaffen:=0;
  planet.raumstation.bauen.anzwaffen:=0;
  for lv2:=0 to 20 DO planet.raumstation.bauen.waffen[lv2]:=1;
  planet.raumstation.bauen.maxfracht:=0;
  planet.raumstation.bauen.anzfracht:=0;
  for lv2:=0 to 150 DO planet.raumstation.bauen.frachtraum[lv2]:=nuscht;
  planet.raumstation.bauen.beschadigt:=0;
  planet.raumstation.beschadigt:=0;
  putpixel(planet.x,planet.y,white);
  lv1:=lv1+1;
  write(datei,planet);
 until lv1=500;
 readln;
 close(datei);
end.
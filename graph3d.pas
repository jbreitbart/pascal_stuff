unit graph3d;

interface

uses graph;

const xd = 90; { =(Aspektfaktor-1)*x_Punktezahl/2 (Rand) }
      anz_pkte = 5;
      anz_linien =8;
      Delta = 0.06; {Winkeldifferenz}

type Vektor = array [1..3] of real;
     Objekt = record
               punkte : array [1..anz_pkte] of vektor;
               linien : array [1..Anz_linien] of record
                                                von,nach : 1..Anz_Pkte
                                               end;
              end;

var VX, VY :Vektor;
    smax,Faktx,fakty : Real;


Function Vektorprod (v,w : Vektor) : Real;
procedure parameter (a : Real; alpha,beta : Real);
procedure spq(x1,y1,x2,y2 : Integer); { Strecke von P( x1,y1) nach Q (x2,y2)}
procedure zeichne_Linie (v,w : Vektor);
procedure Zeichne_punkt (v:vektor; Punktgroesse : Real);

Implementation

Function Vektorprod (v,w : Vektor) : Real;

begin
 vektorprod := v[1]*w[1]+v[2]*w[2]+v[3]*w[3];
end;

procedure parameter (a : Real; alpha,beta : Real);

begin
 smax :=a;
 faktx:= (getmaxx-2*xd)/(Smax*2.0);
 fakty:= getmaxy/(Smax*2.0);
 vx[1]:=cos(alpha);
 vx[2]:=-sin(alpha);
 vx[3]:=0.0;
 vy[1]:=sin(alpha)*cos(beta);
 vy[2]:=cos(alpha)*cos(beta);
 vy[3]:=sin(beta);
end;

procedure spq(x1,y1,x2,y2 : Integer);
begin
 line (x1-1,getmaxy-y1,x2-1,getmaxy-y2);
end;

procedure zeichne_Linie (v,w : Vektor);

begin
 spq(trunc((Vektorprod(v,vx)+smax)*Faktx)+xd,
     trunc((Vektorprod(v,vy)+smax)*faktY),
     trunc((vektorprod(w,vx)+smax)*faktx)+xd,
     trunc((vektorprod(w,vy)+smax)*fakty));
end;

procedure Zeichne_punkt (v:vektor; Punktgroesse : Real);

var delta : Real;
    von,bis : Vektor;
    i : Integer;

begin
 delta :=smax*punktgroesse;
 for i:= 1 to 3 DO begin {3 kleine Linien zeichnen}
  von:=v;
  von[i]:=von[i]-delta;
  bis:=v;
  bis[i]:=bis[i]+delta;
  Zeichne_Linie (von,bis);
 end;
end;

procedure zeichne_achsen;

const skal =1.5; {max. 15 Teilstriche / Achsenabschn.}
      ln10 = 2.3025851; { =LN(10), wg dez. Einteilung}
      Nullvektor : Vektor = (0,0,0);

var punkt : Vektor;
    d,skalenteil : Real;
    i : Integer;

begin
 zeichne_punkt (Nullvektor,1.0); { = Achsenkreuz}
 skalenteil := exp (LN10*trunc(ln(smax/skal)/ln10));
 d:=skalenteil;
 repeat
  for i:=1 to 3 DO begin {Auf jeder Achse Einteilungen markieren}
   punkt := nullvektor;
   punkt[i]:=d;
   zeichne_punkt (punkt,0.01);
   punkt[i]:=-d;
   zeichne_punkt (punkt,0.01);
  end;
  d:=d+skalenteil;
 until d > smax;
end;

end.

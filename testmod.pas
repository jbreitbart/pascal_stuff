{$A-,B-,D+,E+,F-,G+,I+,L+,N-,O-,R+,S+,V+,X-}
{$M 16384,0,655360}
uses modplay;

var oK : Integer;

begin
 init_sb;
 ok:=lade_moddatei('d:\der0793\mm-data\tubells.mod',auto,auto);
 readln;
 ende_mod;
end.
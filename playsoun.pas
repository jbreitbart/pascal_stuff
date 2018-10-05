uses sbdrv,sbapi,crt;

begin
 playsnd('C:\sounds\test.snd',6400);
 repeat until (soundplaying=false) or (keypressed);
end.
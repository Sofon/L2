program SMO;

{$APPTYPE CONSOLE}
uses
  SysUtils;

const
 MaxState=20;
var
 X0       : LongInt;
 M        : word;
 a,b      : word;
 Ts       : array[0..MaxState] of double;
 T        : double;
 La,Tob   : double;
 MaxSt    : word;
 K,L      : word;
 N        : word;

Function Generate:double;
Begin
 X0:=(X0*a+b) mod M;
 Generate:=X0/M;
End;

Function Lambda(i,j:word):double;
Begin
 if (j=i+1) then Lambda:=La
 else begin
  if (j=i-1) then begin
   if (i<=K) then Lambda:=i/Tob
   else Lambda:=K/Tob;
  end
  else Lambda:=0;
 end;
End;

Procedure Main;
var
 No    : word;
 ct    : double;
 ctm   : double;
 ctj,j : word;
 St    : word;
Begin
 No:=0;
 St:=0;
 T:=0;
 while (No<=2000) do begin
  ctj:=0;
  ctm:=-1;
  for j:=0 to MaxSt do begin
   if (Lambda(St,j)>0) then begin
    ct:=(-1/Lambda(St,j))*ln(1-Generate);
    if ((ctm=-1) or (ct<ctm)) then begin
     ctj:=j;
     ctm:=ct;
    end;
   end;
  end;
  T:=T+ctm;
  Ts[St]:=Ts[St]+ctm;
  if (ctj<ST) then No:=No+1;
  St:=ctj;
  N:=N+1;
 end;
End;

Procedure Input;
Begin
 writeln;
 write('Chislo kanalov K=');
 readln(K);
 write('Dlina ocheredi L=');
 readln(L);
 write('Intensivnost potoka Lambda=');
 readln(La);
 write('Vremya obluzhivania Tob=');
 readln(Tob);
End;

Procedure Output;
var
 F     : text;
 j     : word;
 nsr   : real;
Begin
 nsr:=0;
 Assign(F,'lab2.txt');
 Rewrite(F);
 writeln(F,'Ishodnie dannie:');
 writeln(F,'Lambda=',La:5:3);
 writeln(F,'Vremya obsluzhivania=',Tob:5:3);
 writeln(F,'Chislo kanalov K=',K);
 writeln(F,'Dlina ocheredi L=',L);
 writeln(F);
 writeln(F,'Rezultati:');
 writeln(F,'Zayavok obrabotano: 2000');
 writeln(F,'Vsego vremeni zatracheno: ',T:7:5,' u.e.v.');
 writeln(F);
 writeln(F,'Veroyatnost nahozhdenia sistemi v razlichnih sostoyaniyah:');
 for j:=0 to MaxSt do begin
  writeln(F,'S',j,':  p',j,'=',(Ts[j]/T):6:4);
 end;
 writeln(F,'Veroyatnost otkaza: ', (Ts[MaxSt]/T):6:4);
 writeln(F,'Koeffitsient prostoya: ', (Ts[0]/T):6:4);
 writeln(F,'Koeffitsient zagruzki: ', (1 - (Ts[0]/T)):6:4);
 writeln(F,'Propusknaya sposobnost: ', La*(1 - (Ts[MaxSt]/T)):6:4);
 for j:=0 to MaxST do begin
  nsr:=nsr+j*(Ts[j]/T);
 end;
  writeln(F,'Srednee chislo zayavok: ', nsr:6:4);
 writeln(F,'Srednee chislo obsluzhivaushchihsya zayavok: ', nsr:6:4);
 close(F);
End;

BEGIN
 Randomize;
 M:=65413;
 a:=15605;
 b:=148;
 X0:=(RandSeed+13) mod M;
 Input;
 MaxSt:=K+L;
 Main;
 Output;
END.


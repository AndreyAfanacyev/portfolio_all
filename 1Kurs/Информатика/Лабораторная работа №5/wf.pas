Program Zadanye_2;
var N,M:integer;
function Fac(x:integer):integer;
var
i,f:integer;
begin
  f:=1;
 for i:=1 to x do
  begin
   f:=f*i;
  end;
Fac:=f;
end;
begin
  writeln('Введите N ');
  read(N);
  writeln ('Введите M (M<N) ');
  read(m);
  writeln('Кол-во сочетаний будет равно ',Fac(N)/(Fac(M)*Fac(N-M)));
end.
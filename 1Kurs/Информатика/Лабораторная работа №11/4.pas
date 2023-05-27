Program Zadanye_1;
Var
s,a,i:integer;
function fac(i:integer):integer;
Var
k,m:integer;
begin
m:=1;
for k:=1 to i do
  begin
  m:=m*k;
  end;
  fac:=m;
  Writeln('Одно из слагаемых ',m);
end;
begin
  Writeln('Введите A');
  Readln(A);
  i:=1;
  Repeat 
    s:=s+fac(i);
    i:=i+1;
  until s>=A;
  Writeln('Сумма равна ',s);
end.
Program Zadanye_1;
Var
x,n,c,i:integer;
sum,r:real;
function fac(f:integer):real;
Var
p:integer;
s:real;
begin
  s:=1;
  for p:=1 to f do
   begin
    s:=s*p;
    fac:=s;
   end;
end;
begin
  Writeln('Введите x'); Readln(x);
  Writeln('Введите n'); Readln(n);
  for i:=1 to n do
    begin
      c:=2*i+1;
      sum:=sum+(1/fac(i+1))*(exp(ln(x)*c)/c);
    end;
  r:=sum/(5.5+x*x+fac(3*n));
  Writeln ('Результат будет равен ', r:1:14);
end.

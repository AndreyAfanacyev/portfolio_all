Program Zadanye_1;
Var
a,b,h,s,x: real;
n: integer;
begin
  Writeln('Введите нижний предел интегрирования ');
  Readln(a);
  Writeln('Введите верхний предел интегрирования ');
  Readln(b);
  Writeln('Введите кол-во разбиений ');
  Readln(n);
  h:=(b-a)/n;
  Writeln(h);
  s:=0;
  x:=a;
    While x+h<=b do
      begin
        s:=s+(sqrt(x*x+5))/(2*x+sqrt(x*x+0.5));
        x:=x+h;
      end;
  s:=s*h;
  Writeln('Значение интеграла буде равно ', s);
end.
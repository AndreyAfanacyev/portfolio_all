Program Zadanye_2;
Var
a,b,h,s,x,sc,sn: real;
n: integer;
begin
  Writeln('Введите нижний предел интегрирования ');
  Readln(a);
  Writeln('Введите верхний предел интегрирования ');
  Readln(b);
  Writeln('Введите кол-во разбиений ');
  Readln(n);
  h:=(b-a)/n;
  sc:=0;
  x:=a;
    While x+h<=b-h do
      begin
        sc:=sc+(sqrt(x*x+5))/(2*x+sqrt(x*x+0.5));
        x:=x+2*h;
      end;
    sn:=0;
    x:=a;
    While x+(2*h)<=b-(2*h) do
      begin
        sn:=sn+(sqrt(x*x+5))/(2*x+sqrt(x*x+0.5));
        x:=x+2*h;
      end;    
  s:=(h*(a+b+4*sc+2*sn))/3;
  Writeln('Значение интеграла буде равно ', s);
end.
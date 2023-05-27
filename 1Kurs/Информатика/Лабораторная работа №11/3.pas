Program Zadanye_2;
Var
y,x:real;
begin
  Writeln('Введите x');
  Readln(x);
  if x>=1 then
      y:=1/2*x
     else
      if (x>=0) and (x<1) then
        y := 1/3*x
        else
          if x<0 then
            y:=1/4*abs(x);
   Writeln(y);
end.
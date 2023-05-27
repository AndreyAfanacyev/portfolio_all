Program Zadanye_1;
const 
n=100;
Var
d1,d2,d3,k,a,z,fac,i:integer;
y:real;
x: array [1..n] of integer;
begin
  randomize;
  fac:=1;
    for i:=1 to 10 do
      begin
        fac:=fac*i;
      end;
      for i:=1 to n do
        begin
          x[i]:=random(100);
        end;
  Writeln('Введите d1,d2,d3,k,a');
  Readln(d1,d2,d3,k,a);
    for i:=1 to n do 
      if (x[i]>=d1) and (x[i]<d2) then
          begin
          y := exp(ln(a+x[i]/k));
          Writeln(y);
          end
        else
          if (x[i]>d2) and (x[i]<=d3) then
            While z<=10 do
              begin
                y:=(exp(ln(z)*x[i])+x[i])/fac;
                Writeln(y);
                z:=z+2;
              end;
end.
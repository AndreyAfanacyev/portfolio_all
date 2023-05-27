  Program Zadanye_1;
Var
f: array[1..5] of real;
R,C,L,j,XL,XC,Z:real;
i:integer;
begin
  Writeln('Введите R, C, L');
  Readln(R,C,L);
  for i:=1 to 5 do
    begin
      Writeln ('Введите ', i,'-ое ', 'значение f');
      Readln(f[i]);
    end;
  for i:=1 to 5 do
    begin
      XC:=1/(2*pi*f[i]*C);
      XL:=2*pi*f[i]*L;
      j:=arctan((XL/R)-((XL*XL)/(R*XC))-(R/XC));
      Z:=(XC*sqrt(XL*XL+R*R))/sqrt(R*R+((XL-XC)*(XL-XC)));
      Writeln('При  частоте ',f[i],' фазовый угол будет равен ',j,' а реактивное сопротивление кол.контура ',Z);
    end;
end.
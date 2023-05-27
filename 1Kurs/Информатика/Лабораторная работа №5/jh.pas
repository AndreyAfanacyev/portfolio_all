Program Zadanye_1;
Var
sm:integer;
d:real;
procedure per(sm,d:real);
begin
  writeln('|  ',sm:2,'     |   ', d:2:2,' |');
  writeln('--------------------');
end;
begin
  Writeln('|','Сантиметр','|','  Дюйм','  |');
  Writeln('--------------------');
  for sm:=0 to 100 do
    begin
      d:=sm/2.5;
      per(sm,d); 
    end;
end.

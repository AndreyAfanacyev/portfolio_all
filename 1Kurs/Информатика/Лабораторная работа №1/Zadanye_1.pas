Program Zadanye_4;
Var
a,S: integer;
begin
    S:=0;
    Writeln('Введите a');
    Read(a);
    While a<> 0 do 
    begin
      S:=S+a mod 10;
      a:=a div 10;
    end;
    Writeln('Суммой цифр числа будет  ',S);
end.

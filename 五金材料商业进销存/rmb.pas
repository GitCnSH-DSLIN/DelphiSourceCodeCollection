unit rmb;

interface

function NumToUpper(const num:real):string;

implementation
uses SysUtils;

function NumToUpper(const num:real):string;
var aa,bb,cc:string;
    bbb:array[1..16]of string;
    uppna:array[0..9] of string;
    i:integer;
begin

    bbb[1]:='��';
   bbb[2]:='Ǫ';
   bbb[3]:='��';
   bbb[4]:='ʰ';
  bbb[5]:='��';;
  bbb[6]:='Ǫ';;
  bbb[7]:='��';
  bbb[8]:='ʰ';
  bbb[9]:='��';
  bbb[10]:='Ǫ';
  bbb[11]:='��';
  bbb[12]:='ʰ';
  bbb[13]:='Ԫ';
 bbb[14]:='.';
  bbb[15]:='��';
 bbb[16]:='��';
  uppna[1]:='Ҽ';
  uppna[2]:='��';
  uppna[3]:='��';
  uppna[4]:='��';
  uppna[5]:='��';
  uppna[6]:='½';
  uppna[7]:='��';
  uppna[8]:='��';
  uppna[9]:='��';
  Str(num:16:2,aa);
  cc:='';
  bb:='';
  result:='';
  for i:=1 to 16 do
    begin
      cc:=aa[i];
      if cc<>' ' then
        begin
         bb:=bbb[i];
          if cc='0' then
            cc:='��'
          else
            begin
              if cc='.' then
                begin
                  cc:='';
                  bb:='';
                end
              else
                begin
                  cc:=uppna[StrToInt(cc)];
                end
            end;
          result:=result+(cc+bb)
        end;
    end;
  result:=result+'��';
end;

end.
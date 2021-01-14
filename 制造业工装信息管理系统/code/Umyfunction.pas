unit Umyfunction;

interface
uses
  SysUtils, Forms,StdCtrls ;

  procedure clearEdt(Frm: Tform);
  function replace(s,s1,s2:string):string;//��S�е�S2��S1�滻

implementation

procedure clearEdt(Frm: Tform);
var
  i:integer;
begin
  //��մ���������edit
  with Frm do begin
    for i:=0 to ComponentCount-1 do begin
      if (Components[i] is tedit) then
        (Components[i] as tedit).text:='';
      if (Components[i] is tcombobox) then
        (Components[i] as tcombobox).text:='';
      if (Components[i] is tmemo) then
        (Components[i] as tmemo).text:='';
    end;
  end;
end;

function replace(s,s1,s2:string):string;//��S�е�S1��S2�滻
var
  str:string;
  Plen,Slen,id:integer;//�������Ӵ������Ӵ�λ��
begin
  s:=trim(s)+' ';
  s1:=trim(s1)+' ';
  s2:=trim(s2)+' ';
  Plen:=length(s);
  Slen:=length(s1);
  id:=pos(s1,s);
  if id<1 then exit;
  str:='';
  str:=copy(s,1,id-1);
  str:=str+s2;
  str:=str+copy(s,id+Slen,Plen-(id+Slen-1));
  result:=str;
end;


end.

//{���ú�����Ԫ����ɷ������ľ���Ĺ��ܣ�
unit frm_Public_Func;

interface
uses
    Windows, Messages, SysUtils, Variants, Classes,  Controls, Forms,
    ExtCtrls,  StdCtrls,db,ComCtrls,adodb;
function queryrecord (queryname:TADOQuery;sql:string):boolean; //��ѯ true Ϊ�м�¼��falseΪû�м�¼;
implementation
function queryrecord(queryname:TADOQuery;sql:string):boolean; //��ѯ true Ϊ�м�¼��falseΪû�м�¼;
begin
    queryname.Close;
    queryname.SQL.Clear;
    queryname.SQL.Text:=trim(sql);
    queryname.Open;
    if queryname.RecordCount<=0 then
    begin
        result:=false;
    end
    else
    begin
        result:=true;
    end;
end;

end.

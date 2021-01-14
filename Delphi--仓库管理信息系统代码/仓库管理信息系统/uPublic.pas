unit uPublic;


interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBGrids, DBClient, DB, Registry, winsock;

//==
procedure DbGridSort(dbgrid: TDBGrid; Column: TColumn);


//===����¼�봰�ڣ��õ�ְ��������
function GetEmployeeName: string;


//==����¼�봰�ڣ��õ���������
function GetDeptName: string;

//==����¼�봰�ڣ��õ�������Ŀ����
function GetProjectName: string;

var
  psIndexName: string; //
  plAscend: Boolean;
implementation

uses u_fzlr_zgxm , u_bmda_fzlr;


procedure DbGridSort(dbgrid: TDBGrid; Column: TColumn);
var
//��ģ��ʹ�õ���psIndexName, plAscend�����������϶���
  mode: char; //��¼�ǡ����򡱻��ǡ�����
  ColName: string; //��¼��ǰ�ֶ���
  iCol: Integer; //��¼��ǰ�к�
begin
  with dbgrid.DataSource.DataSet as Tclientdataset do //Table0
  begin
//��⵱ǰ�������Ƿ��Ѵ�
    if not Active
      then begin
      Application.MessageBox('��������δ�򿪣�', 'ֹͣ', MB_OK + MB_ICONSTOP);
      Abort
    end;
//��⵱ǰ�ֶ��Ƿ������򡱡������ֶ����Ͳ�������
    case Column.Field.DataType of
      ftBoolean,
        ftBytes,
        ftBlob, //Binary
        ftMemo,
        ftGraphic,
        ftFmtMemo, //Formatted memo
        ftParadoxOle: //OLE
        begin
          Abort
        end;
    end; //case
    mode := '0';
    iCol := Column.Field.FieldNo - 1;
    try
      ColName := Column.fieldname;
      if psIndexName = Column.fieldname then
      begin //��ԭ��ͬ��
        if plAscend //����
          then begin
          mode := '2';
          IndexName := ColName + '2'; //Ӧ������
        end
        else begin
          mode := '1';
          IndexName := ColName + '1'; //Ӧ������
        end;
        plAscend := not plAscend;
      end
      else begin //����
        IndexName := ColName + '2';
        plAscend := false;
        psIndexName := ColName;
      end;
    except
      on EDatabaseError do //��δ�������������½���
      begin
//�����½�����
        IndexName := '';
        if mode = '1'
          then AddIndex(ColName + '1', ColName, [], '', '', 0) //
        else //����'0'
          AddIndex(ColName + '2', ColName, [ixDescending], '', '', 0);
        try //try 1
          if mode <> '1'
            then begin
            mode := '2'; //ת��
            plAscend := false;
          end
          else plAscend := true;
          IndexName := ColName + mode;
          psIndexName := ColName;
        except
          IndexName := '';
        end //try 2
      end
    end;
    first;
  end; //with
  dbgrid.SelectedIndex := iCol;
end;



//===����¼�봰�ڣ��õ�ְ��������

function GetEmployeeName: string;
begin
  //����TfrmZgda_fzlr�������
  with TfrmZgda_fzlr.Create(Application) do
  begin
    pub_zgxm := '';
    try
      //ģʽ��ʾ����
      showModal;
    finally
      free;
    end;
    result := pub_zgxm;
  end;
end;


//===����¼�봰�ڣ��õ����ŵ�����

function GetDeptName: string;
begin
  with TfrmBmda_fzlr.Create(Application) do
  begin
    pub_Bmmc := '';
    try
      showModal;
    finally
      free;
    end;
    result := pub_Bmmc;
  end;
end;

//==����¼�봰�ڣ��õ�������Ŀ����

function GetProjectName: string;
begin
{  with TfrmGcxmdy_fzlr.Create(Application) do
  begin
    pub_Gcxmmc := '';
    try
      showModal;
    finally
      free;
    end;
    result := pub_Gcxmmc;
  end;       }
end;


end.


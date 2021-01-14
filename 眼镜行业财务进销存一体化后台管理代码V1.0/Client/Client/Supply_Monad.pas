unit Supply_Monad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, Buttons,
  DBGrids;

type
  Tfrm_Supply_Monad = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Panel3: TPanel;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    SpeedButton2: TSpeedButton;
    Cmd_Select: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Cmd_SelectClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Supply_Monad: Tfrm_Supply_Monad;

implementation

uses  Data, Stock_Contract, func;

{$R *.dfm}

procedure Tfrm_Supply_Monad.SpeedButton3Click(Sender: TObject);
begin
    frm_data.ClientDataSet2.Active:=false;
    frm_data.ClientDataSet2.Close;
    Close;
end;

procedure Tfrm_Supply_Monad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    frm_data.ClientDataSet2.Active:=false;
    frm_data.ClientDataSet2.Close;
    Action:=Cafree;
end;

procedure Tfrm_Supply_Monad.FormShow(Sender: TObject);
begin
    with frm_data.ClientDataSet2 do
    begin
        try
            Close;
            CommandText:='';
            CommandText:='select ID,supply_name,abbreviation,supply_NO,address,Zip,Link_person,Telphone,Fax,Email,tax_No,bank,bill,Must_gather,Pay_gather,legal_person,contact,remark from [Supply_Company]order by ID';
            Open;

            frm_data.DataSource1.DataSet:=frm_data.ClientDataSet2;
            frm_data.DataSource1.Enabled:=True;
            DBGrid1.DataSource:=frm_data.DataSource1;

            DBGrid1.Columns[0].Title.caption:='���';
            DBGrid1.Columns[1].Title.caption:='��λ����';
            DBGrid1.Columns[2].Title.caption:='��λ���';
            DBGrid1.Columns[3].Title.caption:='��λ���';
            DBGrid1.Columns[4].Title.caption:='��ϸ��ַ';
            DBGrid1.Columns[5].Title.caption:='��������';
            DBGrid1.Columns[6].Title.caption:='��ϵ��Ա';
            DBGrid1.Columns[7].Title.caption:='��ϵ�绰';
            DBGrid1.Columns[8].Title.caption:='�������';
            DBGrid1.Columns[9].Title.caption:='�����ʼ�';
            DBGrid1.Columns[10].Title.caption:='˰��';
            DBGrid1.Columns[11].Title.caption:='��������';
            DBGrid1.Columns[12].Title.caption:='�����ʺ�';
            DBGrid1.Columns[13].Title.caption:='Ӧ�տ����';
            DBGrid1.Columns[14].Title.caption:='Ӧ�������';
            DBGrid1.Columns[15].Title.caption:='���˴���';
            DBGrid1.Columns[16].Title.caption:='���ö��';
            DBGrid1.Columns[17].Title.caption:='��ע˵��';
            if frm_data.ClientDataSet2.RecordCount>0 then
            begin
                Last;
                LabeledEdit2.Text:=frm_data.ClientDataSet2.FieldValues['supply_NO'];
                LabeledEdit3.Text:=frm_data.ClientDataSet2.FieldValues['supply_name'];
            end
            else
            begin
                 LabeledEdit2.Text:='';  LabeledEdit3.Text:='';
            end;
        except
            Application.MessageBox('����ʧ���������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
        end;
    end;
end;

procedure Tfrm_Supply_Monad.Cmd_SelectClick(Sender: TObject);
begin
  if Trim(LabeledEdit3.Text)='' then
  begin
      Application.MessageBox('����ʧ�ܣ�����λ���ơ�����Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
      Exit;
  end;
  check_Mond_Result:=Trim(LabeledEdit3.Text);
  wldwno:=Trim(LabeledEdit2.Text);
  Close; //
end;

procedure Tfrm_Supply_Monad.DBGrid1CellClick(Column: TColumn);
begin
    LabeledEdit2.Text:=frm_data.ClientDataSet2.FieldValues['supply_NO'];
    LabeledEdit3.Text:=frm_data.ClientDataSet2.FieldValues['supply_name'];
end;

procedure Tfrm_Supply_Monad.SpeedButton2Click(Sender: TObject);
var
  sql:widestring;
  datas:olevariant;
begin
  sql:='select ID,supply_name,abbreviation,supply_NO,address,Zip,Link_person,Telphone,Fax,Email,tax_No,bank,bill,Must_gather,Pay_gather,legal_person,contact,remark from [Supply_Company] where supply_name like '+''''+'%'+trim(LabeledEdit3.Text)+'%'+'''';
  frm_data.ClientDataSet2.Close;
  frm_data.ClientDataSet2.Data:=null;
  datas:=null;
  try
    Datas:=adisp.execSql(sql);
    if not varisnull(datas) then
    begin
      frm_data.ClientDataSet2.Data:=datas;
      frm_data.ClientDataSet2.Open;
       DBGrid1.Columns[0].Title.caption:='���';
      DBGrid1.Columns[1].Title.caption:='��λ����';
      DBGrid1.Columns[2].Title.caption:='��λ���';
      DBGrid1.Columns[3].Title.caption:='��λ���';
      DBGrid1.Columns[4].Title.caption:='��ϸ��ַ';
      DBGrid1.Columns[5].Title.caption:='��������';
      DBGrid1.Columns[6].Title.caption:='��ϵ��Ա';
      DBGrid1.Columns[7].Title.caption:='��ϵ�绰';
      DBGrid1.Columns[8].Title.caption:='�������';
      DBGrid1.Columns[9].Title.caption:='�����ʼ�';
      DBGrid1.Columns[10].Title.caption:='˰��';
      DBGrid1.Columns[11].Title.caption:='��������';
      DBGrid1.Columns[12].Title.caption:='�����ʺ�';
      DBGrid1.Columns[13].Title.caption:='Ӧ�տ����';
      DBGrid1.Columns[14].Title.caption:='Ӧ�������';
      DBGrid1.Columns[15].Title.caption:='���˴���';
      DBGrid1.Columns[16].Title.caption:='���ö��';
      DBGrid1.Columns[17].Title.caption:='��ע˵��';
      datas:=null;
    end;
  except
    application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
    exit;
  end;


end;

end.

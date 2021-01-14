unit ufraTruckInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufraTechInfoBase, StdCtrls, DB, ADODB, CSADOQuery, Mask, DBCtrls,
  CSDBNavigator, Buttons, ExtCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib,
  CSdxDBDateEdit, dxDBELib, DBCtrlsEh, CSCustomdxDateEdit;

type
  TfraTruckInfo = class(TfraTechInfoBase)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    DBEdit1: TDBEditEh;
    DBEdit2: TDBEditEh;
    DBEdit5: TDBEditEh;
    DBEdit6: TDBEditEh;
    CSdxDBDateEdit1: TCSdxDBDateEdit;
    DBEdit29: TDBEditEh;
    GroupBox2: TGroupBox;
    Label26: TLabel;
    DBEdit26: TDBEditEh;
    Label3: TLabel;
    DBEdit3: TDBEditEh;
    Label7: TLabel;
    DBEdit7: TDBEditEh;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit8: TDBEditEh;
    DBEdit9: TDBEditEh;
    DBEdit11: TDBEditEh;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    DBEdit12: TDBEditEh;
    DBEdit14: TDBEditEh;
    DBEdit15: TDBEditEh;
    GroupBox1: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    DBEdit16: TDBEditEh;
    DBEdit17: TDBEditEh;
    DBEdit18: TDBEditEh;
    GroupBox3: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    DBEdit19: TDBEditEh;
    DBEdit20: TDBEditEh;
    DBEdit21: TDBEditEh;
    DBEdit22: TDBEditEh;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    DBEdit23: TDBEditEh;
    DBEdit24: TDBEditEh;
    DBEdit27: TDBEditEh;
    Label28: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    DBEdit30: TDBEditEh;
    DBEdit31: TDBEditEh;
    DBEdit33: TDBEditEh;
    Label35: TLabel;
    DBEdit34: TDBEditEh;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    dxDBPickEdit3: TdxDBPickEdit;
    dxDBPickEdit1: TdxDBPickEdit;
    dxDBPickEdit2: TdxDBPickEdit;
    dxDBPickEdit4: TdxDBPickEdit;
    dxDBPickEdit5: TdxDBPickEdit;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    dxDBPickEdit6: TdxDBPickEdit;
    GroupBox10: TGroupBox;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    dxDBPickEdit15: TdxDBPickEdit;
    dxDBPickEdit16: TdxDBPickEdit;
    dxDBPickEdit17: TdxDBPickEdit;
    dxDBPickEdit14: TdxDBPickEdit;
    Label49: TLabel;
    DBMemo1: TdxDBMemo;
  private
    { Private declarations }
  protected
    procedure prop_GetTechInfo; override;
  public
    procedure pubp_Ini(const As_Id: string;
      const As_VerifyId: string = ''); override;
  end;

implementation

uses
  udmData;

{$R *.dfm}

{ TfraTruckInfo }

procedure TfraTruckInfo.prop_GetTechInfo;
begin
  with TechInfo do
  begin
    if Active then Close;
    SQL.Text := Format('SELECT * FROM device.truck_info WHERE dev_id = ''%s''',
      [DeviceId]);
    Open;
  end;
end;

procedure TfraTruckInfo.pubp_Ini(const As_Id, As_VerifyId: string);
begin
  inherited;

  prop_LoadTechInfoItems('���ڻ���������Ʒ����', dxDBPickEdit5);
  prop_LoadTechInfoItems('���ڻ�������ȼ������', dxDBPickEdit3);
  prop_LoadTechInfoItems('���ڻ�������ת��λ��', dxDBPickEdit6);
  prop_LoadTechInfoItems('���ڻ��������Ƿ��Ϲҳ�', dxDBPickEdit1);
  prop_LoadTechInfoItems('���ڻ�������������ʽ', dxDBPickEdit2);
  prop_LoadTechInfoItems('���ڻ���������������', dxDBPickEdit4);
  prop_LoadTechInfoItems('���ڻ���������ƹ淶', dxDBPickEdit14);
  prop_LoadTechInfoItems('���ڻ�����������淶', dxDBPickEdit15);
  prop_LoadTechInfoItems('���ڻ��������豸�¾�״��', dxDBPickEdit16);
  prop_LoadTechInfoItems('���ڻ������������ʽ', dxDBPickEdit17);
end;

end.

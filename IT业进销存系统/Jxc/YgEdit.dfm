inherited frmYgEdit: TfrmYgEdit
  Left = 163
  Top = 16
  Width = 537
  Height = 487
  Caption = 'frmYgEdit'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited Bevel1: TBevel
    Width = 505
    Height = 391
  end
  inherited Label1: TLabel
    Left = 78
  end
  object Label3: TLabel [2]
    Left = 174
    Top = 30
    Width = 30
    Height = 15
    Caption = '����'
    FocusControl = DBEdit3
  end
  object Label4: TLabel [3]
    Left = 306
    Top = 30
    Width = 30
    Height = 15
    Caption = '�Ա�'
  end
  object Label6: TLabel [4]
    Left = 78
    Top = 70
    Width = 30
    Height = 15
    Caption = '����'
  end
  object Label10: TLabel [5]
    Left = 276
    Top = 70
    Width = 60
    Height = 15
    Caption = 'Ա�����'
  end
  object Label11: TLabel [6]
    Left = 78
    Top = 100
    Width = 30
    Height = 15
    Caption = 'ְ��'
    FocusControl = DBEdit11
  end
  object Label12: TLabel [7]
    Left = 48
    Top = 292
    Width = 60
    Height = 15
    Caption = '��������'
    FocusControl = DBEdit12
  end
  object Label13: TLabel [8]
    Left = 78
    Top = 172
    Width = 30
    Height = 15
    Caption = 'ѧ��'
  end
  object Label14: TLabel [9]
    Left = 276
    Top = 172
    Width = 60
    Height = 15
    Caption = '��ϵ�绰'
    FocusControl = DBEdit14
  end
  object Label15: TLabel [10]
    Left = 48
    Top = 200
    Width = 60
    Height = 15
    Caption = '��������'
    FocusControl = DBEdit15
  end
  object Label16: TLabel [11]
    Left = 78
    Top = 232
    Width = 30
    Height = 15
    Caption = 'סַ'
    FocusControl = DBEdit16
  end
  object Label17: TLabel [12]
    Left = 276
    Top = 202
    Width = 60
    Height = 15
    Caption = '���֤��'
    FocusControl = DBEdit17
  end
  object Label18: TLabel [13]
    Left = 78
    Top = 262
    Width = 30
    Height = 15
    Caption = '����'
    FocusControl = DBEdit18
  end
  object Label19: TLabel [14]
    Left = 306
    Top = 262
    Width = 30
    Height = 15
    Caption = '�ʱ�'
    FocusControl = DBEdit19
  end
  object Label20: TLabel [15]
    Left = 276
    Top = 100
    Width = 60
    Height = 15
    Caption = '��ְ����'
    FocusControl = DBEdit20
  end
  object Label21: TLabel [16]
    Left = 18
    Top = 130
    Width = 90
    Height = 15
    Caption = '���ʼ��㷽��'
  end
  object Label23: TLabel [17]
    Left = 276
    Top = 130
    Width = 60
    Height = 15
    Caption = '��������'
    FocusControl = DBEdit23
  end
  object Label26: TLabel [18]
    Left = 78
    Top = 370
    Width = 30
    Height = 15
    Caption = '��ע'
    FocusControl = DBEdit26
  end
  object Bevel2: TBevel [19]
    Left = 24
    Top = 54
    Width = 481
    Height = 6
    Shape = bsTopLine
  end
  object Bevel3: TBevel [20]
    Left = 23
    Top = 156
    Width = 481
    Height = 6
    Shape = bsTopLine
  end
  object Bevel4: TBevel [21]
    Left = 24
    Top = 318
    Width = 481
    Height = 6
    Shape = bsTopLine
  end
  object Bevel5: TBevel [22]
    Left = 24
    Top = 354
    Width = 481
    Height = 6
    Shape = bsTopLine
  end
  object DBRadioGroup1: TDBRadioGroup [23]
    Left = 114
    Top = 117
    Width = 139
    Height = 36
    BiDiMode = bdLeftToRight
    Columns = 2
    Ctl3D = True
    DataField = 'JSFF'
    DataSource = Data.sYg
    Items.Strings = (
      '��н'
      '�Ƽ�')
    ParentBiDiMode = False
    ParentCtl3D = False
    TabOrder = 7
    Values.Strings = (
      '1'
      '2')
  end
  inherited btnInsert: TBitBtn
    Top = 416
    TabOrder = 20
  end
  inherited btnOk: TBitBtn
    Left = 325
    Top = 416
    TabOrder = 21
  end
  inherited btnCancel: TBitBtn
    Left = 427
    Top = 416
    TabOrder = 22
  end
  inherited DBEdit1: TDBEdit
    Left = 114
    Width = 42
    DataField = 'BH'
    DataSource = Data.sYg
  end
  inherited DBNavigator1: TDBNavigator
    Top = 424
    TabOrder = 23
  end
  object DBEdit3: TDBEdit
    Left = 210
    Top = 24
    Width = 74
    Height = 23
    DataField = 'XM'
    DataSource = Data.sYg
    TabOrder = 1
  end
  object DBEdit11: TDBEdit
    Left = 114
    Top = 96
    Width = 90
    Height = 23
    DataField = 'ZW'
    DataSource = Data.sYg
    TabOrder = 5
  end
  object DBEdit12: TDBEdit
    Left = 114
    Top = 288
    Width = 90
    Height = 23
    DataField = 'CSRQ'
    DataSource = Data.sYg
    TabOrder = 16
  end
  object DBEdit14: TDBEdit
    Left = 342
    Top = 168
    Width = 154
    Height = 23
    DataField = 'DH'
    DataSource = Data.sYg
    TabOrder = 10
  end
  object DBEdit15: TDBEdit
    Left = 114
    Top = 198
    Width = 139
    Height = 23
    DataField = 'BP'
    DataSource = Data.sYg
    TabOrder = 11
  end
  object DBEdit16: TDBEdit
    Left = 114
    Top = 228
    Width = 382
    Height = 23
    DataField = 'ZZ'
    DataSource = Data.sYg
    TabOrder = 13
  end
  object DBEdit17: TDBEdit
    Left = 342
    Top = 198
    Width = 154
    Height = 23
    DataField = 'SFZH'
    DataSource = Data.sYg
    TabOrder = 12
  end
  object DBEdit18: TDBEdit
    Left = 114
    Top = 258
    Width = 139
    Height = 23
    DataField = 'JG'
    DataSource = Data.sYg
    TabOrder = 14
  end
  object DBEdit19: TDBEdit
    Left = 342
    Top = 258
    Width = 58
    Height = 23
    DataField = 'YB'
    DataSource = Data.sYg
    TabOrder = 15
  end
  object DBEdit20: TDBEdit
    Left = 342
    Top = 96
    Width = 90
    Height = 23
    DataField = 'RZRQ'
    DataSource = Data.sYg
    TabOrder = 6
  end
  object DBEdit23: TDBEdit
    Left = 342
    Top = 126
    Width = 90
    Height = 23
    DataField = 'JBGZ'
    DataSource = Data.sYg
    TabOrder = 8
  end
  object DBCheckBox1: TDBCheckBox
    Left = 78
    Top = 330
    Width = 97
    Height = 17
    Caption = '�Ƿ�ҵ��Ա'
    DataField = 'YWYBZ'
    DataSource = Data.sYg
    TabOrder = 17
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object DBCheckBox2: TDBCheckBox
    Left = 192
    Top = 330
    Width = 97
    Height = 17
    Caption = '�Ƿ�����ְ'
    DataField = 'LZ'
    DataSource = Data.sYg
    TabOrder = 18
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object DBEdit26: TDBEdit
    Left = 114
    Top = 366
    Width = 382
    Height = 23
    DataField = 'BZ'
    DataSource = Data.sYg
    TabOrder = 19
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 114
    Top = 66
    Width = 139
    Height = 23
    DataField = 'BMID'
    DataSource = Data.sYg
    DropDownAlign = daCenter
    DropDownRows = 10
    KeyField = 'ID'
    ListField = 'MC'
    ListSource = Data.sBm
    TabOrder = 3
    OnKeyDown = DBLookupComboBox1KeyDown
  end
  object DBLookupComboBox2: TDBLookupComboBox
    Left = 342
    Top = 66
    Width = 139
    Height = 23
    DataField = 'YGLBID'
    DataSource = Data.sYg
    DropDownAlign = daCenter
    DropDownRows = 10
    KeyField = 'ID'
    ListField = 'MC'
    ListSource = Data.sYglb
    TabOrder = 4
    OnKeyDown = DBLookupComboBox1KeyDown
  end
  object DBComboBox1: TDBComboBox
    Left = 114
    Top = 168
    Width = 90
    Height = 23
    DataField = 'XL'
    DataSource = Data.sYg
    ItemHeight = 15
    Items.Strings = (
      'Сѧ'
      '��ѧ'
      '����'
      '��У'
      '��ר'
      '��ר'
      '����'
      '˶ʿ'
      '��ʿ')
    TabOrder = 9
  end
  object DBComboBox2: TDBComboBox
    Left = 342
    Top = 24
    Width = 49
    Height = 23
    Style = csDropDownList
    DataField = 'XB'
    DataSource = Data.sYg
    ItemHeight = 15
    Items.Strings = (
      '��'
      'Ů')
    TabOrder = 2
  end
end

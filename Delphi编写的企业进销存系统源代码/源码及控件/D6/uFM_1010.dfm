inherited FM_1010: TFM_1010
  Left = 172
  Top = 140
  Width = 725
  Height = 525
  Hint = '�ͻ���������'
  Caption = '�ͻ���������'
  FormStyle = fsMDIChild
  Visible = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited Panel1: TPanel
    Width = 467
    Height = 454
    object Label4: TLabel [0]
      Left = 42
      Top = 70
      Width = 36
      Height = 12
      Caption = '������'
      FocusControl = DBEdit5
    end
    object Label5: TLabel [1]
      Left = 42
      Top = 92
      Width = 36
      Height = 12
      Caption = '�绰һ'
      FocusControl = DBEdit6
    end
    object Label6: TLabel [2]
      Left = 256
      Top = 92
      Width = 36
      Height = 12
      Caption = '�绰��'
      FocusControl = DBEdit7
    end
    object Label7: TLabel [3]
      Left = 54
      Top = 114
      Width = 24
      Height = 12
      Caption = '����'
      FocusControl = DBEdit8
    end
    object Label8: TLabel [4]
      Left = 54
      Top = 139
      Width = 24
      Height = 12
      Caption = '��ַ'
      FocusControl = DBEdit9
    end
    object Label9: TLabel [5]
      Left = 244
      Top = 115
      Width = 48
      Height = 12
      Caption = '��������'
      FocusControl = DBEdit10
    end
    object Label10: TLabel [6]
      Left = 43
      Top = 161
      Width = 36
      Height = 12
      Caption = 'E_Mail'
      FocusControl = DBEdit11
    end
    object Label11: TLabel [7]
      Left = 6
      Top = 183
      Width = 72
      Height = 12
      Caption = '������ʼ����'
    end
    object Label12: TLabel [8]
      Left = 30
      Top = 206
      Width = 48
      Height = 12
      Caption = '�ͻ���ַ'
      FocusControl = DBEdit12
    end
    object Label13: TLabel [9]
      Left = 42
      Top = 230
      Width = 36
      Height = 12
      Caption = '������'
      FocusControl = DBEdit13
    end
    object Label14: TLabel [10]
      Left = 151
      Top = 230
      Width = 24
      Height = 12
      Caption = '�绰'
      FocusControl = DBEdit14
    end
    object Label15: TLabel [11]
      Left = 297
      Top = 230
      Width = 48
      Height = 12
      Caption = '�ж��绰'
      FocusControl = DBEdit15
    end
    object Label16: TLabel [12]
      Left = 30
      Top = 253
      Width = 48
      Height = 12
      Caption = '��Ʊ����'
      FocusControl = DBEdit16
    end
    object Label17: TLabel [13]
      Left = 30
      Top = 276
      Width = 48
      Height = 12
      Caption = '��Ʊ̧ͷ'
      FocusControl = DBEdit17
    end
    object Label18: TLabel [14]
      Left = 18
      Top = 298
      Width = 60
      Height = 12
      Caption = '��Ʊ������'
      FocusControl = DBEdit18
    end
    object Label19: TLabel [15]
      Left = 30
      Top = 322
      Width = 48
      Height = 12
      Caption = '��Ʊ��ַ'
      FocusControl = DBEdit19
    end
    object Label21: TLabel [16]
      Left = 244
      Top = 347
      Width = 48
      Height = 12
      Caption = '���ñұ�'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel [17]
      Left = 30
      Top = 370
      Width = 48
      Height = 12
      Caption = '����˰��'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel [18]
      Left = 244
      Top = 370
      Width = 48
      Height = 12
      Caption = '�ο�˰��'
      FocusControl = DBEdit23
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [19]
      Left = 30
      Top = 22
      Width = 48
      Height = 12
      Caption = '�ͻ����'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [20]
      Left = 244
      Top = 22
      Width = 48
      Height = 12
      Caption = '�ͻ����'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [21]
      Left = 30
      Top = 45
      Width = 48
      Height = 12
      Caption = '�ͻ�����'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel [22]
      Left = 42
      Top = 347
      Width = 36
      Height = 12
      Caption = '������'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    inherited DBEdit1: TDBEdit
      Left = 86
      Top = 18
      Width = 153
      DataField = 'F01'
    end
    object DBEdit3: TDBEdit
      Left = 86
      Top = 42
      Width = 373
      Height = 20
      DataField = 'F02'
      DataSource = DataSource1
      TabOrder = 2
    end
    object DBEdit4: TDBEdit
      Left = 295
      Top = 18
      Width = 163
      Height = 20
      DataField = 'F03'
      DataSource = DataSource1
      TabOrder = 1
    end
    object DBEdit5: TDBEdit
      Left = 86
      Top = 66
      Width = 373
      Height = 20
      DataField = 'F04'
      DataSource = DataSource1
      TabOrder = 3
    end
    object DBEdit6: TDBEdit
      Left = 86
      Top = 89
      Width = 154
      Height = 20
      DataField = 'F05'
      DataSource = DataSource1
      TabOrder = 4
    end
    object DBEdit7: TDBEdit
      Left = 295
      Top = 89
      Width = 164
      Height = 20
      DataField = 'F06'
      DataSource = DataSource1
      TabOrder = 5
    end
    object DBEdit8: TDBEdit
      Left = 86
      Top = 112
      Width = 154
      Height = 20
      DataField = 'F07'
      DataSource = DataSource1
      TabOrder = 6
    end
    object DBEdit9: TDBEdit
      Left = 86
      Top = 135
      Width = 373
      Height = 20
      DataField = 'F08'
      DataSource = DataSource1
      TabOrder = 8
    end
    object DBEdit10: TDBEdit
      Left = 295
      Top = 112
      Width = 164
      Height = 20
      DataField = 'F09'
      DataSource = DataSource1
      TabOrder = 7
    end
    object DBEdit11: TDBEdit
      Left = 86
      Top = 158
      Width = 373
      Height = 20
      DataField = 'F10'
      DataSource = DataSource1
      TabOrder = 9
    end
    object DBEdit12: TDBEdit
      Left = 86
      Top = 204
      Width = 373
      Height = 20
      DataField = 'F12'
      DataSource = DataSource1
      TabOrder = 11
    end
    object DBEdit13: TDBEdit
      Left = 86
      Top = 227
      Width = 63
      Height = 20
      DataField = 'F13'
      DataSource = DataSource1
      TabOrder = 12
    end
    object DBEdit14: TDBEdit
      Left = 176
      Top = 227
      Width = 120
      Height = 20
      DataField = 'F14'
      DataSource = DataSource1
      TabOrder = 13
    end
    object DBEdit15: TDBEdit
      Left = 347
      Top = 227
      Width = 112
      Height = 20
      DataField = 'F15'
      DataSource = DataSource1
      TabOrder = 14
    end
    object DBEdit16: TDBEdit
      Left = 86
      Top = 250
      Width = 373
      Height = 20
      DataField = 'F16'
      DataSource = DataSource1
      TabOrder = 15
    end
    object DBEdit17: TDBEdit
      Left = 86
      Top = 273
      Width = 373
      Height = 20
      DataField = 'F17'
      DataSource = DataSource1
      TabOrder = 16
    end
    object DBEdit18: TDBEdit
      Left = 86
      Top = 296
      Width = 373
      Height = 20
      DataField = 'F18'
      DataSource = DataSource1
      TabOrder = 17
    end
    object DBEdit19: TDBEdit
      Left = 86
      Top = 319
      Width = 373
      Height = 20
      DataField = 'F19'
      DataSource = DataSource1
      TabOrder = 18
    end
    object DBEdit23: TDBEdit
      Left = 295
      Top = 366
      Width = 164
      Height = 20
      DataField = 'F23'
      DataSource = DataSource1
      TabOrder = 22
    end
    object DBComboBox1: TDBComboBox
      Left = 86
      Top = 343
      Width = 154
      Height = 20
      DataField = 'F20'
      DataSource = DataSource1
      ItemHeight = 12
      Items.Strings = (
        '25'
        '�µ�')
      TabOrder = 19
    end
    object DBDateEdit1: TDBDateEdit
      Left = 86
      Top = 181
      Width = 373
      Height = 20
      DataField = 'F11'
      DataSource = DataSource1
      NumGlyphs = 2
      TabOrder = 10
    end
    object DBComboBox2: TDBComboBox
      Left = 87
      Top = 366
      Width = 153
      Height = 20
      Style = csDropDownList
      DataField = 'F22'
      DataSource = DataSource1
      ItemHeight = 12
      Items.Strings = (
        '���'
        '�ں�'
        '��˰')
      TabOrder = 21
    end
    object RxDBComboEdit2: TRxDBComboEdit
      Left = 296
      Top = 343
      Width = 163
      Height = 20
      DataField = 'F21'
      DataSource = DataSource1
      GlyphKind = gkEllipsis
      ButtonWidth = 17
      NumGlyphs = 1
      TabOrder = 20
      OnButtonClick = RxDBComboEdit2ButtonClick
    end
  end
  inherited ToolBar1: TToolBar
    Width = 717
    inherited SB2: TSpeedButton
      Visible = True
    end
    inherited SB3: TSpeedButton
      Transparent = False
      Visible = True
    end
  end
  inherited DBGrid1: TDBGrid
    Left = 467
    Width = 250
    Height = 454
    Columns = <
      item
        Expanded = False
        FieldName = 'F01'
        PickList.Strings = ()
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'F03'
        PickList.Strings = ()
        Width = 68
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'F05'
        PickList.Strings = ()
        Width = 104
        Visible = True
      end>
  end
  inherited DataSource1: TDataSource
    Left = 512
    Top = 112
  end
  inherited Qry1: TQuery
    Top = 80
  end
  inherited Table1: TTable
    AfterScroll = Table1AfterScroll
    TableName = 'dbo.T1010'
    object Table1F01: TStringField
      DisplayLabel = '�ͻ����'
      FieldName = 'F01'
      OnValidate = RequiredValue
      FixedChar = True
      Size = 8
    end
    object Table1F02: TStringField
      DisplayLabel = '�ͻ�����'
      FieldName = 'F02'
      OnValidate = Table1F02Validate
      Size = 40
    end
    object Table1F03: TStringField
      DisplayLabel = '�ͻ����'
      FieldName = 'F03'
      OnValidate = Table1F03Validate
      FixedChar = True
      Size = 12
    end
    object Table1F04: TStringField
      DisplayLabel = '������'
      FieldName = 'F04'
      FixedChar = True
      Size = 8
    end
    object Table1F05: TStringField
      DisplayLabel = '�绰һ'
      FieldName = 'F05'
      FixedChar = True
      Size = 25
    end
    object Table1F06: TStringField
      DisplayLabel = '�绰��'
      FieldName = 'F06'
      Size = 25
    end
    object Table1F07: TStringField
      DisplayLabel = '����'
      FieldName = 'F07'
      FixedChar = True
      Size = 25
    end
    object Table1F08: TStringField
      DisplayLabel = '��ַ'
      FieldName = 'F08'
      Size = 60
    end
    object Table1F09: TStringField
      DisplayLabel = '�ʵ�����'
      FieldName = 'F09'
      FixedChar = True
      Size = 10
    end
    object Table1F10: TStringField
      DisplayLabel = 'E_Mail'
      FieldName = 'F10'
      Size = 40
    end
    object Table1F11: TDateTimeField
      DisplayLabel = '������ʼ����'
      FieldName = 'F11'
    end
    object Table1F12: TStringField
      DisplayLabel = '�ͻ���ַ'
      FieldName = 'F12'
      Size = 60
    end
    object Table1F13: TStringField
      DisplayLabel = '������'
      FieldName = 'F13'
      FixedChar = True
      Size = 8
    end
    object Table1F14: TStringField
      DisplayLabel = '�����˵绰'
      FieldName = 'F14'
      FixedChar = True
      Size = 25
    end
    object Table1F15: TStringField
      DisplayLabel = '�ж��绰'
      FieldName = 'F15'
      FixedChar = True
    end
    object Table1F16: TStringField
      DisplayLabel = '��Ʊ����'
      FieldName = 'F16'
    end
    object Table1F17: TStringField
      DisplayLabel = '��Ʊ̧ͷ'
      FieldName = 'F17'
      Size = 40
    end
    object Table1F18: TStringField
      DisplayLabel = '��Ʊ������'
      FieldName = 'F18'
      FixedChar = True
      Size = 8
    end
    object Table1F19: TStringField
      DisplayLabel = '��Ʊ��ַ'
      FieldName = 'F19'
      Size = 60
    end
    object Table1F20: TSmallintField
      DefaultExpression = '25'
      DisplayLabel = '������'
      FieldName = 'F20'
      OnGetText = Table1F20GetText
      OnSetText = Table1F20SetText
      OnValidate = RequiredValue
    end
    object Table1F21: TStringField
      DisplayLabel = '���ñұ�'
      FieldName = 'F21'
      OnValidate = RequiredValue
      FixedChar = True
      Size = 8
    end
    object Table1F22: TStringField
      DisplayLabel = '����˰��'
      FieldName = 'F22'
      OnValidate = RequiredValue
      FixedChar = True
      Size = 4
    end
    object Table1F23: TFloatField
      DisplayLabel = '����˰��'
      FieldName = 'F23'
      OnValidate = RequiredValue
    end
    object Table1F24: TStringField
      DisplayLabel = '���ͻ����'
      FieldName = 'F24'
      FixedChar = True
      Size = 8
    end
    object Table1BUser: TStringField
      DisplayLabel = '������'
      FieldName = 'BUser'
      FixedChar = True
      Size = 10
    end
    object Table1BTime: TDateTimeField
      DisplayLabel = '��������'
      FieldName = 'BTime'
    end
    object Table1EUser: TStringField
      DisplayLabel = '�޸���'
      FieldName = 'EUser'
      FixedChar = True
      Size = 10
    end
    object Table1ETime: TDateTimeField
      DisplayLabel = '�޸�����'
      FieldName = 'ETime'
    end
    object Table1lkSName: TStringField
      FieldKind = fkLookup
      FieldName = 'lkSName'
      LookupDataSet = DM.Q_T1010
      LookupKeyFields = 'F01'
      LookupResultField = 'F03'
      KeyFields = 'F24'
      Size = 40
      Lookup = True
    end
  end
end

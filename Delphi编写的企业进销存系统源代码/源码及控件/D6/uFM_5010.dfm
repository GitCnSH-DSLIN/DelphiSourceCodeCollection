inherited FM_5010: TFM_5010
  Left = 161
  Top = 127
  Width = 798
  Height = 522
  Hint = '���Ϲ�Ӧ������'
  Caption = '���Ϲ�Ӧ�̻�������'
  FormStyle = fsMDIChild
  Visible = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited Panel1: TPanel
    Width = 497
    Height = 451
    object Label4: TLabel [0]
      Left = 65
      Top = 84
      Width = 36
      Height = 12
      Caption = '������'
      FocusControl = DBEdit5
    end
    object Label5: TLabel [1]
      Left = 65
      Top = 115
      Width = 36
      Height = 12
      Caption = '�绰һ'
      FocusControl = DBEdit6
    end
    object Label6: TLabel [2]
      Left = 266
      Top = 115
      Width = 36
      Height = 12
      Caption = '�绰��'
      FocusControl = DBEdit7
    end
    object Label7: TLabel [3]
      Left = 65
      Top = 145
      Width = 36
      Height = 12
      Caption = '��  ��'
      FocusControl = DBEdit8
    end
    object Label8: TLabel [4]
      Left = 65
      Top = 176
      Width = 36
      Height = 12
      Caption = '��  ַ'
      FocusControl = DBEdit9
    end
    object Label9: TLabel [5]
      Left = 255
      Top = 145
      Width = 48
      Height = 12
      Caption = '�ʵ�����'
      FocusControl = DBEdit10
    end
    object Label10: TLabel [6]
      Left = 65
      Top = 207
      Width = 36
      Height = 12
      Caption = '��  ��'
      FocusControl = DBEdit11
    end
    object Label11: TLabel [7]
      Left = 29
      Top = 237
      Width = 72
      Height = 12
      Caption = '������ʼ����'
    end
    object Label13: TLabel [8]
      Left = 65
      Top = 268
      Width = 36
      Height = 12
      Caption = '������'
      FocusControl = DBEdit13
    end
    object Label14: TLabel [9]
      Left = 161
      Top = 268
      Width = 24
      Height = 12
      Caption = '�绰'
      FocusControl = DBEdit14
    end
    object Label15: TLabel [10]
      Left = 313
      Top = 268
      Width = 24
      Height = 12
      Caption = '�ֻ�'
      FocusControl = DBEdit15
    end
    object Label21: TLabel [11]
      Left = 254
      Top = 298
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
    object Label22: TLabel [12]
      Left = 53
      Top = 329
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
    object Label23: TLabel [13]
      Left = 254
      Top = 329
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
    object Label1: TLabel [14]
      Left = 18
      Top = 23
      Width = 84
      Height = 12
      Caption = '���Ϲ�Ӧ�̱��'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [15]
      Left = 260
      Top = 23
      Width = 42
      Height = 12
      Caption = '��   ��'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [16]
      Left = 17
      Top = 54
      Width = 84
      Height = 12
      Caption = '���Ϲ�Ӧ������'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel [17]
      Left = 65
      Top = 298
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
      Left = 105
      Top = 19
      Width = 144
      DataField = 'F01'
    end
    object DBEdit3: TDBEdit
      Left = 105
      Top = 50
      Width = 367
      Height = 20
      DataField = 'F02'
      DataSource = DataSource1
      TabOrder = 2
    end
    object DBEdit4: TDBEdit
      Left = 307
      Top = 19
      Width = 165
      Height = 20
      DataField = 'F03'
      DataSource = DataSource1
      TabOrder = 1
    end
    object DBEdit5: TDBEdit
      Left = 105
      Top = 80
      Width = 368
      Height = 20
      DataField = 'F04'
      DataSource = DataSource1
      TabOrder = 3
    end
    object DBEdit6: TDBEdit
      Left = 105
      Top = 111
      Width = 143
      Height = 20
      DataField = 'F05'
      DataSource = DataSource1
      TabOrder = 4
    end
    object DBEdit7: TDBEdit
      Left = 307
      Top = 111
      Width = 165
      Height = 20
      DataField = 'F06'
      DataSource = DataSource1
      TabOrder = 5
    end
    object DBEdit8: TDBEdit
      Left = 105
      Top = 141
      Width = 143
      Height = 20
      DataField = 'F07'
      DataSource = DataSource1
      TabOrder = 6
    end
    object DBEdit9: TDBEdit
      Left = 105
      Top = 172
      Width = 368
      Height = 20
      DataField = 'F08'
      DataSource = DataSource1
      TabOrder = 8
    end
    object DBEdit10: TDBEdit
      Left = 307
      Top = 141
      Width = 165
      Height = 20
      DataField = 'F09'
      DataSource = DataSource1
      TabOrder = 7
    end
    object DBEdit11: TDBEdit
      Left = 105
      Top = 203
      Width = 368
      Height = 20
      DataField = 'F10'
      DataSource = DataSource1
      TabOrder = 9
    end
    object DBEdit13: TDBEdit
      Left = 105
      Top = 264
      Width = 50
      Height = 20
      DataField = 'F13'
      DataSource = DataSource1
      TabOrder = 11
    end
    object DBEdit14: TDBEdit
      Left = 188
      Top = 264
      Width = 116
      Height = 20
      DataField = 'F14'
      DataSource = DataSource1
      TabOrder = 12
    end
    object DBEdit15: TDBEdit
      Left = 342
      Top = 264
      Width = 130
      Height = 20
      DataField = 'F15'
      DataSource = DataSource1
      TabOrder = 13
    end
    object DBEdit23: TDBEdit
      Left = 307
      Top = 325
      Width = 165
      Height = 20
      DataField = 'F23'
      DataSource = DataSource1
      TabOrder = 17
    end
    object DBComboBox1: TDBComboBox
      Left = 105
      Top = 294
      Width = 143
      Height = 20
      DataField = 'F20'
      DataSource = DataSource1
      ItemHeight = 12
      Items.Strings = (
        '25'
        '�µ�')
      TabOrder = 14
    end
    object DBDateEdit1: TDBDateEdit
      Left = 105
      Top = 233
      Width = 368
      Height = 20
      DataField = 'F11'
      DataSource = DataSource1
      NumGlyphs = 2
      TabOrder = 10
    end
    object DBComboBox2: TDBComboBox
      Left = 105
      Top = 325
      Width = 142
      Height = 20
      Style = csDropDownList
      DataField = 'F22'
      DataSource = DataSource1
      ItemHeight = 12
      Items.Strings = (
        '���'
        '�ں�'
        '��˰')
      TabOrder = 16
    end
    object RxDBComboEdit2: TRxDBComboEdit
      Left = 308
      Top = 294
      Width = 164
      Height = 20
      DataField = 'F21'
      DataSource = DataSource1
      GlyphKind = gkEllipsis
      ButtonWidth = 17
      NumGlyphs = 1
      TabOrder = 15
      OnButtonClick = RxDBComboEdit2ButtonClick
    end
  end
  inherited ToolBar1: TToolBar
    Width = 790
    inherited SB2: TSpeedButton
      Visible = True
    end
    inherited SB3: TSpeedButton
      Visible = True
    end
    inherited SB0: TSpeedButton
      Width = 60
      Caption = '���ϼ۸�'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFF333333333333000333333333
        3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
        3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
        0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
        BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
        33337777773FF733333333333300033333333333337773333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      Visible = True
      OnClick = SB0Click
    end
    inherited SB4: TSpeedButton
      Left = 618
      Width = 60
      Caption = '����ѯ��'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      Layout = blGlyphTop
      NumGlyphs = 2
      Visible = True
      OnClick = SB4Click
    end
    inherited SB6: TSpeedButton
      Left = 678
    end
  end
  inherited DBGrid1: TDBGrid
    Left = 497
    Width = 293
    Height = 451
    Columns = <
      item
        Expanded = False
        FieldName = 'F01'
        PickList.Strings = ()
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'F03'
        PickList.Strings = ()
        Width = 92
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'F05'
        PickList.Strings = ()
        Width = 111
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
    TableName = 'dbo.T5010'
    Left = 504
    Top = 144
    object Table1F01: TStringField
      DisplayLabel = '��Ӧ�̱��'
      FieldName = 'F01'
      OnValidate = RequiredValue
      FixedChar = True
      Size = 8
    end
    object Table1F02: TStringField
      DisplayLabel = '��Ӧ������'
      FieldName = 'F02'
      OnValidate = Table1F02Validate
      Size = 40
    end
    object Table1F03: TStringField
      DisplayLabel = '���'
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
  end
end

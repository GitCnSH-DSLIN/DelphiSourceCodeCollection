inherited FM_2150: TFM_2150
  Left = 110
  Top = 110
  Hint = '���Ʒί�����'
  Caption = 'ί����Ʒ���'
  FormStyle = fsMDIChild
  Visible = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited Panel1: TPanel
    Height = 108
    object Label1: TLabel [0]
      Left = 16
      Top = 12
      Width = 48
      Height = 12
      Caption = '��ⵥ��'
    end
    object Label2: TLabel [1]
      Left = 195
      Top = 12
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
    object Label3: TLabel [2]
      Left = 16
      Top = 37
      Width = 48
      Height = 12
      Caption = 'ί�⳧��'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel [3]
      Left = 353
      Top = 37
      Width = 48
      Height = 12
      Caption = '��    ��'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [4]
      Left = 16
      Top = 61
      Width = 48
      Height = 12
      Caption = '˰    ��'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel [5]
      Left = 195
      Top = 61
      Width = 42
      Height = 12
      Caption = '˰   ��'
      FocusControl = DBEdit6
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel [6]
      Left = 353
      Top = 61
      Width = 48
      Height = 12
      Caption = '˰    ��'
    end
    object Label10: TLabel [7]
      Left = 521
      Top = 12
      Width = 48
      Height = 12
      Caption = '��ϸ�ܶ�'
    end
    object Label11: TLabel [8]
      Left = 521
      Top = 37
      Width = 48
      Height = 12
      Caption = '�����ܶ�'
    end
    object Label12: TLabel [9]
      Left = 353
      Top = 12
      Width = 48
      Height = 12
      Caption = '�ʿ�����'
      FocusControl = DBEdit10
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel [10]
      Left = 16
      Top = 86
      Width = 48
      Height = 12
      Caption = '��    ע'
      FocusControl = DBEdit11
    end
    object Label4: TLabel [11]
      Left = 521
      Top = 61
      Width = 48
      Height = 12
      Caption = 'Ӧ���ܶ�'
      FocusControl = DBEdit2
    end
    inherited DBEdit1: TDBEdit
      Left = 69
      Width = 100
      Color = clInfoBk
      DataField = 'F01'
      ReadOnly = True
    end
    object DBDateEdit1: TDBDateEdit
      Left = 243
      Top = 8
      Width = 100
      Height = 21
      DataField = 'F02'
      DataSource = DataSource1
      NumGlyphs = 2
      TabOrder = 1
      OnExit = DBDateEdit1Exit
    end
    object RxDBComboEdit1: TRxDBComboEdit
      Left = 408
      Top = 33
      Width = 100
      Height = 21
      DataField = 'F04'
      DataSource = DataSource1
      GlyphKind = gkEllipsis
      ButtonWidth = 18
      NumGlyphs = 1
      TabOrder = 6
      OnButtonClick = RxDBComboEdit1ButtonClick
    end
    object DBEdit6: TDBEdit
      Left = 242
      Top = 57
      Width = 101
      Height = 20
      DataField = 'F07'
      DataSource = DataSource1
      TabOrder = 9
    end
    object DBEdit10: TDBEdit
      Left = 408
      Top = 8
      Width = 100
      Height = 20
      DataField = 'F12'
      DataSource = DataSource1
      TabOrder = 2
    end
    object DBEdit11: TDBEdit
      Left = 69
      Top = 82
      Width = 597
      Height = 20
      DataField = 'F11'
      DataSource = DataSource1
      TabOrder = 12
    end
    object DBEdit8: TDBEdit
      Left = 576
      Top = 8
      Width = 90
      Height = 20
      Color = clInfoBk
      DataField = 'CalF09'
      DataSource = DataSource1
      ReadOnly = True
      TabOrder = 3
    end
    object DBComboBox1: TDBComboBox
      Left = 69
      Top = 57
      Width = 100
      Height = 20
      DataField = 'F06'
      DataSource = DataSource1
      ItemHeight = 12
      Items.Strings = (
        '��˰'
        '���'
        '�ں�')
      TabOrder = 8
    end
    object DBEdit5: TDBEdit
      Left = 408
      Top = 57
      Width = 100
      Height = 20
      Hint = '��˰ = 0; ��� = �ں� = <��ϸ�ܶ�> * <˰��>'
      Color = clInfoBk
      DataField = 'CalF08'
      DataSource = DataSource1
      ReadOnly = True
      TabOrder = 10
    end
    object DBEdit7: TDBEdit
      Left = 576
      Top = 33
      Width = 90
      Height = 20
      Hint = '��˰ = ��� = <��ϸ�ܶ�> ; �ں� = <��ϸ�ܶ�>-<˰��>'
      Color = clInfoBk
      DataField = 'CalF10'
      DataSource = DataSource1
      ReadOnly = True
      TabOrder = 7
    end
    object RxDBComboEdit2: TRxDBComboEdit
      Left = 69
      Top = 33
      Width = 100
      Height = 21
      DataField = 'F03'
      DataSource = DataSource1
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 4
      OnButtonClick = RxDBComboEdit2ButtonClick
      OnExit = DBDateEdit1Exit
    end
    object DBEdit2: TDBEdit
      Left = 576
      Top = 57
      Width = 90
      Height = 20
      Hint = '<Ӧ����>=<˰��>+<�����ܶ�>'
      Color = clInfoBk
      DataField = 'CalPay'
      DataSource = DataSource1
      TabOrder = 11
    end
    object DBEdit4: TDBEdit
      Left = 172
      Top = 33
      Width = 171
      Height = 20
      Color = clInfoBk
      DataField = 'lkF03'
      DataSource = DataSource1
      ReadOnly = True
      TabOrder = 5
    end
  end
  inherited ToolBar1: TToolBar
    inherited SB2: TSpeedButton
      Visible = True
    end
    inherited SB3: TSpeedButton
      Visible = True
    end
  end
  inherited Panel3: TPanel
    Top = 545
    Height = 28
    Visible = False
  end
  inherited DBGrid1: TDBGrid
    Top = 152
    Width = 840
    Height = 393
    OnEditButtonClick = DBGrid1EditButtonClick
    Columns = <
      item
        Alignment = taCenter
        Color = clInfoBk
        Expanded = False
        FieldName = 'D_SN'
        PickList.Strings = ()
        ReadOnly = True
        Title.Alignment = taCenter
        Width = 19
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'F06'
        PickList.Strings = ()
        Width = 74
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'lkF01'
        PickList.Strings = ()
        ReadOnly = True
        Width = 43
        Visible = True
      end
      item
        Color = clInfoBk
        Expanded = False
        FieldName = 'lkF02'
        PickList.Strings = ()
        ReadOnly = True
        Width = 63
        Visible = True
      end
      item
        Color = clInfoBk
        Expanded = False
        FieldName = 'lkF03'
        PickList.Strings = ()
        ReadOnly = True
        Visible = True
      end
      item
        Color = clInfoBk
        Expanded = False
        FieldName = 'lkF04'
        PickList.Strings = ()
        ReadOnly = True
        Width = 63
        Visible = True
      end
      item
        Color = clInfoBk
        Expanded = False
        FieldName = 'lkF05'
        PickList.Strings = ()
        ReadOnly = True
        Width = 33
        Visible = True
      end
      item
        Color = clInfoBk
        Expanded = False
        FieldName = 'lkF07'
        PickList.Strings = ()
        ReadOnly = True
        Title.Alignment = taRightJustify
        Width = 38
        Visible = True
      end
      item
        Color = clBtnHighlight
        Expanded = False
        FieldName = 'F20'
        PickList.Strings = ()
        Title.Alignment = taRightJustify
        Width = 34
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'F07'
        PickList.Strings = ()
        Title.Font.Charset = GB2312_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = '����'
        Title.Font.Style = []
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'F03'
        PickList.Strings = ()
        Title.Alignment = taRightJustify
        Title.Font.Charset = GB2312_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = '����'
        Title.Font.Style = []
        Width = 36
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'F04'
        PickList.Strings = ()
        Title.Alignment = taRightJustify
        Title.Font.Charset = GB2312_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = '����'
        Title.Font.Style = []
        Width = 41
        Visible = True
      end
      item
        Color = clInfoBk
        Expanded = False
        FieldName = 'CalF05'
        PickList.Strings = ()
        ReadOnly = True
        Title.Alignment = taRightJustify
        Width = 61
        Visible = True
      end>
  end
  inherited Panel2: TPanel
    Left = 840
    Top = 152
    Width = 32
    Height = 393
    inherited DBVertNavigator1: TDBVertNavigator
      Width = 30
      Height = 391
    end
  end
  inherited Qry1: TQuery
    Left = 383
    Top = 264
  end
  inherited Table1: TTable
    BeforeInsert = Table1BeforeInsert
    OnCalcFields = Table1CalcFields
    TableName = 'dbo.T2150'
    Top = 232
    object Table1F01: TStringField
      DisplayLabel = '��ⵥ��'
      FieldName = 'F01'
      FixedChar = True
      Size = 12
    end
    object Table1F02: TDateTimeField
      DisplayLabel = '�������'
      FieldName = 'F02'
    end
    object Table1F03: TStringField
      DisplayLabel = 'ί�⳧��'
      FieldName = 'F03'
      OnValidate = RequiredValue
      FixedChar = True
      Size = 8
    end
    object Table1F04: TStringField
      DisplayLabel = '�ұ�'
      FieldName = 'F04'
      OnValidate = RequiredValue
      FixedChar = True
      Size = 8
    end
    object Table1F11: TStringField
      DisplayLabel = '��   ע'
      FieldName = 'F11'
      Size = 100
    end
    object Table1Buser: TStringField
      DisplayLabel = '������'
      FieldName = 'Buser'
      FixedChar = True
      Size = 10
    end
    object Table1Btime: TDateTimeField
      DisplayLabel = '����ʱ��'
      FieldName = 'Btime'
    end
    object Table1Euser: TStringField
      DisplayLabel = '�޸���'
      FieldName = 'Euser'
      FixedChar = True
      Size = 10
    end
    object Table1Etime: TDateTimeField
      DisplayLabel = '�޸�ʱ��'
      FieldName = 'Etime'
    end
    object Table1F06: TStringField
      DisplayLabel = '˰��'
      FieldName = 'F06'
      OnValidate = RequiredValue
      FixedChar = True
      Size = 4
    end
    object Table1F07: TFloatField
      DisplayLabel = '˰��'
      FieldName = 'F07'
      OnValidate = RequiredValue
    end
    object Table1F08: TFloatField
      DisplayLabel = '˰��'
      FieldName = 'F08'
    end
    object Table1F09: TFloatField
      DisplayLabel = '��ϸ�ܶ�'
      FieldName = 'F09'
    end
    object Table1F10: TFloatField
      DisplayLabel = '�����ܶ�'
      FieldName = 'F10'
    end
    object Table1F12: TStringField
      DisplayLabel = '�ʿ�����'
      FieldName = 'F12'
      OnValidate = RequiredValue
      FixedChar = True
      Size = 4
    end
    object Table1CalF08: TFloatField
      FieldKind = fkCalculated
      FieldName = 'CalF08'
      Calculated = True
    end
    object Table1CalF10: TFloatField
      FieldKind = fkCalculated
      FieldName = 'CalF10'
      Calculated = True
    end
    object Table1CalPay: TFloatField
      DisplayLabel = 'Ӧ����'
      FieldKind = fkCalculated
      FieldName = 'CalPay'
      Calculated = True
    end
    object Table1CalF09: TFloatField
      FieldKind = fkCalculated
      FieldName = 'CalF09'
      Calculated = True
    end
    object Table1lkF03: TStringField
      FieldKind = fkLookup
      FieldName = 'lkF03'
      LookupDataSet = DM.Q_T1030
      LookupKeyFields = 'F01'
      LookupResultField = 'F03'
      KeyFields = 'F03'
      Lookup = True
    end
  end
  inherited Table2: TTable
    AfterScroll = Table2AfterScroll
    OnCalcFields = Table2CalcFields
    IndexFieldNames = 'F01;D_SN'
    MasterFields = 'F01'
    TableName = 'dbo.T2150A'
    object Table2K_SN: TIntegerField
      DisplayLabel = '��ֵ��'
      DisplayWidth = 10
      FieldName = 'K_SN'
    end
    object Table2D_SN: TSmallintField
      DisplayLabel = '��'
      DisplayWidth = 10
      FieldName = 'D_SN'
      Required = True
    end
    object Table2F02: TIntegerField
      DisplayLabel = '���'
      DisplayWidth = 10
      FieldName = 'F02'
      OnValidate = RequiredValue
    end
    object Table2F03: TFloatField
      DisplayLabel = '����'
      DisplayWidth = 10
      FieldName = 'F03'
      OnChange = Table2F03Change
      OnValidate = RequiredValue
    end
    object Table2Buser: TStringField
      DisplayLabel = '������'
      DisplayWidth = 10
      FieldName = 'Buser'
      FixedChar = True
      Size = 10
    end
    object Table2F01: TStringField
      DisplayLabel = '����'
      DisplayWidth = 9
      FieldName = 'F01'
      FixedChar = True
      Size = 12
    end
    object Table2Btime: TDateTimeField
      DisplayLabel = '����ʱ��'
      DisplayWidth = 18
      FieldName = 'Btime'
    end
    object Table2Etime: TDateTimeField
      DisplayLabel = '�޸�ʱ��'
      DisplayWidth = 18
      FieldName = 'Etime'
    end
    object Table2Euser: TStringField
      DisplayLabel = '�޸���'
      DisplayWidth = 10
      FieldName = 'Euser'
      FixedChar = True
      Size = 10
    end
    object Table2F04: TFloatField
      DisplayLabel = '����'
      FieldName = 'F04'
      OnValidate = RequiredValue
    end
    object Table2F05: TFloatField
      DisplayLabel = '���'
      FieldName = 'F05'
    end
    object Table2F07: TStringField
      DisplayLabel = '���ϵ���'
      FieldName = 'F07'
      FixedChar = True
      Size = 12
    end
    object Table2F08: TStringField
      DisplayLabel = '����ԭ�ϱ��'
      FieldName = 'F08'
      FixedChar = True
      Size = 8
    end
    object Table2F09: TIntegerField
      DisplayLabel = '���ϰ��Ʒ���'
      FieldName = 'F09'
    end
    object Table2CalF05: TFloatField
      DisplayLabel = '�ܶ�'
      FieldKind = fkCalculated
      FieldName = 'CalF05'
      Calculated = True
    end
    object Table2F06: TStringField
      DisplayLabel = '�����'
      FieldName = 'F06'
      FixedChar = True
      Size = 12
    end
    object Table2F10: TStringField
      FieldName = 'F10'
      FixedChar = True
      Size = 12
    end
    object Table2lkF01: TStringField
      DisplayLabel = '�ͺ�'
      DisplayWidth = 4
      FieldKind = fkLookup
      FieldName = 'lkF01'
      LookupDataSet = DM.Q_T1080
      LookupKeyFields = 'AutoNo'
      LookupResultField = 'F01'
      KeyFields = 'F02'
      Size = 10
      Lookup = True
    end
    object Table2lkF02: TStringField
      DisplayLabel = 'Ʒ��'
      DisplayWidth = 12
      FieldKind = fkLookup
      FieldName = 'lkF02'
      LookupDataSet = DM.Q_T1080
      LookupKeyFields = 'AutoNo'
      LookupResultField = 'F02'
      KeyFields = 'F02'
      Lookup = True
    end
    object Table2lkF03: TStringField
      DisplayLabel = '����'
      DisplayWidth = 6
      FieldKind = fkLookup
      FieldName = 'lkF03'
      LookupDataSet = DM.Q_T1080
      LookupKeyFields = 'AutoNo'
      LookupResultField = 'F03'
      KeyFields = 'F02'
      Lookup = True
    end
    object Table2lkF04: TStringField
      DisplayLabel = '���'
      FieldKind = fkLookup
      FieldName = 'lkF04'
      LookupDataSet = DM.Q_T1080
      LookupKeyFields = 'AutoNo'
      LookupResultField = 'F04'
      KeyFields = 'F02'
      Lookup = True
    end
    object Table2lkF05: TStringField
      DisplayLabel = '�Ŀ�'
      DisplayWidth = 4
      FieldKind = fkLookup
      FieldName = 'lkF05'
      LookupDataSet = DM.Q_T1080
      LookupKeyFields = 'AutoNo'
      LookupResultField = 'F05'
      KeyFields = 'F02'
      Size = 5
      Lookup = True
    end
    object Table2lkF07: TFloatField
      DisplayLabel = '����'
      FieldKind = fkLookup
      FieldName = 'lkF07'
      LookupDataSet = DM.Q_T1080
      LookupKeyFields = 'AutoNo'
      LookupResultField = 'F07'
      KeyFields = 'F02'
      Lookup = True
    end
    object Table2F20: TFloatField
      DisplayLabel = '����'
      FieldName = 'F20'
      OnChange = Table2F20Change
    end
  end
  object DSum: TQuery
    DatabaseName = 'STK0311'
    DataSource = DataSource2
    SQL.Strings = (
      'select F01,sum(F05) as DSum from T2150A '
      'Where F01=:F01'
      'Group by F01'
      '')
    Left = 168
    Top = 272
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'F01'
        ParamType = ptUnknown
      end>
    object DSumDSum: TFloatField
      FieldName = 'DSum'
      Origin = 'STK0311.T2150A.F05'
    end
  end
  object DataSource3: TDataSource
    DataSet = DSum
    Left = 128
    Top = 272
  end
end

inherited FM_1100: TFM_1100
  Left = 435
  Top = 145
  Width = 361
  Height = 473
  Hint = '�ұ��趨'
  Caption = '�ұ��趨'
  FormStyle = fsMDIChild
  Visible = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited ToolBar1: TToolBar
    Width = 353
    inherited DBNavPlus1: TDBNavPlus
      Width = 180
      VisibleButtons = [nbInsert, nbDelete, nbPost, nbCancel]
    end
    inherited SB1: TSpeedButton
      Left = 180
    end
    inherited SB2: TSpeedButton
      Left = 228
    end
    inherited SB3: TSpeedButton
      Left = 276
    end
    inherited SB0: TSpeedButton
      Left = 324
    end
    inherited SB4: TSpeedButton
      Left = 328
    end
    inherited SB6: TSpeedButton
      Left = 332
      Width = 48
      Caption = '��  ��'
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Width = 353
    Height = 402
    inherited DBGrid1: TDBGrid
      Width = 351
      Height = 400
      Columns = <
        item
          Expanded = False
          FieldName = 'F01'
          PickList.Strings = ()
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -12
          Title.Font.Name = '����'
          Title.Font.Style = []
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'F02'
          PickList.Strings = ()
          Title.Alignment = taRightJustify
          Title.Caption = '�ο�����'
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -12
          Title.Font.Name = '����'
          Title.Font.Style = []
          Width = 140
          Visible = True
        end>
    end
  end
  inherited DataSource1: TDataSource
    Left = 192
    Top = 184
  end
  inherited Qry1: TQuery
    Left = 48
    Top = 152
  end
  inherited Table1: TTable
    AfterScroll = Table1AfterScroll
    AutoRefresh = True
    IndexName = 'PK_T1100'
    TableName = 'dbo.T1100'
    Left = 112
    Top = 224
    object Table1F01: TStringField
      DisplayLabel = '�ұ�'
      FieldName = 'F01'
      OnValidate = RequiredValue
      EditMask = '>cccccccc'
      FixedChar = True
      Size = 8
    end
    object Table1F02: TFloatField
      DisplayLabel = '��������'
      FieldName = 'F02'
      OnValidate = MoreThanZero
    end
    object Table1BUSER: TStringField
      FieldName = 'BUSER'
      FixedChar = True
      Size = 10
    end
    object Table1BTIME: TDateTimeField
      FieldName = 'BTIME'
    end
    object Table1EUSER: TStringField
      FieldName = 'EUSER'
      FixedChar = True
      Size = 10
    end
    object Table1ETIME: TDateTimeField
      FieldName = 'ETIME'
    end
  end
end

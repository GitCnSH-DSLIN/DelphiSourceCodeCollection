inherited FM_1060: TFM_1060
  Left = 125
  Top = 116
  Hint = '���ϲ�'
  Caption = '���ϲֿ�'
  FormStyle = fsMDIChild
  Visible = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited ToolBar1: TToolBar
    inherited SB2: TSpeedButton
      Visible = True
    end
    inherited SB3: TSpeedButton
      Visible = True
    end
  end
  inherited Panel1: TPanel
    inherited DBGrid1: TDBGrid
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
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'F02'
          PickList.Strings = ()
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -12
          Title.Font.Name = '����'
          Title.Font.Style = []
          Width = 137
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'F03'
          PickList.Strings = ()
          Width = 137
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'F09'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Width = 46
          Visible = True
        end
        item
          Color = clInfoBk
          Expanded = False
          FieldName = 'F04'
          PickList.Strings = ()
          ReadOnly = True
          Title.Alignment = taRightJustify
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -12
          Title.Font.Name = '����'
          Title.Font.Style = []
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'F05'
          PickList.Strings = ()
          Title.Alignment = taRightJustify
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -12
          Title.Font.Name = '����'
          Title.Font.Style = []
          Width = 62
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'F06'
          PickList.Strings = (
            '����'
            '����')
          Title.Alignment = taRightJustify
          Width = 56
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'F07'
          PickList.Strings = ()
          Title.Alignment = taRightJustify
          Title.Caption = '�ο�����'
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -12
          Title.Font.Name = '����'
          Title.Font.Style = []
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'F08'
          PickList.Strings = ()
          Width = 170
          Visible = True
        end>
    end
  end
  inherited Qry1: TQuery
    Left = 480
    Top = 136
  end
  inherited Table1: TTable
    Active = True
    AfterScroll = Table1AfterScroll
    TableName = 'dbo.T1060'
    Left = 472
    Top = 96
    object Table1F01: TStringField
      DisplayLabel = '���ϱ��'
      FieldName = 'F01'
      OnValidate = Table1F01Validate
      FixedChar = True
      Size = 8
    end
    object Table1F02: TStringField
      DisplayLabel = 'Ʒ��'
      FieldName = 'F02'
      OnValidate = Table1F02Validate
      FixedChar = True
      Size = 40
    end
    object Table1F03: TStringField
      DisplayLabel = '���'
      FieldName = 'F03'
      FixedChar = True
      Size = 40
    end
    object Table1F04: TFloatField
      DisplayLabel = '�������'
      FieldName = 'F04'
      OnValidate = Table1F04Validate
    end
    object Table1F05: TFloatField
      DisplayLabel = '��ȫ����'
      FieldName = 'F05'
      OnValidate = Table1F05Validate
    end
    object Table1F06: TStringField
      DisplayLabel = '�ɹ���'
      FieldName = 'F06'
      FixedChar = True
      Size = 4
    end
    object Table1F07: TFloatField
      DisplayLabel = '��������'
      FieldName = 'F07'
      OnValidate = RequiredValue
    end
    object Table1F08: TStringField
      DisplayLabel = '��ע'
      FieldName = 'F08'
    end
    object Table1F09: TStringField
      DisplayLabel = '��λ'
      FieldName = 'F09'
      FixedChar = True
      Size = 6
    end
    object Table1BUSER: TStringField
      DisplayLabel = '������'
      FieldName = 'BUSER'
      FixedChar = True
      Size = 10
    end
    object Table1BTIME: TDateTimeField
      DisplayLabel = '����ʱ��'
      FieldName = 'BTIME'
    end
    object Table1EUSER: TStringField
      DisplayLabel = '�޸���'
      FieldName = 'EUSER'
      FixedChar = True
      Size = 10
    end
    object Table1ETIME: TDateTimeField
      DisplayLabel = '�޸�ʱ��'
      FieldName = 'ETIME'
    end
  end
end

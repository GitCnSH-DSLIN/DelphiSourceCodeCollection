object FM_3010: TFM_3010
  Left = 366
  Top = 284
  Width = 304
  Height = 227
  Hint = 'Ӧ�ն��ʵ���ӡ'
  Caption = 'Ӧ�ն��ʵ���ӡ'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '����'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 36
    Width = 48
    Height = 12
    Caption = '�ʿ�����'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '����'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 47
    Top = 96
    Width = 48
    Height = 12
    Caption = '�ͻ�����'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '����'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 47
    Top = 67
    Width = 48
    Height = 12
    Caption = '�ͻ����'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '����'
    Font.Style = []
    ParentFont = False
  end
  object SB6: TSpeedButton
    Left = 165
    Top = 133
    Width = 88
    Height = 25
    Hint = '�˳�������'
    Caption = '�뿪'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '����'
    Font.Style = []
    Glyph.Data = {
      EE000000424DEE0000000000000076000000280000000F0000000F0000000100
      0400000000007800000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      888080707E7E70007080880707E7E060078088000000007600808888090E0066
      6080800009901067608080999999107070808099999910006080800009901070
      60808888090F107670808888000E106660808888080FEF0760808888880EFEF0
      708088888800000000808888888888888880}
    ParentFont = False
    OnClick = SB6Click
  end
  object SB2: TSpeedButton
    Left = 40
    Top = 133
    Width = 88
    Height = 25
    Hint = '��ӡ����'
    BiDiMode = bdLeftToRight
    Caption = '��ӡ'
    Glyph.Data = {
      4E010000424D4E01000000000000760000002800000012000000120000000100
      040000000000D800000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      77777700000077777777777777777700000070000000000007700700000070FF
      FFFFFFFF07000700000070FFFFFFF00007007700000070FFFFFF077770777700
      000070FFFFF0777E77077700000070FFFFF0777777077700000070FFFFF07E77
      77077700000070FFFFF07EE777077700000070FFFFFF077770777700000070FF
      FFFFF00007777700000070FFFFFFFFFF07777700000070FFFFFFF00007777700
      000070FFFFFFF07077777700000070FFFFFFF007777777000000700000000077
      777777000000777777777777777777000000}
    ParentBiDiMode = False
    OnClick = SB2Click
  end
  object SpinEdit1: TSpinEdit
    Left = 101
    Top = 30
    Width = 73
    Height = 21
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '����'
    Font.Style = []
    MaxValue = 3000
    MinValue = 1
    ParentFont = False
    TabOrder = 0
    Value = 2002
  end
  object ComboBox1: TComboBox
    Left = 179
    Top = 30
    Width = 68
    Height = 20
    Style = csDropDownList
    DropDownCount = 12
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '����'
    Font.Style = []
    ItemHeight = 12
    ParentFont = False
    TabOrder = 1
    Items.Strings = (
      '01'
      '02'
      '03'
      '04'
      '05'
      '06'
      '07'
      '08'
      '09'
      '10'
      '11'
      '12')
  end
  object ComboEdit1: TComboEdit
    Left = 101
    Top = 61
    Width = 146
    Height = 21
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '����'
    Font.Style = []
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    ParentFont = False
    TabOrder = 2
    OnButtonClick = ComboEdit1ButtonClick
  end
  object Edit1: TEdit
    Left = 101
    Top = 89
    Width = 146
    Height = 20
    Color = clInfoBk
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '����'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
  end
end

object frmDefDate: TfrmDefDate
  Left = 245
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Ĭ�����ڷ�Χ����'
  ClientHeight = 252
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '����'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object RadioGroup1: TRadioGroup
    Left = 18
    Top = 12
    Width = 301
    Height = 175
    Items.Strings = (
      '����'
      '����'
      '����ǰ       ��'
      '��               ��'
      '����')
    TabOrder = 0
    OnClick = RadioGroup1Click
  end
  object OKBtn: TButton
    Left = 78
    Top = 204
    Width = 82
    Height = 31
    Caption = 'ȷ��'
    Default = True
    ModalResult = 1
    TabOrder = 4
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 177
    Top = 204
    Width = 82
    Height = 31
    Cancel = True
    Caption = 'ȡ��'
    ModalResult = 2
    TabOrder = 5
    OnClick = CancelBtnClick
  end
  object edtDay: TSpinEdit
    Left = 96
    Top = 94
    Width = 43
    Height = 24
    MaxValue = 3600
    MinValue = 1
    TabOrder = 1
    Value = 1
  end
  object dtpRqa: TDateTimePicker
    Left = 66
    Top = 125
    Width = 109
    Height = 23
    CalAlignment = dtaLeft
    Date = 36703.7152945602
    Time = 36703.7152945602
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
  end
  object dtpRqb: TDateTimePicker
    Left = 198
    Top = 125
    Width = 109
    Height = 23
    CalAlignment = dtaLeft
    Date = 36703.7152945602
    Time = 36703.7152945602
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 3
  end
end

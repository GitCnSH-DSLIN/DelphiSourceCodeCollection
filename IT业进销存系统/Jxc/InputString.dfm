object frmInputString: TfrmInputString
  Left = 245
  Top = 108
  BorderStyle = bsDialog
  Caption = '����¼��'
  ClientHeight = 132
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '����'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object labPrompt: TLabel
    Left = 24
    Top = 18
    Width = 38
    Height = 15
    Caption = '����:'
  end
  object OKBtn: TButton
    Left = 66
    Top = 84
    Width = 82
    Height = 31
    Caption = 'ȷ��'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 165
    Top = 84
    Width = 82
    Height = 31
    Cancel = True
    Caption = 'ȡ��'
    ModalResult = 2
    TabOrder = 2
    OnClick = CancelBtnClick
  end
  object edtInput: TEdit
    Left = 24
    Top = 42
    Width = 265
    Height = 23
    TabOrder = 0
    Text = 'edtInput'
  end
end

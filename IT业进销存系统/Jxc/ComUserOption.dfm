object frmComUserOption: TfrmComUserOption
  Left = 140
  Top = 78
  BorderStyle = bsDialog
  Caption = '�ҵ�����'
  ClientHeight = 406
  ClientWidth = 440
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
  object OKBtn: TButton
    Left = 239
    Top = 372
    Width = 87
    Height = 28
    Anchors = [akRight, akBottom]
    Caption = 'ȷ��(&O)'
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 347
    Top = 372
    Width = 87
    Height = 28
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'ȡ��(&C)'
    ModalResult = 2
    TabOrder = 1
    OnClick = CancelBtnClick
  end
  object DefBtn: TButton
    Left = 6
    Top = 372
    Width = 87
    Height = 28
    Anchors = [akLeft, akBottom]
    Caption = 'Ĭ��ֵ'
    ModalResult = 1
    TabOrder = 2
    OnClick = DefBtnClick
  end
  object cPageControl: TPageControl
    Left = 6
    Top = 6
    Width = 427
    Height = 358
    ActivePage = cTab1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    object cTab1: TTabSheet
      Caption = '��ʾ'
      object GroupBox1: TGroupBox
        Left = 6
        Top = 6
        Width = 199
        Height = 145
        Caption = '���'
        TabOrder = 0
        object Label1: TLabel
          Left = 15
          Top = 30
          Width = 38
          Height = 15
          Caption = '����:'
          Layout = tlCenter
        end
        object Label2: TLabel
          Left = 15
          Top = 78
          Width = 38
          Height = 15
          Caption = '��ɫ:'
          Layout = tlCenter
        end
        object Bevel1: TBevel
          Left = 12
          Top = 60
          Width = 175
          Height = 7
          Shape = bsTopLine
        end
        object Bevel2: TBevel
          Left = 12
          Top = 108
          Width = 175
          Height = 7
          Shape = bsTopLine
        end
        object Panel1: TPanel
          Left = 59
          Top = 23
          Width = 92
          Height = 28
          Cursor = crHandPoint
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Caption = '����'
          Color = clWhite
          TabOrder = 0
        end
        object Button1: TButton
          Left = 150
          Top = 23
          Width = 19
          Height = 28
          Hint = '��������'
          Caption = '��'
          TabOrder = 1
        end
        object Panel2: TPanel
          Left = 59
          Top = 71
          Width = 92
          Height = 28
          Cursor = crHandPoint
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Color = clWhite
          TabOrder = 2
        end
        object Button2: TButton
          Left = 150
          Top = 71
          Width = 19
          Height = 28
          Hint = '��������'
          Caption = '��'
          TabOrder = 3
        end
        object CheckBox1: TCheckBox
          Left = 33
          Top = 120
          Width = 55
          Height = 17
          Caption = '����'
          TabOrder = 4
        end
        object CheckBox2: TCheckBox
          Left = 111
          Top = 120
          Width = 55
          Height = 17
          Caption = '����'
          TabOrder = 5
        end
      end
      object RadioGroup1: TRadioGroup
        Left = 216
        Top = 6
        Width = 199
        Height = 103
        Caption = '��Ŀ����'
        Items.Strings = (
          '��ѯ�ʣ��ٱ���'
          '��ѯ�ʣ��Զ�����'
          '��ѯ�ʣ�������')
        TabOrder = 1
      end
      object RadioGroup2: TRadioGroup
        Left = 6
        Top = 162
        Width = 199
        Height = 49
        Caption = '��������'
        Columns = 2
        Items.Strings = (
          '����'
          '������')
        TabOrder = 2
      end
      object RadioGroup3: TRadioGroup
        Left = 6
        Top = 222
        Width = 199
        Height = 49
        Caption = '������ʾ'
        Columns = 2
        Items.Strings = (
          '��ʾ'
          '����ʾ')
        TabOrder = 3
      end
    end
  end
end

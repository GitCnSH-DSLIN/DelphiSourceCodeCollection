inherited frmCgdd: TfrmCgdd
  Left = 7
  Top = 18
  Caption = '�ɹ�����'
  ClientWidth = 776
  Font.Color = clBlack
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited ControlBar1: TControlBar [0]
    Width = 776
    inherited ToolBar2: TToolBar
      Width = 80
      Align = alNone
      inherited DBNavigator1: TDBNavigator
        DataSource = Data.sCgddzb
      end
    end
  end
  inherited Panel1: TPanel [1]
    Width = 776
    inherited Label1: TLabel
      Width = 764
    end
    object Label14: TLabel [1]
      Left = 8
      Top = 404
      Width = 38
      Height = 15
      Caption = '��ע:'
    end
    inherited DBGrid1: TDBGrid
      Top = 109
      Width = 764
      Height = 258
      DataSource = Data.sCgdd
      TabOrder = 2
      TitleFont.Color = clBlack
      Columns = <
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'aBH'
          PickList.Strings = ()
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'aPM'
          PickList.Strings = ()
          ReadOnly = True
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'aDW'
          PickList.Strings = ()
          ReadOnly = True
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SL'
          PickList.Strings = ()
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DJ'
          PickList.Strings = ()
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NSL'
          PickList.Strings = ()
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cJE'
          PickList.Strings = ()
          ReadOnly = True
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'aSHSL'
          PickList.Strings = ()
          ReadOnly = True
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 367
      Width = 764
      object Label7: TLabel [1]
        Left = 602
        Top = 7
        Width = 53
        Height = 15
        Caption = '�ܽ��:'
      end
      object DBText1: TDBText [2]
        Left = 656
        Top = 5
        Width = 90
        Height = 18
        Alignment = taRightJustify
        DataField = 'JE'
        DataSource = Data.sCgddzb
      end
    end
    inherited Panel3: TPanel
      Width = 764
      Height = 80
      TabOrder = 0
      object Label4: TLabel [0]
        Left = 0
        Top = 32
        Width = 69
        Height = 15
        Caption = '�� Ӧ ��:'
      end
      object Label9: TLabel [1]
        Left = 198
        Top = 8
        Width = 70
        Height = 15
        Caption = '��    ��:'
      end
      object btnGysHelp: TSpeedButton [2]
        Left = 182
        Top = 30
        Width = 20
        Height = 18
        Hint = 'ѡ��Ӧ��'
        Caption = '��'
        ParentShowHint = False
        ShowHint = True
        OnClick = btnGysHelpClick
      end
      inherited Label2: TLabel
        Width = 70
        Caption = '��    ��:'
      end
      object Label6: TLabel [4]
        Left = 0
        Top = 56
        Width = 68
        Height = 15
        Caption = '��������:'
        FocusControl = DBEdit4
      end
      object Label8: TLabel [5]
        Left = 198
        Top = 56
        Width = 68
        Height = 15
        Caption = '�����ص�:'
        FocusControl = DBEdit8
      end
      object Label5: TLabel [6]
        Left = 420
        Top = 32
        Width = 53
        Height = 15
        Caption = 'ҵ��Ա:'
      end
      inherited DBEdit1: TDBEdit
        Left = 78
        Width = 86
        DataField = 'RQ'
        DataSource = Data.sCgddzb
      end
      object DBEdit2: TDBEdit
        Left = 78
        Top = 30
        Width = 102
        Height = 18
        BorderStyle = bsNone
        Color = cl3DLight
        DataField = 'aGYSBH'
        DataSource = Data.sCgddzb
        TabOrder = 2
        OnDblClick = btnGysHelpClick
      end
      object DBEdit7: TDBEdit
        Left = 205
        Top = 30
        Width = 175
        Height = 18
        AutoSelect = False
        BorderStyle = bsNone
        Color = cl3DLight
        DataField = 'aGYSMC'
        DataSource = Data.sCgddzb
        ReadOnly = True
        TabOrder = 3
        OnDblClick = btnGysHelpClick
      end
      object DBEdit6: TDBEdit
        Left = 278
        Top = 6
        Width = 102
        Height = 18
        AutoSelect = False
        BorderStyle = bsNone
        Color = cl3DLight
        DataField = 'DJBH'
        DataSource = Data.sCgddzb
        TabOrder = 1
      end
      object DBEdit4: TDBEdit
        Left = 78
        Top = 54
        Width = 86
        Height = 18
        BorderStyle = bsNone
        Color = cl3DLight
        DataField = 'JHRQ'
        DataSource = Data.sCgddzb
        TabOrder = 5
      end
      object DBEdit8: TDBEdit
        Left = 278
        Top = 54
        Width = 323
        Height = 18
        BorderStyle = bsNone
        Color = cl3DLight
        DataField = 'JHDD'
        DataSource = Data.sCgddzb
        TabOrder = 6
      end
      object DBComboBox1: TDBComboBox
        Left = 480
        Top = 28
        Width = 123
        Height = 23
        Color = 15793919
        DataField = 'YWY'
        DataSource = Data.sCgddzb
        ItemHeight = 15
        TabOrder = 4
      end
    end
    object DBEdit12: TDBEdit
      Left = 51
      Top = 403
      Width = 320
      Height = 18
      BorderStyle = bsNone
      Color = cl3DLight
      DataField = 'BZ'
      DataSource = Data.sCgddzb
      TabOrder = 3
    end
    object pnlZt: TPanel
      Left = 644
      Top = 15
      Width = 115
      Height = 49
      BevelOuter = bvNone
      Caption = 'pnlZt'
      ParentColor = True
      TabOrder = 4
      Visible = False
      object spZt: TShape
        Left = 0
        Top = 0
        Width = 115
        Height = 49
        Align = alClient
        Brush.Color = 15793919
        Pen.Color = clGreen
        Pen.Width = 3
        Shape = stEllipse
      end
      object labZt: TLabel
        Left = 6
        Top = 6
        Width = 103
        Height = 37
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        Caption = 'ִ�����'
        Font.Charset = GB2312_CHARSET
        Font.Color = clGreen
        Font.Height = -24
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
    object DBCheckBox1: TDBCheckBox
      Left = 648
      Top = 84
      Width = 109
      Height = 17
      Caption = '������ִֹ��'
      DataField = 'ZT'
      DataSource = Data.sCgddzb
      TabOrder = 5
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
end

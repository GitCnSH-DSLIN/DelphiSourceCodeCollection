inherited frmCgFkgc: TfrmCgFkgc
  Caption = '�ɹ����������'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited Panel1: TPanel
    object Label14: TLabel [1]
      Left = 8
      Top = 404
      Width = 38
      Height = 15
      Caption = '��ע:'
    end
    inherited DBGrid1: TDBGrid
      Top = 85
      Height = 240
      DataSource = Data.sCgFkgc
      Columns = <
        item
          Expanded = False
          FieldName = 'DJBH'
          PickList.Strings = ()
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RQ'
          PickList.Strings = ()
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ZJE'
          PickList.Strings = ()
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BCJE'
          PickList.Strings = ()
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 325
      Height = 72
      inherited Label3: TLabel
        Top = 27
      end
      inherited Shape2: TShape
        Height = 107
      end
      object DBText1: TDBText
        Left = 431
        Top = 5
        Width = 90
        Height = 18
        Alignment = taRightJustify
        DataField = 'JE'
        DataSource = Data.sCgshzb
      end
      object Label6: TLabel
        Left = 348
        Top = 7
        Width = 83
        Height = 15
        Caption = '�ɹ������:'
      end
      object Label7: TLabel
        Left = 363
        Top = 28
        Width = 68
        Height = 15
        Caption = '���ս��:'
      end
      object Label8: TLabel
        Left = 363
        Top = 49
        Width = 68
        Height = 15
        Caption = 'δ�ս��:'
      end
      object labJEA: TLabel
        Tag = 1
        Left = 431
        Top = 26
        Width = 90
        Height = 18
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'labJEA'
      end
      object labJEB: TLabel
        Tag = 1
        Left = 431
        Top = 47
        Width = 90
        Height = 18
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'labJEB'
      end
    end
    inherited Panel3: TPanel
      Height = 56
      inherited Label2: TLabel
        Left = 144
        Caption = '�ջ�����:'
      end
      object Label4: TLabel [1]
        Left = 0
        Top = 8
        Width = 38
        Height = 15
        Caption = '����:'
      end
      object Label5: TLabel [2]
        Left = 0
        Top = 32
        Width = 38
        Height = 15
        Caption = '�ͻ�:'
      end
      inherited DBEdit1: TDBEdit
        Left = 218
        Width = 102
        DataSource = Data.sCgshzb
      end
      object DBEdit2: TDBEdit
        Left = 42
        Top = 6
        Width = 86
        Height = 18
        BorderStyle = bsNone
        Color = cl3DLight
        DataField = 'RQ'
        DataSource = Data.sCgshzb
        TabOrder = 1
      end
      object DBEdit7: TDBEdit
        Left = 132
        Top = 30
        Width = 188
        Height = 18
        AutoSelect = False
        BorderStyle = bsNone
        Color = cl3DLight
        DataField = 'aGYSMC'
        DataSource = Data.sCgshzb
        ReadOnly = True
        TabOrder = 2
      end
      object DBEdit3: TDBEdit
        Left = 42
        Top = 30
        Width = 86
        Height = 18
        BorderStyle = bsNone
        Color = cl3DLight
        DataField = 'aGYSBH'
        DataSource = Data.sCgshzb
        TabOrder = 3
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
      DataSource = Data.sCgfkzb
      TabOrder = 3
    end
    object pnlZt: TPanel
      Left = 418
      Top = 29
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
        Caption = '�������'
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
  end
  inherited ControlBar1: TControlBar
    inherited ToolBar2: TToolBar
      inherited DBNavigator1: TDBNavigator
        DataSource = Data.sCgshzb
      end
    end
  end
end

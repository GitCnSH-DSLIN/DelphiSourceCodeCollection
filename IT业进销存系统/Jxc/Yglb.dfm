inherited frmYglb: TfrmYglb
  Left = -1
  Top = 95
  Caption = 'Ա�����'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited DBGrid1: TDBGrid
    DataSource = Data.sYglb
    Columns = <
      item
        Expanded = False
        FieldName = 'MC'
        PickList.Strings = ()
        Visible = True
      end>
  end
  inherited ActionList1: TActionList
    inherited aSearch: TAction
      Tag = 1
    end
  end
end

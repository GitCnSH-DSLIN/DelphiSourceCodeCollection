unit  PaintLabel;

interface

    // ---- ����Panel���� ---- //
procedure Draw_Panel_Labels(hPanel: LongWord);

implementation

uses
  Windows, Messages, PublicUnit;

    // ---- ����Panel���� ---- //
procedure Draw_Panel_Labels(hPanel: LongWord);
begin
  if (hPanel = hPanel1)then
  begin
    SetBkMode(hPanel1DC, TRANSPARENT);

    SelectObject(hPanel1DC, hSmallFont);
    TextOut(hPanel1DC, 5, 15, '�����ļ�', 8);
    TextOut(hPanel1DC, 5, 45, '���λ��', 8);
    TextOut(hPanel1DC, 5, 75, '�ָ�ߴ�', 8);

    SelectObject(hPanel1DC, hLargeFont);
    DrawState(hPanel1DC, 0, nil, Integer(PChar('www.2ccc.com')), 0, 8, 108, 0, 0, DST_TEXT or DSS_DISABLED);
  end else
  begin
    if (hPanel = hPanel2) then
    begin
      SetBkMode(hPanel2DC, TRANSPARENT);
      TextOut(hPanel2DC, 5, 15, '���λ��', 8);
    end else
      if (hPanel = hPanel3) then
      begin
        SetBkMode(hPanel3DC, TRANSPARENT);

        SelectObject(hPanel3DC, hNormalFont);
        SetTextColor(hPanel3DC, RGB(0,0,0));
        TextOut(hPanel3DC, 35, 20,  '������̳ ', 11);
        TextOut(hPanel3DC, 35, 50,  'Delphi���� ', 11);
        TextOut(hPanel3DC, 35, 80,  'Delphi԰�� ', 11);
        TextOut(hPanel3DC, 35, 110, '�ҵĿռ�^^', 10);

        SetTextColor(hPanel3DC, RGB(0, 0, 200));
        TextOut(hPanel3DC, 125, 20,  'http://www.delphibbs.com', 24);
        TextOut(hPanel3DC, 125, 50,  'http://www.2ccc.com', 19);
        TextOut(hPanel3DC, 125, 80,  'http://www.delphifans.com', 25);
        TextOut(hPanel3DC, 125, 110, 'http://Liumazi.ys168.com', 24);

        SetTextColor(hPanel3DC, RGB(200, 0, 0));
        SelectObject(hPanel3DC, hLinkerFont);
        case Mouse_Focus of  // ���λ�� ..
          1: TextOut(hPanel3DC, 125, 20, 'http://www.delphibbs.com', 24);
          2: TextOut(hPanel3DC, 125, 50, 'http://www.2ccc.com', 19);
          3: TextOut(hPanel3DC, 125, 80, 'http://www.delphifans.com', 25);
          4: TextOut(hPanel3DC, 125, 110, 'http://Liumazi.ys168.com', 24);
        end;
      end;
  end;
end;

end.

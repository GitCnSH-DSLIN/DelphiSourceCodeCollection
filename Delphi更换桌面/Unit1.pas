unit Unit1;
//Download by http://www.codefans.net
interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, registry, ExtCtrls;

type
    TForm1 = class(TForm)
        Image1: TImage;
        Button1: TButton;
        procedure Button1Click(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
    reg: Tregistry;
    TileWallpaper, WallpaperStyle: string;
begin
    reg := Tregistry.create;
    Image1.Picture.Bitmap.SaveToFile('c:\winnt\wallpaper.bmp');
    reg.rootkey := hkey_current_user; {���ø�������}
    reg.OpenKey('control panel\desktop', false);
    //��\control panel\desktop��
       {���У�
                       TileWallpaper:='0';
                       WallpaperStyle:='0';
        ƽ�̣�
                      TileWallpaper:='1';
                       WallpaperStyle:='0';  }
      // ���죺
    TileWallpaper := '0';
    WallpaperStyle := '2';

    reg.WriteString('wallpaper', 'c:\winnt\wallpaper.bmp');
    Reg.WriteString('TileWallpaper', TileWallpaper);
    Reg.WriteString('WallpaperStyle', WallpaperStyle);
    Systemparametersinfo(SPI_SETDESKWallpaper, 0, nil, Spif_SendChange);
    //֪ͨwindows����ǽֽ
    reg.CloseKey;
    Reg.Free;
end;

end.


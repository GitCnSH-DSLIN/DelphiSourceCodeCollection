unit cardin_form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls, ComCtrls, StdCtrls, Buttons, Gauges, DB,
  inifiles, ADODB, FileCtrl;
  
type 
    Tinsertdata = class(TThread)
    private 
      fb:tbutton;
    protected 
      procedure Execute; override; 
    public
      constructor create(Suspended:Boolean;button:Tbutton);
    end;
  
    
type
  Tcardin = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Bevel2: TBevel;
    Button3: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    Button5: TButton;
    GroupBox1: TGroupBox;
    RichEdit1: TRichEdit;
    TabSheet3: TTabSheet;
    Bevel3: TBevel;
    Button6: TButton;
    Bb: TButton;
    Button8: TButton;
    Gauge1: TGauge;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel4: TBevel;
    ListBox1: TListBox;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Label1: TLabel;
    Label4: TLabel;
    Button7: TButton;
    ADOTable1: TADOTable;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FileListBox1DblClick(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BbClick(Sender: TObject);
  private
    { Private declarations }
    finsert:tinsertdata;
  public
    { Public declarations }
    fcardin:string;
  end;

var
  cardin: Tcardin;

implementation
uses fmain,unit_utils;
{$R *.dfm}
constructor          ///��̿�ʼ
    Tinsertdata.create(Suspended:Boolean;button:Tbutton);
begin
    inherited Create(Suspended);
    fb:=Button;
    FreeOnTerminate:=True;
end;


procedure tinsertdata.Execute;   //...���̵߳���
begin
  fb.OnClick(self);
end;

procedure Tcardin.Button2Click(Sender: TObject);
begin
  close
end;

procedure Tcardin.Button1Click(Sender: TObject);
begin
if listbox1.Items.Text='' then
  begin
    MessageBox(handle,'��ѡ���ļ�������ļ������ڣ�','����',MB_ICONERROR or MB_OK);
    exit;
  end;
{if FileExists(edit1.Text)=false then
  begin
    showmessage('�����ļ������ڻ��ߴ���������ѡ��');
    exit;
  end;  }
richedit1.Lines.LoadFromFile(listbox1.Items.Strings[0]);
tabsheet1.Visible:=false;
tabsheet2.Visible:=true;
end;

procedure Tcardin.Button5Click(Sender: TObject);
begin
tabsheet2.Visible:=false;
tabsheet1.Visible:=true;
end;

procedure Tcardin.Button6Click(Sender: TObject);
begin
//finsert.Terminate;
tabsheet3.Visible:=false;
tabsheet2.Visible:=true;
button7.Enabled:=true;
button8.Caption:='ȡ��';
Gauge1.Progress:=0;
end;

procedure Tcardin.Button3Click(Sender: TObject);
begin
if richedit1.Text='' then
  begin
    MessageBox(handle,'�����ļ�û�����ݣ��뷵����һ������ѡ��','����',MB_ICONERROR or MB_OK);
    exit;
  end;
tabsheet2.Visible:=false;
tabsheet3.Visible:=true;
  self.Label1.Caption:='��Ҫ���� '+inttostr(self.ListBox1.Count)+' ҳ����';
  self.Label4.Caption:='����';
end;

procedure Tcardin.FormShow(Sender: TObject);
var
  MailIni: TIniFile;
begin
  Gauge1.AddProgress(0-Gauge1.Progress);
  tabsheet1.Visible:=true;
  tabsheet2.Visible:=false;
  tabsheet3.Visible:=false;
  MailIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  with MailIni do
  begin
    self.DriveComboBox1.Text := ReadString('input', 'driver', '');
    self.DirectoryListBox1.Directory:=readstring('input','root','');
  end;
  MailIni.Free;
  self.Button1.SetFocus;
end;

procedure Tcardin.FileListBox1DblClick(Sender: TObject);
begin
listbox1.Items.Insert(listbox1.Count,filelistbox1.Items.Strings[filelistbox1.ItemIndex]);
end;

procedure Tcardin.ListBox1DblClick(Sender: TObject);
begin
listbox1.DeleteSelected;
end;

procedure Tcardin.Button7Click(Sender: TObject);
begin
  self.Button6.Enabled:=false;
  finsert:= Tinsertdata.create(false,bb);
end;

procedure Tcardin.FormDestroy(Sender: TObject);
begin
  if self.fcardin='1' then
    finsert.Terminate;
end;

procedure Tcardin.FormCreate(Sender: TObject);
begin
  self.fcardin:='0';
end;

procedure Tcardin.BbClick(Sender: TObject);
var i,ib,l:integer;
    templine:String; {�ı��ļ��е�һ������}
	  j:Integer;    {j:�ı��ļ��к�}
    inini:tinifile;
    searchtext:string;
    name,ename,sex,idnum,telphone,address,email,intime:string;
begin
  self.Button7.Enabled:=false;
  label4.Visible:=true;
  if self.ADOTable1.Active<>true then
    self.ADOTable1.Active:=true;
    i:=0;
    self.fcardin:='1';
  for ib:=0 to listbox1.Count-1 do
    begin
      richedit1.Clear;
      richedit1.Lines.LoadFromFile(listbox1.Items.Strings[ib]);
      self.Label4.Caption:='Ŀǰ���ڵ���� '+inttostr(ib)+' ҳ����';
      //////////////////////////////////
      j:=0;
        repeat
          richedit1.Lines[j];
          l:=richedit1.Lines.Count;
          j:=j+1;
	      until j>=RichEdit1.Lines.Count-1;
      self.Gauge1.MaxValue:=l;
      self.Gauge1.Progress:=0;
      searchtext:=',';
      //----------���¿�ʼ��������-----------//
      j:=0;
      repeat
        repeat
			    if trim(RichEdit1.Lines[j])='' then
			      begin
				      if j<RichEdit1.Lines.Count-1 then
				        begin
					        j:=j+1;
					        continue;
				        end
				        else
					        break;
            end;
          templine:=RichEdit1.Lines[j];
          name:=ReadPriorStr(templine,searchtext);
          ename:=ReadPriorStr(templine,searchtext);
          sex:=ReadPriorStr(templine,searchtext);
          idnum:=ReadPriorStr(templine,searchtext);
          telphone:=ReadPriorStr(templine,searchtext);
          address:=ReadPriorStr(templine,searchtext);
          email:=ReadPriorStr(templine,searchtext);
          intime:=trim(templine);
          //............
          try
            self.ADOTable1.append;
            self.ADOTable1.FieldByName('name').AsString:=name;
            self.ADOTable1.FieldByName('ename').AsString:=ename;
            self.ADOTable1.FieldByName('sex').AsString:=sex;
            self.ADOTable1.FieldByName('idnum').AsString:=idnum;
            self.ADOTable1.FieldByName('Telephone').AsString:=telphone;
            self.ADOTable1.FieldByName('address').AsString:=address;
            self.ADOTable1.FieldByName('email').AsString:=email;
            self.ADOTable1.FieldByName('delrecy').AsString:='0';
            self.ADOTable1.FieldByName('intime').AsString:=intime;
            self.ADOTable1.FieldByName('branchid').AsString:='-1';
            self.ADOTable1.Post;
          except
            MessageBox(handle,'�������ݲ��ɹ����������ݸ�ʽ�Ƿ���ȷ','����',MB_ICONERROR or MB_OK);
            self.Close;
          end;
          i:=i+1;
          j:=j+1;
          self.Gauge1.Progress:=j;
          self.Label4.Caption:='Ŀǰ���ڵ���� '+inttostr(ib+1)+' ҳ�� '+inttostr(j)+' ������';
		    until (j>=RichEdit1.Lines.Count-1);  {��һҳ����}
	    until j>=RichEdit1.Lines.Count;  {�������н����������ļ�����}
  end;
  self.Label4.Caption:='������ '+inttostr(ib)+' ҳ '+inttostr(j)+' ������';
  SELF.Button8.Caption:='�ر�';
  inIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  with inIni do
    begin
      WriteString('input', 'root', self.DirectoryListBox1.Directory);
      writestring('input','driver',self.DriveComboBox1.Drive);
    end;
end;

end.

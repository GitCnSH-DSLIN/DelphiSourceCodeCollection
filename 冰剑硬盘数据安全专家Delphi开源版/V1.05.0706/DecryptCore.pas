unit DecryptCore;
{
���ܺ�����
v1.0 2007/7/5
}
interface
  Uses
    StringsUnit,BLibrary,Aes,IniFiles,Dialogs;
  Function Decrypt5(BSETempPath,PassWord,DPassWord,Path:String):Boolean;
implementation
uses
  BSecurityUnit;
Function Decrypt5;
var
  A,SFile,CPassWord{��֤�����ַ���}:string;
  I:Longint;
  F:Tinifile;
begin
  F:=Tinifile.Create(BSETempPath+INIFileName);
  {������֤}
  if F.ReadBool('Pack','DiskEncrypt',False)=False
  then DPassWord:='';
  if (DPassWord='') then  {�Ƿ�����Ӳ�̼���}
  CPassWord:=EncryptString(PassWord,PassWordC,KB256) else {����������֤�ַ���}
  CPassWord:=EncryptString(DPassWord,EncryptString(PassWord,PassWordC,KB256),KB256);

  If CPassWord<>F.ReadString('PassWord','PW','No') then
  begin
  ShowBox('�������������!','����');
  Result:=false;
  Exit;
  end;
  {��֤����}
  Form1.FileListBox.FileName:=BSETempPath;
  if Form1.FileListBox.Items.Count<>0 then
  for i:=0 to Form1.FileListBox.Items.Count-1 do
  begin
    A:=Form1.FileListBox.Items.strings[i];
    if Form1.FileListBox.Items.Strings[i]<>(INIFileName){�����ļ�·��}   {������������ļ�}
    then Begin {Ӳ�̽���}
    SFile:=BSETempPath+Form1.FileListBox.Items.Strings[i];
    if (DPassWord<>'') then
    RunCore('D',SFile,DPassWord);
    RunCore2('D',SFile,Path+'\'+A,PassWord);
    end;
  end;
  Result:=True;
End;
end.

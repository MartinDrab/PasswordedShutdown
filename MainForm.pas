Unit MainForm;

Interface

Uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

Type
  TMainFrm = Class (TForm)
    MainPanel: TPanel;
    DomainEdit: TEdit;
    UserEdit: TEdit;
    PasswordEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ShutdownButton: TButton;
    RebootButton: TButton;
    ForceCheckBox: TCheckBox;
    procedure ActionButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  Private
    Procedure ErrorMessage(AFormat:WideString; AArgs:Array Of Const);
  end;

Var
  MainFrm: TMainFrm;

Implementation



Function CreateProcessWithLogonW(AUserName:PWideChar; ADomain:PWideChar; APassword:PWideChar; ALogonFlags:Cardinal; AApplicationName:PWideChar; ACommandLine:PWideChar; ACreationFlags:Cardinal; AEnvironment:Pointer; ACurrentDirectory:PWideChar; Var AStartupInfo:STARTUPINFOW; Var AProcessInfo:PROCESS_INFORMATION):LongBool; StdCall; External 'advapi32.dll';

{$R *.DFM}

Procedure TMainFrm.ErrorMessage(AFormat:WideString; AArgs:Array Of Const);
Var
  wholeMsg : WideString;
begin
wholeMsg := Format(AFormat, AArgs);
MessageBoxW(0, PWideChar(wholeMsg), 'Error', MB_OK Or MB_ICONERROR);
end;

Procedure TMainFrm.ActionButtonClick(Sender: TObject);
Var
  b : TButton;
  command : WideString;
  si : STARTUPINFOW;
  pi : PROCESS_INFORMATION;
  err : Cardinal;
begin
command := 'shutdown /t 1';
b := Sender As TButton;
Case b.Tag Of
  0 : command := command + ' /r';
  1 : command := command + ' /s';
  end;

If ForceCheckBox.Checked Then
  command := command + ' /f';

Zeromemory(@si, SizeOf(si));
si.cb := SizeOf(si);
ZeroMemory(@pi, SizeOf(pi));
If CreateProcessWithLogonW(
      PWideChar(UserEdit.Text),
      PWideChar(DomainEdit.Text),
      PWideChar(PasswordEdit.Text),
      0, Nil, PWideChar(command), 0, Nil, Nil, si, pi) Then
  begin
  CloseHandle(pi.hThread);
  CloseHandle(pi.hProcess);
  end
Else begin
  err := GetLastError;
  ErrorMessage('Error %u'#13#10'%s', [err, SysErrorMessage(err)]);
  end;
end;



procedure TMainFrm.FormCreate(Sender: TObject);
Var
  size : Cardinal;
  cnBuffer : Array [0..MAX_PATH - 1] Of WideChar;
begin
ZeroMemory(@cnBuffer, SizeOf(cnBuffer));
size := SizeOf(cnBuffer) Div SizeOf(WideChar);
If GetComputerNameW(cnBuffer, size) Then
  DomainEdit.Text := WideCharToString(cnBuffer);
end;

End.


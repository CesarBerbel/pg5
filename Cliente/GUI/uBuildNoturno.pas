unit uBuildNoturno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, CheckLst, ExtCtrls, TLHelp32, PsAPI;

type
  TCallBack = procedure of object;

  TfBuildNoturno = class(TForm)
    cklTests: TCheckListBox;
    Panel1: TPanel;
    btExecutar: TBitBtn;
    procedure btExecutarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ExecutarEAguardar(const psComando: string; pbEsconder: boolean;
      poCallBack: TCallBack = nil): boolean;
  end;

var
  fBuildNoturno: TfBuildNoturno;
  sPath: string;
  bFinalizar: boolean;

implementation

{$R *.DFM}

function TerminarProcesso(sFile: string): boolean;
var
  verSystem: TOSVersionInfo;
  hdlSnap, hdlProcess: THandle;
  bPath, bLoop: Bool;
  peEntry: TProcessEntry32;
  arrPid: array [0..1023] of DWORD;
  iC: DWord;
  k, iCount: integer;
  arrModul: array [0..299] of char;
  hdlModul: HMODULE;
begin
  result := False;
  if ExtractFileName(sFile) = sFile then
    bPath := False
  else
    bPath := True;
  verSystem.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(verSystem);
  if verSystem.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS then
  begin
    hdlSnap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    peEntry.dwSize := Sizeof(peEntry);
    bLoop := Process32First(hdlSnap, peEntry);
    while integer(bLoop) <> 0 do
    begin
      if bPath then
      begin
        if CompareText(peEntry.szExeFile, sFile) = 0 then
        begin
          TerminateProcess(OpenProcess(PROCESS_TERMINATE, False, peEntry.th32ProcessID), 0);
          result := True;
        end;
      end
      else
      begin
        if CompareText(ExtractFileName(peEntry.szExeFile), sFile) = 0 then
        begin
          TerminateProcess(OpenProcess(PROCESS_TERMINATE, False, peEntry.th32ProcessID), 0);
          result := True;
        end;
      end;
      bLoop := Process32Next(hdlSnap, peEntry);
    end;
    CloseHandle(hdlSnap);
  end
  else
  if verSystem.dwPlatformId = VER_PLATFORM_WIN32_NT then
  begin
    EnumProcesses(@arrPid, SizeOf(arrPid), iC);
    iCount := iC div SizeOf(DWORD);
    for k := 0 to Pred(iCount) do
    begin
      hdlProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, arrPid[k]);
      if (hdlProcess <> 0) then
      begin
        EnumProcessModules(hdlProcess, @hdlModul, SizeOf(hdlModul), iC);
        GetModuleFilenameEx(hdlProcess, hdlModul, arrModul, SizeOf(arrModul));
        if bPath then
        begin
          if CompareText(arrModul, sFile) = 0 then
          begin
            TerminateProcess(OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION,
              False, arrPid[k]), 0);
            result := True;
          end;
        end
        else
        begin
          if CompareText(ExtractFileName(arrModul), sFile) = 0 then
          begin
            TerminateProcess(OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION,
              False, arrPid[k]), 0);
            result := True;
          end;
        end;
        CloseHandle(hdlProcess);
      end;
    end;
  end;
end;

procedure TfBuildNoturno.btExecutarClick(Sender: TObject);
var
  sParam, sFile: string;
  i: integer;
begin
  sFile := ExtractFilePath(ParamStr(0)) + 'PG5AppTestsReports.xml';
  if FileExists(sFile) then
    DeleteFile(sFile);

  for i := 0 to cklTests.Items.Count - 1 do
  begin
    try
      Application.ProcessMessages;
      sParam := sPath + 'pg5AppTests.exe ' + cklTests.Items[i];
      ExecutarEAguardar(sParam, False);
    finally
      cklTests.Checked[i] := True;
    end;
  end;
end;

procedure TfBuildNoturno.FormCreate(Sender: TObject);
var
  sArq: string;
begin
  sPath := ExtractFilePath(Application.ExeName);
  sArq := sPath + 'TestsBuild.txt';
  cklTests.Items.LoadFromFile(sArq);
end;

function TfBuildNoturno.ExecutarEAguardar(const psComando: string; pbEsconder: boolean;
  poCallBack: TCallBack = nil): boolean;
var
  oStartupInfo: TStartupInfo;
  oProcessInformation: TProcessInformation;
  sPrograma, sFile: string;
  FSnapshotHandle: integer;
begin
  sPrograma := trim(psComando);
  FillChar(oStartupInfo, SizeOf(oStartupInfo), 0);
  with oStartupInfo do
  begin
    cb := SizeOf(TStartupInfo);
    if pbEsconder then
      wShowWindow := SW_HIDE
    else
      wShowWindow := SW_NORMAL;
  end;
  bFinalizar := False;

  result := CreateProcess(nil, PChar(sPrograma), nil, nil, True, CREATE_NO_WINDOW,
    nil, nil, oStartupInfo, oProcessInformation);
  if result then
  begin
    while WaitForSingleObject(oProcessInformation.hProcess, 10) > 0 do
    begin
      Application.ProcessMessages;
      sFile := ExtractFilePath(ParamStr(0)) + 'Finalizar.txt';
      if FileExists(sFile) or bFinalizar then
      begin
        if FileExists(sFile) then
          DeleteFile(sFile);

        FSnapshotHandle := FindWindow(PChar('TffpgMenu'), nil);
        SendMessage(FSnapshotHandle, WM_CLOSE, 0, 0);
        TerminarProcesso('pg5AppTests.exe');
      end;
    end;
    CloseHandle(oProcessInformation.hProcess);
    CloseHandle(oProcessInformation.hThread);
  end;
end;

procedure TfBuildNoturno.FormShow(Sender: TObject);
begin
  Left := 0;
  Top := 0;
  Height := Screen.Height;
  btExecutar.Click;
end;

end.


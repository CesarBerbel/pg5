// 09/11/2016  - Carlos.Gaspar - TASK: 67185
// 09/11/2016  - Yuri.Fernandes - TASK: 67185
unit ufpgAjudaTests;

interface

uses
  ufpgGUITestCase, ufpgDataModelTests, ufpgAjudaModelTests, SysUtils, uspDateUtils,
  FileCtrl, ShellAPI, Forms, Dialogs, StdCtrls, SHDocVw;

type
  TffpgAjudaTests = class(TfpgGUITestCase)
  private
    function CopiaPastas(DirFonte, DirDest: string): boolean;
    procedure TestarAjudaEhPG5;
  public
    procedure SetUp; override;
  published
    procedure CopiarPastaParaTeste;
    procedure VerificarHelpPG5;
  end;

implementation

uses
  Windows, uspVerificadorTelas, ufpgVariaveisTestesGUI;

const
  CS_DIRETORIO_ORIGEM = '\\172.23.1.21\o\saj\versoes\Envio\Help\fPG5\PG5\2016\3-março\TJSP\Webhelp';
  CS_ARQUIVO_HELP_PG5 = 'Webhelp\id_padrao_bem_vindo_PG5.htm';


function TffpgAjudaTests.CopiaPastas(DirFonte, DirDest: string): boolean;
var
  ShFileOpStruct: TShFileOpStruct;
  Wnd: integer;
  wFunc: word;
  pFrom: word;
  pTo: word;
  fFlags: word;
begin
  result := True;
  if not DirectoryExists(DirFonte) then
    result := False;
  DirFonte := DirFonte + #0;
  DirDest := DirDest + #0;
  FillChar(ShFileOpStruct, Sizeof(TShFileOpStruct), 0);
  with ShFileOpStruct do
  begin
    Wnd := Application.Handle;
    wFunc := FO_COPY;
    pFrom := PChar(DirFonte);
    pTo := PChar(DirDest);
    fFlags := FOF_ALLOWUNDO or FOF_SIMPLEPROGRESS or FOF_NOCONFIRMATION;
  end;
  ShFileOperation(ShFileOpStruct);
end;

procedure TffpgAjudaTests.SetUp;
begin
  gbErroTest := False;
  spCarregarDadosSetUp := False;
  inherited;
end;
// 09/11/2016  - Carlos.Gaspar - TASK: 67185
// 09/11/2016  - Yuri.Fernandes - TASK: 67185
procedure TffpgAjudaTests.CopiarPastaParaTeste;
begin
  gbErroTest := False;
  WinExec(PChar(ExtractFilePath(Application.ExeName) + 'Mapear_rede.bat'), SW_NORMAL);
  checkTrue(CopiaPastas(CS_DIRETORIO_ORIGEM, ExtractFilePath(Application.ExeName)),
    'Não foi possível copiar a pasta do Help');
end;

procedure TffpgAjudaTests.TestarAjudaEhPG5;
var
  TXT: textfile;
  Diretorio: string;
  Linha: string;
  bEncontrou: boolean;
begin
  bEncontrou := False;
  Diretorio := ExtractFilePath(Application.ExeName) + CS_ARQUIVO_HELP_PG5;
  AssignFile(TXT, Diretorio);
  Reset(TXT);
  try
    Readln(TXT, Linha);
    while not EOF(TXT) do
    begin
      Readln(TXT, Linha);
      if Pos('SAJ/PG5', Linha) > 0 then
      begin
        bEncontrou := True;
        Break;
      end;
    end;
  finally
    CheckTrue(bEncontrou, 'Arquivo Help inválido para PG5');
    CloseFile(TXT);
  end;
end;

procedure TffpgAjudaTests.VerificarHelpPG5;
begin
  gbErroTest := False;
  TestarAjudaEhPG5;
end;

end.


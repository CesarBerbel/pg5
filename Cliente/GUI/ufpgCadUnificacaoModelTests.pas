unit ufpgCadUnificacaoModelTests;

interface

uses
  ufpgRelDemoDistrib, ufpgModelTests, ADODB, SysUtils, FutureWindows,
  usajConstante, uspFuncoesDate;

type
  TffpgCadUnificacaoModelTests = class(TfpgModelTests)
  private
    FsNuProcessoUnificar: string;
    FsNuProcessoPrinc: string;
    FsRegistraMsgPartes: boolean;
  public
    class function VerificaProcessoUnificado(psNuProcesso: string): boolean;
  published
    property fpgNuProcessoPrinc: string read FsNuProcessoPrinc write FsNuProcessoPrinc;
    property fpgNuProcessoUnificar: string read FsNuProcessoUnificar write FsNuProcessoUnificar;
    property fpgRegistraMsgPartes: boolean read FsRegistraMsgPartes write FsRegistraMsgPartes;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgRelDemoDistribModelTests }

class function TffpgCadUnificacaoModelTests.VerificaProcessoUnificado(
  psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarProcessoUnificado(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


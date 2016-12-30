unit ufpgCadPendenciaPrazoModelTests;

interface

uses
  ufpgCadPendenciaPrazo, ufpgModelTests, ufpgFuncoesGUISQLTests, SysUtils, ufpgVariaveisTestesGUI;

type
  TffpgCadPendenciaPrazoModelTests = class(TfpgModelTests)
  private
    FsDePendencia: string;
    FsNuDias: string;
    FsNuProcesso: string;
  public
    class function ChecarPendencia(psDescPendencia, psUsuario: string): boolean;
  published
    property fpgDePendencia: string read FsDePendencia write FsDePendencia;
    property fpgNuDias: string read FsNuDias write FsNuDias;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  end;

implementation

uses
  usegRepositorio;

{ TffpgCadPendenciaPrazoModelTests }

class function TffpgCadPendenciaPrazoModelTests.ChecarPendencia(psDescPendencia, psUsuario: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarPendenciaProcesso(gsCDProcesso, psUsuario, psDescPendencia);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsString = '1';
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


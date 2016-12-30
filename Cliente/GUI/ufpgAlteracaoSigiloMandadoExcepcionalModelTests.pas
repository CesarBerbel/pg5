unit ufpgAlteracaoSigiloMandadoExcepcionalModelTests;

interface

uses
  ufpgAlteracaoSigiloMandadoExcepcional, ufpgModelTests, ufpgFuncoesGUISQLTests,
  ufpgFuncoesSQLTests, SysUtils;

type
  TffpgAlteracaoSigiloMandadoExcepcionalModelTests = class(TfpgModelTests)
  private
    fsNuProcesso: string;
    fbSigiloExterno: boolean;
    fsPoloAcesso: string;
  published
    class function VerificarSigiloExternoMandado(psSigiloExterno, psNuMandado: string): boolean;
    property fpgNuProcesso: string read fsNuProcesso write fsNuProcesso;
    property fpgSigiloExterno: boolean read fbSigiloExterno write fbSigiloExterno;
    property fpgPoloAcesso: string read fsPoloAcesso write fsPoloAcesso;
  end;

implementation

uses
  usegRepositorio;

{ TffpgAlteracaoSigiloMandadoExcepcionalModelTests }

{ TffpgAlteracaoSigiloMandadoExcepcionalModelTests }

class function TffpgAlteracaoSigiloMandadoExcepcionalModelTests.VerificarSigiloExternoMandado(
  psSigiloExterno, psNuMandado: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarSigiloExternoMandadoSQL(psSigiloExterno, psNuMandado);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


unit ufpgVincUsuProcSigilosoModelTests;

interface

uses
  ufpgModelTests, SysUtils, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

type
  TffpgVincUsuProcSigilosoModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FsUsuarioVinc: string;
    FbVincularUsuario: boolean;
  public
    class function VerificaProcessoSigiloAbsoluto(psNuProcesso, psCdUsuario: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgUsuarioVinc: string read FsUsuarioVinc write FsUsuarioVinc;
    property fpgVincularUsuario: boolean read FbVincularUsuario write FbVincularUsuario;
  end;

implementation

uses
  usegRepositorio;

class function TffpgVincUsuProcSigilosoModelTests.VerificaProcessoSigiloAbsoluto(
  psNuProcesso, psCdUsuario: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarProcessoCadastradoSigiloAbsolutoSQL(psNuProcesso, psCdUsuario);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;


end.


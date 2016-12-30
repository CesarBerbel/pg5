unit ufpgCancelamentoProcessoModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgCancelamentoProcessoModelTests = class(TfpgModelTests)

  private
    FsMotivoCancelamento: string;
    FsNuProcesso: string;
  public
    class function VerificarProcessoCancelado(psCDprocesso: string): boolean;
  published
    property fpgMotivoCancelamento: string read FsMotivoCancelamento write FsMotivoCancelamento;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  end;

implementation

uses
  usegRepositorio, SysUtils, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgCancelamentoProcessoModelTests }

class function TffpgCancelamentoProcessoModelTests.VerificarProcessoCancelado(
  psCDprocesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificaCancelamentoProcesso(psCDprocesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


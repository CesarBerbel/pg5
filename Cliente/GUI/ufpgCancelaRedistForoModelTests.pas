unit ufpgCancelaRedistForoModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgCancelaRedistForoModelTests = class(TfpgModelTests)
  private
    FbSelFilaObjeto: boolean;
    FsMotivo: string;
    FsNuProcesso: string;
  public
    class function VerificarEncaminhamentoProcesso(psCDProcesso: string): boolean;
  published
    property fpgSelFilaObjeto: boolean read FbSelFilaObjeto write FbSelFilaObjeto;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgMotivo: string read FsMotivo write FsMotivo;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, SysUtils;

class function TffpgCancelaRedistForoModelTests.VerificarEncaminhamentoProcesso(
  psCDProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificaCancelouEncaminhaOutroForo(psCDProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


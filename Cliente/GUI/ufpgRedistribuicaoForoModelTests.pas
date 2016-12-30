unit ufpgRedistribuicaoForoModelTests;

interface

uses
  ufpgModelTests, SysUtils;

type
  TffpgRedistribuicaoForoModelTests = class(TfpgModelTests)
  private
    FsMotivo: string;
    FsForoDestino: string;
    FsNuProcesso: string;
  public
    class function VerificarEncaminhamentoProcesso(psCDProcesso, psCdForoDestino: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgForoDestino: string read FsForoDestino write FsForoDestino;
    property fpgMotivo: string read FsMotivo write FsMotivo;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests;

class function TffpgRedistribuicaoForoModelTests.VerificarEncaminhamentoProcesso(
  psCDProcesso, psCdForoDestino: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificaEncaminhouOutroForo(psCDProcesso, psCdForoDestino);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


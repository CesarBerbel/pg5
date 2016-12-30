unit ufpgRecebRedistForoModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgRecebRedistForoModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FsMotivo: string;
    FsTipoDistribuicao: string;
    CdVara: string;
    FsCdForo: string;
  public
    class function VerificaForoProcesso(psCDProcesso: string; psCdForo: string): boolean;

  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgMotivo: string read FsMotivo write FsMotivo;
    property fpgTipoDistribuicao: string read FsTipoDistribuicao write FsTipoDistribuicao;
    property fpgCdVara: string read CdVara write CdVara;
    property fpgCdForo: string read FsCdForo write FsCdForo;
  end;

implementation

uses
  usegRepositorio, SysUtils, ufpgFuncoesGUISQLTests;

{ TffpgRecebRedistForoModelTests }

class function TffpgRecebRedistForoModelTests.VerificaForoProcesso(
  psCDProcesso, psCdForo: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarForoProcessoSql(psCDProcesso, psCdForo);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


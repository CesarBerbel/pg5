unit ufpgRedistribLoteVaraModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgRedistribLoteVaraModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FsCdTipoCartorio: string;
    FsVaraOriginal: string;
    fsDeMotivo: string;
    FsNovaVara: string;
    FsTipoDistribuicao: string;
    FsProcessoReferencia: string;
  public
    class function VerificarVaraProcesso(psCdVara, psCDProcesso: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgCdTipoCartorio: string read FsCdTipoCartorio write FsCdTipoCartorio;
    property fpgVaraOriginal: string read FsVaraOriginal write FsVaraOriginal;
    property fpgDeMotivo: string read FsDeMotivo write FsDeMotivo;
    property fpgNovaVara: string read FsNovaVara write FsNovaVara;
    property fpgTipoDistribuicao: string read FsTipoDistribuicao write FsTipoDistribuicao;
    property fpgProcessoReferencia: string read FsProcessoReferencia write FsProcessoReferencia;
  end;

implementation

uses
  usegRepositorio, SysUtils, ufpgFuncoesGuiSQLTests;

class function TffpgRedistribLoteVaraModelTests.VerificarVaraProcesso(
  psCdVara, psCDProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarMudouVaraSql(psCdVara, psCDProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


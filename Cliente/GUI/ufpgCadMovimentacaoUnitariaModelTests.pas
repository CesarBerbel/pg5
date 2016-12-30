unit ufpgCadMovimentacaoUnitariaModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgCadMovimentacaoUnitariaModelTests = class(TfpgModelTests)
  private
    FbAbrirDoMenu: boolean;
    FsNuProcesso: string;
    FsCdTipoMvProcesso: string;
    FbVerificarPendencia: boolean;
  public
    class function VerficarMovUnitaria(psTpMovimentacao: string; psNuProcesso: string;
      psCondicao: string = ''): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgCdTipoMvProcesso: string read FsCdTipoMvProcesso write FsCdTipoMvProcesso;
    property fpgVerificarPendencia: boolean read FbVerificarPendencia write FbVerificarPendencia;
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, SysUtils;

{ TffpgConsProcBasicaModelTests }

class function TffpgCadMovimentacaoUnitariaModelTests.VerficarMovUnitaria(psTpMovimentacao: string;
  psNuProcesso: string; psCondicao: string = ''): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarMovUnitariaSql(psTpMovimentacao, psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


unit ufpgDistribLoteModelTests;

interface

uses
  ufpgModelTests, SysUtils, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

type
  TffpgDistribLoteModelTests = class(TfpgModelTests)
  private
    FsDtInicial: string;
    FsDtFinal: string;
    FsCompetencia: string;
    FsCDForo: string;
    FsCDTipoCartorio: string;
    FsNuProcesso: string;
    FbImpEtiqueta: boolean;
  public
    class function VerificarDistribuicaoProcessos(psNuProcessos: string;
      piTotal: integer): boolean;
  published
    property fpgDtInicial: string read FsDtInicial write FsDtInicial;
    property fpgDtFinal: string read FsDtFinal write FsDtFinal;
    property fpgCompetencia: string read FsCompetencia write FsCompetencia;
    property fpgCDForo: string read FsCDForo write FsCDForo;
    property fpgCDTipoCartorio: string read FsCDTipoCartorio write FsCDTipoCartorio;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgImpEtiqueta: boolean read FbImpEtiqueta write FbImpEtiqueta;
  end;

implementation

uses
  usegRepositorio;

{ TffpgDistribLoteModelTests }

class function TffpgDistribLoteModelTests.VerificarDistribuicaoProcessos(psNuProcessos: string;
  piTotal: integer): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarDistribuicaoProcessosSql(psNuProcessos);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = piTotal;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


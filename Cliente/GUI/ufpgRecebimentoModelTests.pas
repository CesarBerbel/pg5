unit ufpgRecebimentoModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgRecebimentoModelTests = class(TfpgModelTests)
  private
    FbNuLoteRecebimento: boolean;
    FsLocalOrigem: string;
    FsNuProcesso: string;
    FsTipoCarga: string;
    FsNuLote: string;
    FsTipoLocalOrigem: string;
    FsForo: string;
    FbReceberRemessa: boolean;

  public
    class function VerificaRecebimentoNuLote(psNuLote, psCDForo: string): boolean;
  published
    property fpgTipoLocalOrigem: string read FsTipoLocalOrigem write FsTipoLocalOrigem;
    property fpgLocalOrigem: string read FsLocalOrigem write FsLocalOrigem;
    property fpgNuLote: string read FsNuLote write FsNuLote;
    property fpgTipoCarga: string read FsTipoCarga write FsTipoCarga;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgForo: string read FsForo write FsForo;
    property fpgNuLoteRecebimento: boolean read FbNuLoteRecebimento write FbNuLoteRecebimento;
    property fpgReceberRemessa: boolean read FbReceberRemessa write FbReceberRemessa;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, SysUtils;

{ TffpgRecebimentoModelTests }

class function TffpgRecebimentoModelTests.VerificaRecebimentoNuLote(psNuLote,
  psCDForo: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := ValidaRecebimentoLote(psNuLote, psCDForo);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


unit ufpgRemessaModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgRemessaModelTests = class(TfpgModelTests)

  private
    FsAdvogado: boolean;
    FbReceberAutomatico: boolean;
    FsNuprocesso: string;
    FsForo: string;
    FsTipoLocalDestino: string;
    FsTipoLocalOrigem: string;
    FsLocalDestino: string;
    FsLocalOrigem: string;
    FsConfirmaResolucao: boolean;
    FbMaisProcessos: boolean;
    FiQtdProcessos: integer;
    FsTipoMovimentacao: string;
    FsPrazo: string;

  public
    class function VerificarLoteEmitido(psNuLote, psCdForo, psCdTipoLocalDestino,
      psLocalDestino: string): integer;
  published
    property fpgTipoLocalDestino: string read FsTipoLocalDestino write FsTipoLocalDestino;
    property fpgTipoMovimentacao: string read FsTipoMovimentacao write FsTipoMovimentacao;
    property fpgTipoLocalOrigem: string read FsTipoLocalOrigem write FsTipoLocalOrigem;
    property fpgLocalOrigem: string read FsLocalOrigem write FsLocalOrigem;
    property fpgLocalDestino: string read FsLocalDestino write FsLocalDestino;
    property fpgNuprocesso: string read FsNuprocesso write FsNuprocesso;
    property fpgReceberAutomatico: boolean read FbReceberAutomatico write FbReceberAutomatico;
    property fpgQtdProcessos: integer read FiQtdProcessos write FiQtdProcessos;
    property fpgMaisProcessos: boolean read FbMaisProcessos write FbMaisProcessos;
    property fpgConfirmaResolucao: boolean read FsConfirmaResolucao write FsConfirmaResolucao;
    property fpgForo: string read FsForo write FsForo;
    property fpgPrazo: string read FsPrazo write FsPrazo;
    property fpgAdvogado: boolean read FsAdvogado write FsAdvogado;

  end;

implementation

uses
  ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, SysUtils, usegRepositorio;

{ TffpgConsProcBasicaModelTests }

class function TffpgRemessaModelTests.VerificarLoteEmitido(psNuLote, psCdForo,
  psCdTipoLocalDestino, psLocalDestino: string): integer;
  //var
  //  osegRepositorio: TesegRepositorio;
  //  sSQL: string;
begin
  result := 1;
  //  oSegRepositorio := TesegRepositorio.Create(nil);
  //  try
  //    sSQL := ValidarRemessaLote(psNuLote, psCdForo, psCdTipoLocalDestino, psLocalDestino);
  //    oSegRepositorio.SQLOpen(sSQL);
  //    result := oSegRepositorio.FieldByName('TOTAL').AsInteger;
  //  finally
  //    FreeAndNil(oSegRepositorio);
  //  end;
end;

//class function TffpgRemessaModelTests.VerificarExistenciaLote(psNuLote: string): boolean;
//var
//  osegRepositorio: TesegRepositorio;
//  sSQL: string;
//begin
//  oSegRepositorio := TesegRepositorio.Create(nil);
//  try
//    sSQL := RetornaVerificarExistenciaLote(psNuLote);
//    oSegRepositorio.SQLOpen(sSQL);
//    result := oSegRepositorio.FieldByName('EXISTE').AsInteger > 0;
//  finally
//    FreeAndNil(oSegRepositorio);
//  end;
//end;

end.


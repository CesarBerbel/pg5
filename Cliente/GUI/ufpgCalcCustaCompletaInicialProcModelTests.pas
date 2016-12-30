unit ufpgCalcCustaCompletaInicialProcModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgCalcCustaCompletaInicialProcModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FbTaxa: boolean;
    FbIntimacao: boolean;
    FbConducao: boolean;
    FsIntimacaoComplemento: string;
    FsConducaoComplemento: string;
    FsConducaoFator: string;
    FsConducaoCalculo: string;
    FsDeResumida: string;
    FsIntimacaoFator: string;
    FsConducaoKm: string;
    FsIntimacaoCalculo: string;
    FsNuCopias: string;
    FsTotalCalculo: string;
    FsAgente: string;
    FsLocalidade: string;
  public
    class function VerificarGuia(psForo, psNuGuia: string; pbBaixa: boolean): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgDeResumida: string read FsDeResumida write FsDeResumida;
    property fpgConducao: boolean read FbConducao write FbConducao;
    property fpgIntimacao: boolean read FbIntimacao write FbIntimacao;
    property fpgIntimacaoComplemento: string read FsIntimacaoComplemento 
      write FsIntimacaoComplemento;
    property fpgIntimacaoFator: string read FsIntimacaoFator write FsIntimacaoFator;
    property fpgIntimacaoCalculo: string read FsIntimacaoCalculo write FsIntimacaoCalculo;
    property fpgTaxa: boolean read FbTaxa write FbTaxa;
    property fpgConducaoKm: string read FsConducaoKm write FsConducaoKm;
    property fpgConducaoFator: string read FsConducaoFator write FsConducaoFator;
    property fpgConducaoComplemento: string read FsConducaoComplemento write FsConducaoComplemento;
    property fpgConducaoCalculo: string read FsConducaoCalculo write FsConducaoCalculo;
    property fpgNuCopias: string read FsNuCopias write FsNuCopias;
    property fpgTotalCalculo: string read FsTotalCalculo write FsTotalCalculo;
    property fpgAgente: string read FsAgente write FsAgente;
    property fpgLocalidade: string read FsLocalidade write FsLocalidade;

  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, SysUtils;

{ TffpgCalcCustaCompletaInicialProcModelTests }

class function TffpgCalcCustaCompletaInicialProcModelTests.VerificarGuia(psForo, psNuGuia: string;
  pbBaixa: boolean): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarGRJ(psForo, psNuGuia);
    if pbBaixa then
      sSQL := sSQL + ' AND DTPAGAMENTO IS NOT NULL';
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.
  

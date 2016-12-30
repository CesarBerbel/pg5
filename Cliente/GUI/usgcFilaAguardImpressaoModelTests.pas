unit usgcFilaAguardImpressaoModelTests;

interface

uses
  Classes, SysUtils, ufpgDataModelTests, ufpgConstanteSQL;

type
  TfsgcFilaAguardImpressaoModelTests = class(TfpgDataModelTests)
  private
    FbAbrirDoMenu: boolean;
    FbEmitir: boolean;
    FbVerDetalhes: boolean;
    FbReprocessar: boolean;
    FbMarcarTodos: boolean;
    FbAlterarPedido: boolean;
    FbFecharTela: boolean;
    FsNuPedido: string;
    FbDesmarcarTodos: boolean;
    FsCDSituacao: string;

  public
    class function VerificaSituacaoPedido(psNuPedido, psCdSituacao: string): boolean;
  published
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgNuPedido: string read FsNuPedido write FsNuPedido;
    property fpgMarcarTodos: boolean read FbMarcarTodos write FbMarcarTodos;
    property fpgDesmarcarTodos: boolean read FbDesmarcarTodos write FbDesmarcarTodos;

    property fpgVerDetalhes: boolean read FbVerDetalhes write FbVerDetalhes;
    property fpgReprocessar: boolean read FbReprocessar write FbReprocessar;
    property fpgAlterarPedido: boolean read FbAlterarPedido write FbAlterarPedido;
    property fpgEmitir: boolean read FbEmitir write FbEmitir;
    property fpgCDSituacao: string read FsCDSituacao write FsCDSituacao;

  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests;

{ TfsgcFilaAguardImpressaoModelTests }

class function TfsgcFilaAguardImpressaoModelTests.VerificaSituacaoPedido(
  psNuPedido, psCdSituacao: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificaSituacaoPedidoSQL(psNuPedido, psCdSituacao);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


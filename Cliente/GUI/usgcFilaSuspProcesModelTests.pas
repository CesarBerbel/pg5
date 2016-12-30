unit usgcFilaSuspProcesModelTests;

interface

uses
  Classes, SysUtils, ufpgDataModelTests, ufpgConstanteSQL;

type
  TfsgcFilaSuspProcesModelTests = class(TfpgDataModelTests)
  private
    FbAbrirDoMenu: boolean;
    FbDesmarcarTodos: boolean;
    FbVerDetalhes: boolean;
    FbProcessar: boolean;
    FbMarcarTodos: boolean;
    FbFecharTela: boolean;
    FsNuPedido: string;
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
    property fpgProcessar: boolean read FbProcessar write FbProcessar;
    property fpgCDSituacao: string read FsCDSituacao write FsCDSituacao;

  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests;

{ TfsgcFilaSuspProcesModelTests }

class function TfsgcFilaSuspProcesModelTests.VerificaSituacaoPedido(
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


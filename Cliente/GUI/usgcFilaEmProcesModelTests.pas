unit usgcFilaEmProcesModelTests;

interface

uses
  Classes, SysUtils, ufpgDataModelTests, ufpgConstanteSQL, uspClientDataSet;

type
  TfsgcFilaEmProcesModelTests = class(TfpgDataModelTests)
  private
    FbAbrirDoMenu: boolean;
    FbFecharTela: boolean;
    FbDesmarcar: boolean;
    FbMarcar: boolean;
    FsNuPedido: string;
    FbSuspender: boolean;

  public
    class function VerificaSituacaoPedido(psPedido: string): boolean;

  published
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgMarcar: boolean read FbMarcar write FbMarcar;
    property fpgDesmarcar: boolean read FbDesmarcar write FbDesmarcar;
    property fpgNuPedido: string read FsNuPedido write FsNuPedido;
    property fpgSuspender: boolean read FbSuspender write FbSuspender;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests;

{ TfsgcFilaEmProcesModelTests }


{ TfsgcFilaEmProcesModelTests }

class function TfsgcFilaEmProcesModelTests.VerificaSituacaoPedido(psPedido: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificaSituacaoPedidoSQL(psPedido);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


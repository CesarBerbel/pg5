unit uwflEncaminhaProcessoModelTests;

interface

uses
  ufpgModelTests;

type
  TfwflEncaminhaProcessoModelTests = class(TfpgModelTests)
  private
    FbAbrirDoMenu: boolean;
    FsSelecionado: string;
    FsDescricao: string;
    FsDias: string;
    FsCopiarFila: string;
    FbVariosProcessos: boolean;
    FsNuProcesso: string;
    FbFecharTela: boolean;
    FsCDFilaSQL: string;
  public
    class function VerificarFilaProcesso(psCDFila, psNuProcesso: string): boolean;
  published
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgCopiarFila: string read FsCopiarFila write FsCopiarFila;
    property fpgSelecionado: string read FsSelecionado write FsSelecionado;
    property fpgDescricao: string read FsDescricao write FsDescricao;
    property fpgDias: string read FsDias write FsDias;
    property fpgVariosProcessos: boolean read FbVariosProcessos write FbVariosProcessos;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgCDFilaSQL: string read FsCDFilaSQL write FsCDFilaSQL;
  end;

implementation

uses
  usegrepositorio, ufpgfuncoesSQLTests, SysUtils;

class function TfwflEncaminhaProcessoModelTests.VerificarFilaProcesso(
  psCDFila, psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarCopiaFila(psCdFila, psNuprocesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


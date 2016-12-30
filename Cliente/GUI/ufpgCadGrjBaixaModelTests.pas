unit ufpgCadGrjBaixaModelTests;

interface

uses
  ufpgCadGrjBaixa, ufpgModelTests, ADODB;

type
  TffpgCadGrjBaixaModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
  public
    class function VerificarGuia(psForo, psNuGuia: string; pbBaixa: boolean): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  end;

implementation

uses
  SysUtils, usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgCalcCustaCompletaInicialProcModelTests }

class function TffpgCadGrjBaixaModelTests.VerificarGuia(psForo, psNuGuia: string;
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


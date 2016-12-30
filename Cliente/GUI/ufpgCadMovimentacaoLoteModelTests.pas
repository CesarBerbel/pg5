// 28/12/2015 - cesar.almeida - SALT: 186660/23/2
// Refatoração da classe
unit ufpgCadMovimentacaoLoteModelTests;

interface

uses
  ufpgModelTests, Classes;

type
  TffpgCadMovimentacaoLoteModelTests = class(TfpgModelTests)
  private
    FsQtdProcesso: string;
    FsMagistrado: string;
    FsNuProcesso: string;
    FsLocalFisico: string;
    FsTipoMovimentacao: string;
  public
    class function ChecarMovLancadasLote(sProcessos: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgTipoMovimentacao: string read FsTipoMovimentacao write FsTipoMovimentacao;
    property fpgLocalFisico: string read FsLocalFisico write FsLocalFisico;
    property fpgMagistrado: string read FsMagistrado write FsMagistrado;
    property fpgQtdProcesso: string read FsQtdProcesso write FsQtdProcesso;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, SysUtils;

{ TffpgCadMovimentacaoLoteModelTests }

class function TffpgCadMovimentacaoLoteModelTests.ChecarMovLancadasLote(
  sProcessos: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarMovimentacaoLoteSQL(sProcessos);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('CDPROCESSO').AsInteger >= 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


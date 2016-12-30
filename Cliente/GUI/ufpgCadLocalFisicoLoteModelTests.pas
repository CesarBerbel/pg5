unit ufpgCadLocalFisicoLoteModelTests;

interface

uses
  ufpgCadLocalFisicoLote, ufpgModelTests, SysUtils;

type
  TffpgCadLocalFisicoLoteModelTests = class(TfpgModelTests)
  private
    FsCdLocalFisico: string;
    FsCdCartorio: string;
    FsComplemento: string;
    FsQtdProcesso: string;
    FsCdForo: string;
  public
    class function RetornarProcesso(psCdForo: string): string;
  published
    property fpgCdCartorio: string read FsCdCartorio write FsCdCartorio;
    property fpgCdLocalFisico: string read FsCdLocalFisico write FsCdLocalFisico;
    property fpgQtdProcesso: string read FsQtdProcesso write FsQtdProcesso;
    property fpgComplemento: string read FsComplemento write FsComplemento;
    property fpgCdForo: string read FsCdForo write FsCdForo;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgCadLocalFisicoLoteModelTests }

class function TffpgCadLocalFisicoLoteModelTests.RetornarProcesso(psCdForo: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarProcessoLocalFisicoSql(psCdForo);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('NUPROCESSO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


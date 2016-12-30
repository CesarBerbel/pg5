unit ufpgCadMultaModelTests;

interface

uses
  ufpgCadMulta, ufpgModelTests, ADODB, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, usegRepositorio, SysUtils;

type
  TffpgCadMultaModelTests = class(TfpgModelTests)
  private

    FsQtdParcelas: string;
    FsNuProcesso: string;
  public
    class function VerificarParcelaMulta(psNuProcesso, psQtdeParcela: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgQtdParcelas: string read FsQtdParcelas write FsQtdParcelas;
  end;

implementation

{ TffpgCadMultaModelTests }

class function TffpgCadMultaModelTests.VerificarParcelaMulta(psNuProcesso: string;
  psQtdeParcela: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarParcelasMulta(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsString = psQtdeParcela;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


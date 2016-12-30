unit ufpgMaterializaProcessoModelTests;

interface

uses
  ufpgModelTests, uspClientDataSet;

type
  TffpgMaterializaProcessoModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FbVaiDarMerda: boolean;
  public
    class function VerificarProcessoMaterializado(psCdProcesso: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgVaiDarMerda: boolean read FbVaiDarMerda write FbVaiDarMerda;
  end;

implementation

uses
  usegRepositorio, SysUtils, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgMaterializaProcessoModelTests }

class function TffpgMaterializaProcessoModelTests.VerificarProcessoMaterializado(
  psCdProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarProcessoMaterializado(psCDProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


unit ufpgCadCorrecaoClasseModelTests;

interface

uses
  ufpgCadCorrecaoClasse, ufpgModelTests, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, SysUtils;

type
  TffpgCadCorrecaoClasseModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FsMotivo: string;
    FsClasse: string;
    FsCompetencia: string;

  public
    FsCdProcesso: string;
    class function RetornarCorrecaoClasse(psCdprocesso: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgClasse: string read FsClasse write FsClasse;
    property fpgMotivo: string read FsMotivo write FsMotivo;
    property fpgCompetencia: string read FsCompetencia write FsCompetencia;
  end;

implementation

uses
  usegRepositorio;

class function TffpgCadCorrecaoClasseModelTests.RetornarCorrecaoClasse(
  psCdprocesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarCorrecaoClasseSql(psCdprocesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('RESULTADO').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


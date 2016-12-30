unit ufpgCadEvolucaoClasseModelTests;

interface

uses
  ufpgCadEvolucaoClasse, ufpgDataModelTests, ADODB;

type
  TffpgCadEvolucaoClasseModelTests = class(TfpgDataModelTests)
  private
    FbAbrirDoMenu: boolean;
    FsNuProcesso: string;
    FsClasse: string;
    FsCompetencia: string;
    FsMotivo: string;
  public
    class function ValidarEvolucaoClasseCompetencia(psCdProcesso, psClasse,
      psCompetencia, psUltDistribuicao: string): boolean;
  published
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgClasse: string read FsClasse write FsClasse;
    property fpgCompetencia: string read FsCompetencia write FsCompetencia;
    property fpgMotivo: string read FsMotivo write FsMotivo;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, SysUtils;

{ TffpgCadEvolucaoClasseModelTests }

class function TffpgCadEvolucaoClasseModelTests.ValidarEvolucaoClasseCompetencia(
  psCdProcesso, psClasse, psCompetencia, psUltDistribuicao: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarEvolucaoClasseCompetencia(psCdProcesso, psClasse, psCompetencia,
      psUltDistribuicao);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


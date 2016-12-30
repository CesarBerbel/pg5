unit ufpgRetificacaoProcessoModelTests;

interface

uses
  ufpgModelTests, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, SysUtils;

type
  TffpgRetificacaoProcessoModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FsClasse: string;
    FsCompetencia: string;
  public
    class function SelecionarProcessoPorSituacao(psNuProcesso: string): boolean;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgClasse: string read FsClasse write FsClasse;
    property fpgCompetencia: string read FsCompetencia write FsCompetencia;
  end;

implementation

uses
  usegRepositorio;

class function TffpgRetificacaoProcessoModelTests.SelecionarProcessoPorSituacao(
  psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarProcessoCanceladoSQL(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ENCONTROU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


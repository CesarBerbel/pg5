unit ufpgCadEvolucaoClasseTests;

interface

uses
  Classes, Controls, TestFramework, FutureWindows, uspForm, ufpgCadEvolucaoClasse,
  ufpgGUITestCase, ufpgCadEvolucaoClasseModelTests, ufpgDataModelTests;


type
  TffpgCadEvolucaoClasseTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadEvolucaoClasse;
    FoDados: TffpgCadEvolucaoClasseModelTests;
    procedure CadastrarEvolucaoClasse;
    function ValidarEvolucaoClasseCompetencia: boolean;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarCadastrarEvolucaoClasse;
  end;

implementation

uses
  Windows, Forms, uspInterface, SysUtils, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgFuncoesGUITestes;

procedure TffpgCadEvolucaoClasseTests.CadastrarEvolucaoClasse;
begin
  FoDados := TffpgCadEvolucaoClasseModelTests(spDataModelTests);

  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgCadEvolucaoClasse');

  FoTela := TffpgCadEvolucaoClasse(spTela);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  if FoDados.fpgClasse <> '' then
    EnterTextInto(FoTela.csClasse.dfCodigo, FoDados.fpgClasse, False);
  if FoDados.fpgCompetencia <> '' then
    EnterTextInto(FoTela.csCompetencia.dfCdTipoCartorio, FoDados.fpgCompetencia, False);
  if FoDados.fpgMotivo <> '' then
    EnterTextInto(FoTela.mmdeObservacao.spMemo, FoDados.fpgMotivo, False);

  spVerificadorTelas.RegistrarMensagem('A classe do processo foi alterada para*', 'OK');

  FoTela.ccCadastro.Execute(acSalvar);

  Check(ValidarEvolucaoClasseCompetencia, 'Classe/Competência do processo não foi alterada.');
end;

function TffpgCadEvolucaoClasseTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadEvolucaoClasseModelTests;
end;

procedure TffpgCadEvolucaoClasseTests.TestarCadastrarEvolucaoClasse;
begin
  ExecutarRoteiroTestes(CadastrarEvolucaoClasse);
end;

function TffpgCadEvolucaoClasseTests.ValidarEvolucaoClasseCompetencia: boolean;
begin
  result := FoDados.ValidarEvolucaoClasseCompetencia(gsCdProcesso, FoDados.fpgClasse,
    FoDados.fpgCompetencia, 'S');
end;

procedure TffpgCadEvolucaoClasseTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.


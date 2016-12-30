unit ufpgHorarioFuncVaraTests;

interface

uses
  TestFramework, ufpgGUITestCase, ufpgHorarioFuncVaraModelTests, ufpgDataModelTests,
  ufpgHorarioFuncVara, Windows;

type
  TffpgHorarioFuncVaraTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgHorarioFuncVara;
    FoDados: TffpgHorarioFuncVaraModelTests;
    procedure HorarioFuncionamento;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarHorarioFuncionamento;
  end;

implementation

uses
  uspInterface, uspGUITestCase, ufpgFuncoesTestes;

{ TffpgHoraroFuncVaraTests }

procedure TffpgHorarioFuncVaraTests.HorarioFuncionamento;
begin
  AbrirTela;
  FoTela := TffpgHorarioFuncVara(spTela);
  FoDados := TffpgHorarioFuncVaraModelTests(spDataModelTests);

  EnterTextInto(FoTela.csVara.dfcdVara, FoDados.fpgCdVara);
  EnterTextInto(FoTela.dfHrInicioFuncVara, FoDados.fpgHoraInicio);
  EnterTextInto(FoTela.dfHrFinalFuncVara, FoDados.fpgHoraFim);

  FoTela.ccCadastro.Execute(acSalvar);
  // 26/10/2016  - Carlos.Gaspar - TASK: 66977
  sleep(30000);
  CheckTrue(FoDados.ValidacaoHorarioAtendimento(FoTela.csForo.dfcdForo.PegaTexto,
    FoDados.fpgCdVara, GetAliasBase, FoDados.fpgHoraInicio),
    'Alteração no Horário de Atendimento, não foi replicada.');
end;

function TffpgHorarioFuncVaraTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgHorarioFuncVaraModelTests;
end;

procedure TffpgHorarioFuncVaraTests.TestarHorarioFuncionamento;
begin
  ExecutarRoteiroTestes(HorarioFuncionamento);
end;

end.


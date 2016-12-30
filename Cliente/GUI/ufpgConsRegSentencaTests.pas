unit ufpgConsRegSentencaTests;

interface

uses
  ufpgConsRegSentenca, ufpgGUITestCase, ufpgConsRegSentencaModelTests, ufpgDataModelTests;

type
  TffpgConsRegSentencaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgConsRegSentenca;
    FoDados: TffpgConsRegSentencaModelTests;
    procedure PreencherDados;
    procedure ConsultaRegistroSentenca;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarConsultaRegistroSentenca;
  end;

implementation

uses
  TestFrameWork, Forms, uspInterface, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests,
  usajConstante, ufpgFuncoesGUITestes;

function TffpgConsRegSentencaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgConsRegSentencaModelTests;
end;

procedure TffpgConsRegSentencaTests.TestarConsultaRegistroSentenca;
begin
  ExecutarRoteiroTestes(ConsultaRegistroSentenca);
end;

procedure TffpgConsRegSentencaTests.ConsultaRegistroSentenca;
begin
  Abrirtela;
  FoTela := TffpgConsRegSentenca(spTela);
  FoDados := TffpgConsRegSentencaModelTests(spDataModelTests);

  PreencherDados;

  FoTela.ccCadastro.Execute(acConsultar);
  Application.ProcessMessages;
  FoTela.ccCadastro.Execute(acVisualizar);
  FecharTela;
end;

procedure TffpgConsRegSentencaTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.csVara.dfcdVara, FoDados.fpgNuVara);
  EnterTextInto(FoTela.dfCodigo.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);
end;

end.


//28/04/2016 - Shirleano.Junior - Task: 43061
//Refatorado.
unit ufpgCancRegSentencaTests;

interface

uses
  ufpgCancRegSentenca, ufpgGUITestCase, ufpgCancRegSentencaModelTests, ufpgDataModelTests;

type
  TffpgCancRegSentencaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCancRegSentenca;
    FoDados: TffpgCancRegSentencaModelTests;
    procedure PreencherRegistroDeSentenca;
  protected
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCancelamentoRegistroDeSentenca;
  end;

implementation

uses
  usajConstante, ufpgFuncoesGUITestes, uspInterface, TestFrameWork;

procedure TffpgCancRegSentencaTests.TestarCancelamentoRegistroDeSentenca;
begin
  ExecutarRoteiroTestes(PreencherRegistroDeSentenca);
end;

function TffpgCancRegSentencaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCancRegSentencaModelTests;
end;

procedure TffpgCancRegSentencaTests.PreencherRegistroDeSentenca;
begin
  AbrirTela;
  FoTela := spTela as TffpgCancRegSentenca;
  FoDados := TffpgCancRegSentencaModelTests(spDataModelTests);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  check(FoDados.fpgNuProcesso = STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);
  FoTela.ccCadastro.Execute(acSalvar);
  FecharTela;
end;

end.


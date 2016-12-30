// 23/12/2015 - cesar.almeida - SALT: 186660/23/2
// Refatora��o da classe
unit ufpgMaterializaProcessoTests;

interface

uses
  ufpgMaterializaProcesso, ufpgGUITestCase, ufpgDataModelTests, ufpgMaterializaProcessoModelTests;

type
  TffpgMaterializaProcessoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgMaterializaProcesso;
    FoDados: TffpgMaterializaProcessoModelTests;
    procedure MaterializaProcesso;
    procedure ConfirmarMaterializacao;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarMaterializaProcesso;
  end;

implementation

uses
  TestFrameWork, udigConfirmacaoMaterializacao, uspInterface, ufpgFuncoesGUITestes,
  ufpgVariaveisTestesGUI, Forms, usajConstante, ufpgConstanteGUITests;

{ TffpgMaterializaProcessoTests }

procedure TffpgMaterializaProcessoTests.ConfirmarMaterializacao;
var
  oTela: TfdigConfirmacaoMaterializacao;
begin
  oTela := TfdigConfirmacaoMaterializacao(PegarTela('fdigConfirmacaoMaterializacao'));
  EnterTextInto(oTela.dfedSenha, spSenha, False);

  spVerificadorTelas.RegistrarMensagem(
    'A materializa��o do processo foi efetuada com sucesso.', 'OK');

  oTela.ccCadastro.Execute(acSelecionar);
  Application.ProcessMessages;
end;

procedure TffpgMaterializaProcessoTests.MaterializaProcesso;
begin
  AbrirTela;
  FoTela := TffpgMaterializaProcesso(spTela);
  FoDados := TffpgMaterializaProcessoModelTests(spDataModelTests);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  checkTrue(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'N�mero de Processo n�o encontrado');

  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  application.ProcessMessages;
  FoTela.ccCadastro.Execute(acSalvar);
  ConfirmarMaterializacao;
  FoDados.fpgNuProcesso := STRING_INDEFINIDO;
  FecharTela;
  checkTrue(FoDados.VerificarProcessoMaterializado(gsCdProcesso), 'O processo ' +
    FoDados.fpgNuProcesso + ' + n�o foi materializado');
end;

function TffpgMaterializaProcessoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgMaterializaProcessoModelTests;
end;

procedure TffpgMaterializaProcessoTests.TestarMaterializaProcesso;
begin
  ExecutarRoteiroTestes(MaterializaProcesso);
end;

end.


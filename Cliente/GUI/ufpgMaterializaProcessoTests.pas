// 23/12/2015 - cesar.almeida - SALT: 186660/23/2
// Refatoração da classe
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
    'A materialização do processo foi efetuada com sucesso.', 'OK');

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
  checkTrue(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  application.ProcessMessages;
  FoTela.ccCadastro.Execute(acSalvar);
  ConfirmarMaterializacao;
  FoDados.fpgNuProcesso := STRING_INDEFINIDO;
  FecharTela;
  checkTrue(FoDados.VerificarProcessoMaterializado(gsCdProcesso), 'O processo ' +
    FoDados.fpgNuProcesso + ' + não foi materializado');
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


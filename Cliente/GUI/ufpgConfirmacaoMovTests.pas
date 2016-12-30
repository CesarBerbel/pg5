// 05/01/2016 - cesar.almeida - SALT: 186660/23/2
unit ufpgConfirmacaoMovTests;

interface

uses
  ufpgConfirmacaoMov, ufpgGUITestCase, ufpgConfirmacaoMovModelTests, ufpgDataModelTests,
  ufpgVariaveisTestesGUI;

type
  TffpgConfirmacaoMovTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgConfirmacaoMov;
    FoDados: TffpgConfirmacaoMovModelTests;
    procedure ConfirmacaoMovimentacao;
    procedure PreencherDados;
    procedure ConfirmarMovi;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure SetUp; override;
  published
    procedure TestarConfirmacaoMovimentacao;
  end;

implementation

uses
  TestFrameWork, Forms, uspInterface, SysUtils, ufpgConstanteGUITests,
  ufpgFuncoesGUITestes, usajConstante;

var
  sDataMov: string;
  sCodMov: string;
  sMagistrado: string;
  sComplemento: string;
  bDocIgual: boolean;

{ TffpgConfirmacaoMovTests }

function TffpgConfirmacaoMovTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgConfirmacaoMovModelTests;
end;

procedure TffpgConfirmacaoMovTests.ConfirmacaoMovimentacao;
begin
  AbrirTela;
  FoDados := TffpgConfirmacaoMovModelTests(spDataModelTests);
  FoTela := TffpgConfirmacaoMov(spTela);

  PreencherDados;

  FoTela.dxbbBotoesConsultar.Click;
  Application.ProcessMessages;

  if FoDados.fpgVerificarDadosMov then
  begin
    bDocIgual := (sDataMov = FoTela.rowDataMovimentacao.Text) and
      (sCodMov = FoTela.rowMovimentacao.Items[0].Row.EditText) and
      (sMagistrado = FoTela.rowMagistrado.Items[0].Row.EditText) and
      (sComplemento = FoTela.rowComplementoMovimentacao.Text);

    checkTrue(bDocIgual, 'A Movimentação não é igual');
  end;

  ConfirmarMovi;

  FecharTela;
  check(FoDados.ChecarMovimentacao(quotedStr(FoDados.fpgNuProcesso)),
    'A Movimentacao foi confirmada');
end;

procedure TffpgConfirmacaoMovTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.sajNumeroProcessoParametrosPesquisa.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcesso, False);
end;

procedure TffpgConfirmacaoMovTests.TestarConfirmacaoMovimentacao;
begin
  ExecutarRoteiroTestes(ConfirmacaoMovimentacao);
end;

procedure TffpgConfirmacaoMovTests.ConfirmarMovi;
begin
  FoTela.pbTodos.Click;
  application.ProcessMessages;
  spVerificadorTelas.RegistrarMensagem(
    'Deseja realmente confirmar a movimentação para o(s) documento(s) selecionado(s)?', 'Sim');
  FoTela.dxbbBotoesSalvar.Click;
end;

procedure TffpgConfirmacaoMovTests.SetUp;
begin
  if gsCliente = CS_CLIENTE_PG5_TJSC then
    spNomeMenuItem := 'imfggpConfirmacaoMovSC';
  inherited;
end;

end.


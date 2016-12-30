//28/04/2016 - Shirleano.Junior - Task: 43059
//Refatorado.
unit ufpgCancelamentoTests;

interface

uses
  ufpgCancelamento, ufpgCancelamentoModelTests, ufpgGUITestCase, ufpgDataModelTests;


type
  TffpgCancelamentoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCancelamento;
    FoDados: TffpgCancelamentoModelTests;
    procedure RealizarCancelamento;
    procedure PreencherDadosCancelamento;
    procedure ConfirmarCancelamento;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarRealizarCancelamento;

  end;

implementation

uses
  TestFrameWork, ufpgVariaveisTestesGUI, ufpgFuncoesGUITestes, FutureWindows,
  ucgoConfirmacao, usajConstante, SysUtils, uspInterface;

{ TffpgCancelamentoTests }

function TffpgCancelamentoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCancelamentoModelTests;
end;

procedure TffpgCancelamentoTests.PreencherDadosCancelamento;
begin
  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  if FoDados.fpgPreencherNuLote then
  begin
    if FoDados.fpgNulote <> STRING_INDEFINIDO then
      EnterTextInto(FoTela.csLote.dfnuLote, FoDados.fpgNulote, False)
    else
      EnterTextInto(FoTela.csLote.dfnuLote, copy(gsNuLote, 5, Length(gsNuLote) - 1), False);
  end
  else
    EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);


  EnterTextInto(FoTela.cbTipoCarga, FoDados.fpgTipoCarga);

end;

procedure TffpgCancelamentoTests.RealizarCancelamento;
begin
  AbrirTela;
  FoTela := TffpgCancelamento(spTela);
  FoDados := TffpgCancelamentoModelTests(spDataModelTests);
  spVerificadorTelas.RegistrarMensagem('A carga foi cancelada com sucesso.', 'OK');

  PreencherDadosCancelamento;
  FoTela.pbCancelar.Click;
  ConfirmarCancelamento;
  //  Check(FoDados.VerificarProcessoCancelamento(gsNuLote, FoDados.fpgnuprocesso,
  //    FoDados.fpgTpLocalDestino), 'O cancelamento da carga do processo ' +
  //    FoDados.fpgNuProcesso + ' não foi efetuada.');
end;

procedure TffpgCancelamentoTests.ConfirmarCancelamento;
var
  oTelaCancelamento: TfcgoConfirmacao;
begin
  oTelaCancelamento := PegarTela('fcgoConfirmacao') as TfcgoConfirmacao;
  EnterTextInto(oTelaCancelamento.dfedSenha, spSenha);
  oTelaCancelamento.ccCadastro.Execute(acSelecionar);
end;

procedure TffpgCancelamentoTests.TestarRealizarCancelamento;
begin
  ExecutarRoteiroTestes(RealizarCancelamento);
end;

procedure TffpgCancelamentoTests.TearDown;
begin
  Fechartela;
  inherited;
end;

end.


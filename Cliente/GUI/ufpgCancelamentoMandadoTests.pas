unit ufpgCancelamentoMandadoTests;

interface

uses
  ufpgGUITestCase, ufpgCancelamentoMandadoModelTests, FutureWindows, ufpgCancelamentoMandado,
  ufpgDataModelTests;

type
  TffpgCancelamentoMandadoTests = class(TfpgGUITestCase)
  private
    FoDados: TffpgCancelamentoMandadoModelTests;
    FoTela: TffpgCancelamentoMandado;
    FsNuMandado: string;
    procedure CancelamentoMandado;
    procedure PreencherCancelamento;
    procedure ConfirmaExclusao(const poWindow: IWindow);
    //    procedure SelecionarNaGrid(const poWindow: IWindow);
  protected
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  public
    procedure TearDown; override;
    property fpgNuMandado: string read FsNuMandado write FsNuMandado;
  published
    procedure TestarCancelamentoMandado;
  end;

implementation

uses
  uspInterface, usmdSelecionaMandado, ufpgConstanteGUITests, ufpgFuncoesGUITestes,
  ufpgConfirmacaoExclusao;

procedure TffpgCancelamentoMandadoTests.TestarCancelamentoMandado;
begin
  ExecutarRoteiroTestes(CancelamentoMandado);
end;

{Comentado para caso precise selecionar um manbdado específico em processos com mais de um mandado
procedure TffpgAlteracaoFormaPgtoTests.SelecionarNaGrid(const poWindow: IWindow);
var
  oSelecionaMandado: TfsmdSelecionaMandado;
begin
  oSelecionaMandado := TfsmdSelecionaMandado(TspForm(poWindow.AsControl));
  oSelecionaMandado.grFiltro.spEncolhida := False;
  oSelecionaMandado.grFiltro.SelectedIndex := 0;
  EnterTextInto(oSelecionaMandado.grFiltro, FsNuMandado);
  if oSelecionaMandado.grDados.Fields[0].AsString = FsNuMandado then
    oSelecionaMandado.ccCadastro.Execute(acSelecionar);
end;}

procedure TffpgCancelamentoMandadoTests.PreencherCancelamento;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.smdNumeroMandado.sajNumeroProcesso.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcesso, False);

  FoTela.mmJustificativa.Lines.Text := FoDados.fpgJustificativa;
end;

function TffpgCancelamentoMandadoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCancelamentoMandadoModelTests;
end;

procedure TffpgCancelamentoMandadoTests.CancelamentoMandado;
var
  sCDMandado: string;
begin
  AbrirTela;
  FoTela := TffpgCancelamentoMandado(spTela);
  FoDados := (spDataModelTests) as TffpgCancelamentoMandadoModelTests;

  PreencherCancelamento;

  sCDMandado := FoTela.smdNumeroMandado.smdCodigoObjetoMandado;

  spVerificadorTelas.RegistrarMensagem(
    'Deseja tornar sem efeito o documento vinculado ao mandado?', '&SIM');
  spVerificadorTelas.RegistrarMensagem('O mandado foi cancelado com sucesso.', 'OK');

  TFutureWindows.Expect('TffpgConfirmacaoExclusao').ExecProc(ConfirmaExclusao);
  FoTela.ccCadastro.Execute(acSalvar);

  check(FoDados.VerificarCancelamentoMandado(sCDMandado, FoDados.fpgCDSituacao),
    'O mandado ' + FoTela.smdNumeroMandado.smdNumeroMandado + ' não foi cancelado');
end;

procedure TffpgCancelamentoMandadoTests.TearDown;
begin
    FecharTela;
  inherited;
end;

procedure TffpgCancelamentoMandadoTests.ConfirmaExclusao(const poWindow: IWindow);
var
  oTelaExclusao: TffpgConfirmacaoExclusao;
begin
  oTelaExclusao := (poWindow.AsControl) as TffpgConfirmacaoExclusao;
  EnterTextInto(oTelaExclusao.dfedSenha, spSenha);
  EnterTextInto(oTelaExclusao.cbCertificados, FoDados.fpgCertificado);
  oTelaExclusao.ccCadastro.Execute(acSelecionar);
end;

end.


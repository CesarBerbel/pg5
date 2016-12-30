//27/04/2016 - Shirleano.Junior - Task: 43059
// Refatorado.
unit ufpgCadMovimentacaoUnitariaTests;

interface

uses
  ufpgGUITestCase, ufpgCadMovimentacaoUnitariaGUIModelTests, ufpgCadMovimentacaoUnitaria,
  FutureWindows, ufpgDataModelTests;


type
  TffpgCadMovimentacaoUnitariaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadMovimentacaoUnitaria;
    FoDados: TffpgCadMovimentacaoUnitariaGUIModelTests;
    procedure CadastrarMovUnitaria;
    procedure ExcluirMovimentacao;
    procedure PreencherDadosMovUnitaria;
    procedure PreencherData;
    procedure PegarTelaPendencia(const poWindow: IWindow);
    procedure FecharTelaMemoEvento(const poWindow: IWindow);
    procedure PegarTelaDependente(const poWindow: IWindow);
    procedure VisualizarDocumento;
    procedure VerificarMovimentacao;
    procedure DesvincularDocumento;

    function VerificarMovimentacaoGrid: boolean;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadastrarMovUnitaria;
    procedure TestarVerificarMovUnitaria;
    procedure TestarExcluirMovUnitaria;
    procedure TestarVisualizarDocumento;
    procedure TestarDesvincularDocumento;

  end;


implementation

uses
  uspAplicacao, ufpgAssistente, ufpgFuncoesGUITestes, ufpgVariaveisTestesGUI,
  usajSelecionaDependentes, uspInterface, usajConstante, uwflDemoEvento,
  ufpgVisualizarModeloOuDocumento, Forms, SysUtils;

{ TffpgCadMovimentacaoUnitariaTests }

procedure TffpgCadMovimentacaoUnitariaTests.CadastrarMovUnitaria;
begin
  FoDados := TffpgCadMovimentacaoUnitariaGUIModelTests(spDataModelTests);

  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgCadMovimentacaoUnitaria');

  FoTela := TffpgCadMovimentacaoUnitaria(spTela);

  PreencherDadosMovUnitaria;

  TFutureWindows.Expect('TfwflDemoEvento', 1000).ExecProc(FecharTelaMemoEvento);

  FoTela.ccCadastro.Execute(acSalvar);

  Check(FoDados.VerficarMovUnitaria(FoDados.fpgCdTipoMvProcesso, FoDados.fpgNuProcesso),
    'Movimenta��o ' + FoDados.fpgCdTipoMvProcesso + ' n�o efetuada para o processo ' +
    FoDados.fpgNuProcesso);

  if FoDados.fpgVerificarBaixaProcesso then
  begin

    check(FoDados.VerificarSituacaoBaixadaPrincipal(gsNumeroProc),
      'O processo Principal: ' + gsNumeroProc + ' n�o foi baixada');
    check(FoDados.VerificarSituacaoBaixadaDependente(gsNumeroProcDependente),
      'O processo Dependente: ' + gsNumeroProcDependente + ' foi baixada');

  end;

  FecharTela;
end;

function TffpgCadMovimentacaoUnitariaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadMovimentacaoUnitariaGUIModelTests;
end;

procedure TffpgCadMovimentacaoUnitariaTests.PreencherDadosMovUnitaria;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'N�mero de Processo n�o encontrado');

  TFutureWindows.Expect('TffpgAssistente').ExecProc(PegarTelaPendencia);

  TFutureWindows.Expect('TfsajSelecionaDependentes').ExecProc(PegarTelaDependente);

  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  if FoDados.fpgRegistraMensagemBaixa then
    spVerificadorTelas.RegistrarMensagem('Esta movimenta��o*', 'Sim');

  EnterTextInto(FoTela.csTipoMvProcesso.dfCodigo, FoDados.fpgCdTipoMvProcesso, False);
  EnterTextInto(FoTela.dfComplMovimentacao.spMemo, FoDados.fpgComplemento);
  PreencherData;

  EnterTextCheckBox(FoTela.ckPublicar, FoDados.fpgPublicarMov);
end;

procedure TffpgCadMovimentacaoUnitariaTests.PegarTelaDependente(const poWindow: IWindow);
var
  oTelaDependente: TfsajSelecionaDependentes;
begin
  oTelaDependente := poWindow.asControl as TfsajSelecionaDependentes;
  oTelaDependente.bcBotoesCadastro.spControleCadastro.Execute(acSelecionar);

end;

procedure TffpgCadMovimentacaoUnitariaTests.TestarCadastrarMovUnitaria;
begin
  ExecutarRoteiroTestes(CadastrarMovUnitaria);
end;

procedure TffpgCadMovimentacaoUnitariaTests.TestarExcluirMovUnitaria;
begin
  ExecutarRoteiroTestes(ExcluirMovimentacao);
end;

procedure TffpgCadMovimentacaoUnitariaTests.ExcluirMovimentacao;
var
  i: integer;
  sMov: string;
begin
  AbrirTela;
  FoTela := TffpgCadMovimentacaoUnitaria(spTela);
  FoDados := TffpgCadMovimentacaoUnitariaGUIModelTests(spDataModelTests);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'N�mero de Processo n�o encontrado');

  TFutureWindows.Expect('TfsajAssistente').ExecProc(FecharJanelaModal);
  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  for i := 1 to FoTela.tvMovimentacao.Items.Count - 1 do
  begin
    FoTela.tvMovimentacao.Items.Item[i].Selected := True;
    Application.ProcessMessages;
    sMov := FoTela.csTipoMvProcesso.dfCodigo.PegaTexto;
    if (FoTela.bvMovUnitaria.spControleCadastro.Habilitado(acExcluir)) and
      (FoDados.fpgCdTipoMvProcesso = sMov) then
    begin
      spVerificadorTelas.RegistrarMensagem(
        'Confirma a exclus�o do(a) movimenta��o do processo?', 'OK');

      FoTela.bvMovUnitaria.spControleCadastro.Execute(acExcluir);
      Break;
    end;
  end;
  FoTela.ccCadastro.Execute(acSalvar);
  CheckFalse(FoDados.VerficarMovUnitaria(FoDados.fpgCdTipoMvProcesso,
    FoDados.fpgNuProcesso, 'NOT'),
    'Movimenta��o ' + FoDados.fpgCdTipoMvProcesso + ' n�o efetuada para o processo ' +
    FoDados.fpgNuProcesso);
end;

procedure TffpgCadMovimentacaoUnitariaTests.PegarTelaPendencia(const poWindow: IWindow);
var
  oTelaPendencia: TffpgAssistente;
  bCheck: boolean;
begin
  oTelaPendencia := poWindow.asControl as TffpgAssistente;
  if FoDados.fpgVerificarPendencia then
  begin
    oTelaPendencia.cdsItens.First;
    bCheck := False;
    while not oTelaPendencia.cdsItens.EOF do
    begin
      if oTelaPendencia.cdsItens.FieldByName('DEITEM').AsString = gsPendencia then
      begin
        bCheck := True;
        break;
      end
      else
      begin
        oTelaPendencia.cdsItens.Next;
      end;
    end;
    Check(bCheck, 'Movimenta��o n�o foi lan�ada corretamente.');
  end;
  oTelaPendencia.pbFechar.Click;
end;

procedure TffpgCadMovimentacaoUnitariaTests.PreencherData;
var
  Data: TDateTime;
begin
  Data := spDB.DataAtual;
  if DayOfWeek(Data) in [1, 7] then
  begin
    if FoTela.dfDtMovimento.dfDtMovimentoData.EstaNulo then
      FoTela.dfDtMovimento.dfDtMovimentoData.Value := trunc(Data);
  end;
end;

procedure TffpgCadMovimentacaoUnitariaTests.FecharTelaMemoEvento(const poWindow: IWindow);
var
  FoTelaEvento: TfwflDemoEvento;
begin
  FoTelaEvento := (poWindow.asControl as TfwflDemoEvento);
  FoTelaEvento.ckbVisualizarTela.Checked := True;
  FoTelaEvento.pbFechar.Click;
end;

procedure TffpgCadMovimentacaoUnitariaTests.VisualizarDocumento;
var
  i: integer;
  oTelaVisualizaDocumento: TffpgVisualizarModeloOuDocumento;
begin
  AbrirTela;
  FoTela := TffpgCadMovimentacaoUnitaria(spTela);
  FoDados := TffpgCadMovimentacaoUnitariaGUIModelTests(spDataModelTests);

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'N�mero de Processo n�o encontrado');

  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  if FoTela.tvMovimentacao.Items.Count >= 4 then
  begin
    for i := 0 to FoTela.tvMovimentacao.Items.Count - 1 do
    begin
      FoTela.tvMovimentacao.Items[i].Selected := True;
      if FoTela.pbVisualizarDocumento.Enabled then
      begin
        FoTela.pbVisualizarDocumento.Click;
        Break;
      end;
    end;
  end
  else
  begin
    spVerificadorTelas.RegistrarMensagem('Documento inexistente ou n�o encontrado!', 'OK');
    if FoTela.tvMovimentacao.Items.Count > 1 then
    begin
      FoTela.tvMovimentacao.Items[1].Selected := True;
      FoTela.pbVisualizarDocumento.Click;
    end;
  end;
  oTelaVisualizaDocumento := PegarTela('ffpgVisualizarModeloOuDocumento') as
    TffpgVisualizarModeloOuDocumento;
  CheckTrue(Assigned(oTelaVisualizaDocumento), 'Documento n�o foi visualizado.');
  Application.ProcessMessages;
  oTelaVisualizaDocumento.dxbbBotoesFecharForm.Click;
  FecharTela;
end;

procedure TffpgCadMovimentacaoUnitariaTests.TestarVisualizarDocumento;
begin
  ExecutarRoteiroTestes(VisualizarDocumento);
end;

//25/10/2016 - Raphael.Whitlock - Task: 67003
procedure TffpgCadMovimentacaoUnitariaTests.TestarVerificarMovUnitaria;
begin
  ExecutarRoteiroTestes(VerificarMovimentacao);
end;

//25/10/2016 - Raphael.Whitlock - Task: 67003
procedure TffpgCadMovimentacaoUnitariaTests.VerificarMovimentacao;
begin
  AbrirTela;
  FoTela := TffpgCadMovimentacaoUnitaria(spTela);
  FoDados := TffpgCadMovimentacaoUnitariaGUIModelTests(spDataModelTests);

  if FoDados.fpgGrauRecurso then
    spVerificadorTelas.RegistrarMensagem('O processo est� em grau de recurso.', 'OK');

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'N�mero de Processo n�o encontrado');

  TFutureWindows.Expect('TfsajAssistente').ExecProc(FecharJanelaModal);
  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  if FoDados.fpgVerificarMovimentacao then
  begin
    Check(VerificarMovimentacaoGrid, 'Movimenta��o n�o encontrada na grid para o processo.' +
      FoDados.fpgNuProcesso);
    Check(FoDados.VerficarMovUnitaria(FoDados.fpgCdTipoMvProcesso, FoDados.fpgNuProcesso),
      'Movimenta��o ' + FoDados.fpgCdTipoMvProcesso + ' n�o efetuada para o processo ' +
      FoDados.fpgNuProcesso);
  end;

  if FoDados.fpgVerificarMotivo then
  begin

  end;
end;

//25/10/2016 - Raphael.Whitlock - Task: 67003
function TffpgCadMovimentacaoUnitariaTests.VerificarMovimentacaoGrid: boolean;
var
  i: integer;
  sMov: string;
begin
  result := False;
  for i := 1 to FoTela.tvMovimentacao.Items.Count - 1 do
  begin
    FoTela.tvMovimentacao.Items.Item[i].Selected := True;
    Application.ProcessMessages;
    sMov := FoTela.csTipoMvProcesso.dfCodigo.PegaTexto;
    if (FoDados.fpgCdTipoMvProcesso = sMov) then
    begin
      result := True;
      Break;
    end;
  end;
end;

procedure TffpgCadMovimentacaoUnitariaTests.TestarDesvincularDocumento;
begin
  ExecutarRoteiroTestes(DesvincularDocumento);
end;

procedure TffpgCadMovimentacaoUnitariaTests.DesvincularDocumento;
begin

  AbrirTela;
  FoTela := TffpgCadMovimentacaoUnitaria(spTela);
  FoDados := TffpgCadMovimentacaoUnitariaGUIModelTests(spDataModelTests);

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'N�mero de Processo n�o encontrado');

  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  FoTela.tvMovimentacao.Items.Item[FoTela.tvMovimentacao.Items.Count - 1].Selected := False;

  Application.ProcessMessages;

  check(FoTela.pbDesvincularDocumento.Enabled, 'O bot�o de Desvincular n�o est� habilitado');

  FoTela.pbDesvincularDocumento.Click;

  check((FoDados.VerificarDesvincularDocumento(FoDados.fpgNuProcesso)),
    'O documento n�o foi desvinculado da movimenta��o');

end;

end.


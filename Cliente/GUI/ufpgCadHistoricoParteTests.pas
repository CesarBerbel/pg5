unit ufpgCadHistoricoParteTests;

interface

uses
  Windows, Forms, Classes, SysUtils, Controls, TestFramework, FutureWindows,
  Messages, uspForm, ufpgGUITestCase, ufpgCadHistoricoParteModelTests,
  ufpgDataModelTests, uaipRelHistoricoParte, ufpgCadHistoricoParte,
  uaipCadCapitulaEvento, dcDTree, ufpgFuncoesTestes, ufpgSelecaoCeritificadoDigital;


type
  TfaipRelHistoricoParteProtected = class(TfaipRelHistoricoParte);

  TffpgCadHistoricoParteTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadHistoricoParte;
    FoDados: TfpgCadHistoricoParteModelTests;
    procedure CadastrarHistoricoPartes;
    procedure PreencherCapitulacao;
    procedure VisualizarRelatorio;
    procedure PreencherMulta;
    procedure PreencherGridTransitoJulgado;
    procedure PreencherGridEventos;
    procedure VerificarDataInferiorAAtual;
    procedure PreencherPrisao;
    procedure PreencherGridSursis;
    procedure CertificarDocumento(const poWindow: IWindow);
    procedure PreeencherConsCapitulacao(poTela: TfaipCadCapitulaEvento);
    procedure PreencherGridAbaRestritiva;
    function ValidarPrevisoes: boolean;
    procedure VerificarTelaRelatorio(var psMsg: TMessage);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarHistoricoPartes;
  end;

var
  sNuProcesso: string;
  FsArtigo: string;
  FsNodoPai: string;
  FsCapitulacao: string;
  FnHandleTimer: integer;
  gbPegouTela: boolean;


implementation

uses
  RPDefine, RpRender, RpRenderPDF, uspQuickPDF, RpBase, RpSystem, uaipConsProcessoParteTipo,
  DB, uaipConstante, uaipDm, Dialogs, ufpgConstanteGUITests, usajConstante,
  ufpgFuncoesGUITestes, uspInterface, udigRPPreviewForm, ADODB, uaipConsCapitulaEvento,
  uaipCadSursis, udigSelecaoCertificadoDigital, uedtSelecaoCeritificadoDigital,
  ufpgVariaveisTestesGUI, uaipPrevisaoAPI, uspLabel;

function TffpgCadHistoricoParteTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TfpgCadHistoricoParteModelTests;
end;

procedure TffpgCadHistoricoParteTests.CadastrarHistoricoPartes;
const
  nEVENTO_DATA = 2;
var
  nQtdeEventos: string;
begin
  FnHandleTimer := 0;
  gbPegouTela := False;
  AbrirTela;
  FoTela := TffpgCadHistoricoParte(spTela);
  FoDados := TfpgCadHistoricoParteModelTests(spDataModelTests);

  if gsNuPec <> STRING_INDEFINIDO then
    FoDados.aipNuProcesso := gsNuPec;
  if FoDados.aipNuProcesso = STRING_INDEFINIDO then
    FoDados.aipNuProcesso := UsarProcessoArray;
  Check(FoDados.aipNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.faipFrmProcessoParte.dfnuProcesso.FdfNumeroProcessoExterno,
    FoDados.aipNuProcesso, False);

  if gsNuPec = '' then
  begin
    check(SomenteNumeros(FoTela.grEventos.DataSource.DataSet.FieldByName(
      'CC_NUPROCESSOFOR').AsString) = FoDados.aipNuProcesso,
      'O Numero de processo na grid Eventos esta diferente do informado');
  end;


  if FoDados.fpgAlteraReuMsg then
    spVerificadorTelas.RegistrarMensagem('Deseja alterar o tipo de participação para Réu?', 'Não');

  if FoDados.fpgValidaPrevisoes then
    Check(ValidarPrevisoes, 'Erro na visualização das previsões.')
  else
  begin
    ExecutarSubRoteiroTestes(PreencherGridEventos, 'DadosEventos', FoDados.aipEvento);
    FoTela.ccPai.Execute(acSalvar);
    nQtdeEventos := IntToStr(FoTela.grEventos.DataSource.DataSet.RecordCount);
    Check(FoDados.VerificarHistoricoParte(FoDados.aipNuProcesso, nQtdeEventos),
      'O histórico da parte não foi cadatrado.');
  end;

  if FoDados.fpgVisualizarRelatorio then
  begin
    FoTela.ccPai.Execute(acImprimir);
    VisualizarRelatorio;
  end;
  FecharTela;
end;

procedure TffpgCadHistoricoParteTests.TestarHistoricoPartes;
begin
  ExecutarRoteiroTestes(CadastrarHistoricoPartes);
end;

procedure TffpgCadHistoricoParteTests.VisualizarRelatorio;
var
  oTelaRelatorio: TfaipRelHistoricoParte;
begin
  FnHandleTimer := AllocateHWnd(VerificarTelaRelatorio);
  Windows.SetTimer(FnHandleTimer, 1, 1000, nil);

  oTelaRelatorio := PegarTela('faipRelHistoricoParte') as TfaipRelHistoricoParte;
  oTelaRelatorio.rbHistoricoParte.Checked := FoDados.fpgHistoricoParte;
  if FoDados.fpgGuiaRecolhimento then
  begin
    oTelaRelatorio.rbGuiaRecolhimento.Checked := FoDados.fpgGuiaRecolhimento;
    EnterTextInto(oTelaRelatorio.aipJuizCons.edCodigo, FoDados.fpgJuiz);
    EnterTextInto(oTelaRelatorio.aipEscrivaoCons.edCodigo, FoDados.fpgEscrivao);
  end;

  oTelaRelatorio.pbVisualizar.Click;
end;

procedure TffpgCadHistoricoParteTests.PreencherMulta;
const
  nMULTA_BASECALCULO = 2;
begin
  FoTela.faipFrmSentenca.tsMulta.Show;
  FoTela.faipFrmSentenca.ckMulta.Checked := True;

  EnterTextGrid(FoTela.faipFrmSentenca.faipFrmMulta.grDadosMulta, 'Salario minimo',
    nMULTA_BASECALCULO);

  EnterTextGrid(FoTela.faipFrmSentenca.faipFrmMulta.grDadosMulta, '2', 4);
end;

procedure TffpgCadHistoricoParteTests.PreencherGridTransitoJulgado;
const
  nTRANSITO_DATA = 0;
begin
  FoTela.tsSentenca.Show;
  FoTela.faipFrmSentenca.pcSentenca.ActivePage := FoTela.faipFrmSentenca.tsTransitoJulgado;
  spVerificadorTelas.RegistrarMensagem('Com o lançamento deste evento*', 'OK');
  while not FoTela.faipFrmSentenca.grTransito.DataSource.DataSet.EOF do
  begin
    EnterTextGrid(FoTela.faipFrmSentenca.grTransito, SomenteNumeros(DateToStr(Now)),
      {FoDados.aipEvento.fpgDataTransitoJulgado}
      nTRANSITO_DATA);
    FoTela.faipFrmSentenca.grTransito.DataSource.DataSet.Next;
  end;
end;

procedure TffpgCadHistoricoParteTests.PreencherGridEventos;
const
  nEVENTO_DATA = 2;
  nEVENTO_NUEVENTO = 3;
  sREU_PRESO = 'Réu preso';
  sNUMERO_EVENTO = '155';
begin
  if FoDados.aipEvento.fpgPressionarIns then
  begin
    Application.ProcessMessages;
    VerificarDataInferiorAAtual;
    FoTela.ccPai.Execute(acNovo);
  end
  else
  if FoDados.aipEvento.fpgPressionarDel then
  begin
    spVerificadorTelas.RegistrarMensagem('Confirma a exclusão*', 'Sim');
    FoTela.ccPai.Execute(acExcluir);
    Exit;
  end
  else if not (FoTela.dsPai.State in dsEditModes) then
    FoTela.grEventos.DataSource.DataSet.Last;

  if FoDados.aipEvento.fpgData = STRING_INDEFINIDO then
    FoDados.aipEvento.fpgData := DateToStr(Now);

  if FoDados.VerificarFeriado(FoDados.RetornarForoProcesso(FoDados.aipNuProcesso),
    FoDados.aipEvento.fpgData) then
    spVerificadorTelas.RegistrarMensagem('Esta data é um feriado. Deseja continuar?', 'Sim');

  if RetornaFinalDeSemana(StrToDate(FoDados.aipEvento.fpgData)) then
    spVerificadorTelas.RegistrarMensagem(
      'Esta data é um final de semana. Deseja continuar?', 'Sim');

  EnterTextGrid(FoTela.grEventos, SomenteNumeros(FoDados.aipEvento.fpgData), nEVENTO_DATA);

  if FoDados.aipEvento.fpgCopiarDadosCap then
  begin
    spVerificadorTelas.RegistrarMensagem('Deseja copiar os dados da capitulação anterior?', 'Sim');
  end;

  if FoDados.aipEvento.fpgRegistraMsgTipoParticipacao then
    spVerificadorTelas.RegistrarMensagem('Deseja alterar o tipo de participação*', 'Sim');

  EnterTextGrid(FoTela.grEventos, FoDados.aipEvento.fpgNuEvento, nEVENTO_NUEVENTO);

  if FoDados.aipEvento.fpgCapitulacao then
    PreencherCapitulacao;

  // Preenchimento dos dados de prisão
  if FoDados.aipEvento.fpgTipoPrisao <> STRING_INDEFINIDO then
    PreencherPrisao;

  // Alguns eventos chamam a aba sentença para o lançamento da capitulação
  if FoDados.aipEvento.fpgAbaSentenca then
  begin
    FoTela.faipFrmSentenca.faipFrmCapitulaEventoConsPrivativa.pbConsulta.Click;
    PreencherCapitulacao;
    EnterTextInto(FoTela.faipFrmSentenca.cbRegimeReclusao, FoDados.aipEvento.fpgRegime);
    if FoDados.aipEvento.fpgPreencherSursis then
    begin
      FoTela.faipFrmSentenca.pbSursis.Click;
      ExecutarSubRoteiroTestes(PreencherGridSursis, 'DadosSursis', FoDados.aipSursis);
    end;
    if FoDados.aipEvento.fpgRestrititva then
    begin
      EnterTextCheckBox(FoTela.faipFrmSentenca.ckRestritiva, True);
      Application.ProcessMessages;
      PreencherGridAbaRestritiva;
    end;
  end;

  if FoDados.aipEvento.fpgDataTransitoJulgado <> STRING_INDEFINIDO then
  begin
    PreencherGridTransitoJulgado;
  end;

  if FoDados.aipEvento.fpgPreencherMulta then
    PreencherMulta;
  if FoDados.aipEvento.fpgNuEvento = sNUMERO_EVENTO then;
end;

procedure TffpgCadHistoricoParteTests.VerificarDataInferiorAAtual;
var
  dtDataEvento: TDateTime;
begin
  dtDataEvento := FoTela.grEventos.DataSource.DataSet.FieldByName('DTEVENTO').AsDateTime;
  FoTela.grEventos.DataSource.DataSet.First;
  while not FoTela.grEventos.DataSource.DataSet.EOF do
  begin
    if StrToDateTime(FoDados.aipEvento.fpgDataComparacao) < dtDataEvento then
    begin
      Break;
    end;
    FoTela.grEventos.DataSource.DataSet.Next;
  end;
end;

procedure TffpgCadHistoricoParteTests.PreencherCapitulacao;
var
  oTelaCadCapitulaEvento: TfaipCadCapitulaEvento;
  oTelaConsCapitulaEvento: TfaipConsCapitulaEvento;
begin
  oTelaCadCapitulaEvento := TfaipCadCapitulaEvento(PegarTela('faipCadCapitulaEvento'));

  if FoDados.aipEvento.fpgCopiarDadosCap then
  begin
    oTelaCadCapitulaEvento.ccCadastro.Execute(acSelecionar);
    Exit;
  end;

  if (FoDados.fpgCEP <> STRING_INDEFINIDO) and oTelaCadCapitulaEvento.dfCEP.Visible then
    EnterTextInto(oTelaCadCapitulaEvento.dfCEP, FoDados.fpgCEP);


  if FoDados.aipEvento.fpgPreencherCampoArtigo then
  begin
    EnterTextInto(oTelaCadCapitulaEvento.dfnuArtigo, FoDados.aipEvento.fpgArtigo);
  end;

  oTelaConsCapitulaEvento := TfaipConsCapitulaEvento(PegarTela('faipConsCapitulaEvento'));

  SelecionarNodoTreeView(FoDados.aipEvento.fpgCapitulacaoTextoNodoPai,
    FoDados.aipEvento.fpgCapitulacaoTexto, oTelaConsCapitulaEvento.tvCapitulacao, True);

  oTelaConsCapitulaEvento.ccCadastro.Execute(acSelecionar);

  if FoDados.aipEvento.fpgDias <> STRING_INDEFINIDO then
  begin
    EnterTextInto(oTelaCadCapitulaEvento.dfaaPena, FoDados.aipEvento.fpgAnos);
    EnterTextInto(oTelaCadCapitulaEvento.dfmmPena, FoDados.aipEvento.fpgMeses);
    EnterTextInto(oTelaCadCapitulaEvento.dfddPena, FoDados.aipEvento.fpgDias);
  end;
  oTelaCadCapitulaEvento.pbConfirmar.Click;

  if FoDados.aipEvento.fpgNuEvento <> '111' then
  begin
    oTelaCadCapitulaEvento.ccCadastro.Execute(acSelecionar);
    Exit;
  end;

  //If usado para preencher captulação se o botão "e" for precionado
  if FoDados.aipEvento.fpgOutroArtigo <> STRING_INDEFINIDO then
  begin
    oTelaCadCapitulaEvento.pbMais.Click;
    FsArtigo := FoDados.aipEvento.fpgOutroArtigo;
    FsNodoPai := FoDados.aipEvento.fpgCapitulacaoOutroTextoNodoPai;
    FsCapitulacao := FoDados.aipEvento.fpgCapitulacaoOutroTexto;
    PreeencherConsCapitulacao(oTelaCadCapitulaEvento);
  end;

  //If usado para preencher captulação se o botão "c/c" for precionado
  if FoDados.aipEvento.fpgOutroArtigoBotaoCC <> STRING_INDEFINIDO then
  begin
    oTelaCadCapitulaEvento.pbCombinado.Click;
    FsArtigo := FoDados.aipEvento.fpgOutroArtigoBotaoCC;
    FsNodoPai := FoDados.aipEvento.fpgCapitulacaoTextoNodoPaiBotaoCC;
    FsCapitulacao := FoDados.aipEvento.fpgCapitulacaoTextoBotaoCC;
    PreeencherConsCapitulacao(oTelaCadCapitulaEvento);
  end;

  //If usado para preencher captulação se o botão "combinado" for precionado
  if FoDados.aipEvento.fpgOutroArtigoBotaoCombinado <> STRING_INDEFINIDO then
  begin
    oTelaCadCapitulaEvento.pbContinuado.Click;
    FsArtigo := FoDados.aipEvento.fpgOutroArtigoBotaoCombinado;
    FsNodoPai := 'Inciso I'; //FoDados.aipEvento.fpgCapitulacaoTextoNodoPaiBotaoCombinacao;
    FsCapitulacao := FoDados.aipEvento.fpgCapitulacaoTextoBotaoCombinacao;
    PreeencherConsCapitulacao(oTelaCadCapitulaEvento);
  end;
  oTelaCadCapitulaEvento.ccCadastro.Execute(acSelecionar);
end;


procedure TffpgCadHistoricoParteTests.PreeencherConsCapitulacao(poTela: TfaipCadCapitulaEvento);
var
  oTelaConsCapitulaEvento: TfaipConsCapitulaEvento;
begin
  EnterTextInto(poTela.dfnuArtigo, FsArtigo);
  poTela.dfnuArtigoExit(poTela.dfnuArtigo);
  oTelaConsCapitulaEvento := TfaipConsCapitulaEvento(PegarTela('faipConsCapitulaEvento',
    False, 1000));
  //  try
  if oTelaConsCapitulaEvento <> nil then
  begin
    Application.ProcessMessages;
    TDrawNode(oTelaConsCapitulaEvento.tvCapitulacao.Items[2]).Checked := True;
    oTelaConsCapitulaEvento.ccCadastro.Execute(acSelecionar);
  end;
  poTela.pbConfirmar.Click;
  application.ProcessMessages;
end;

procedure TffpgCadHistoricoParteTests.PreencherPrisao;
const
  nPRISAO_TIPOPRISAO = 1;
  nPRISAO_CONSIDERA = 3;
  nPRISAO_TIPOLOCAL = 4;
  nPRISAO_LOCAL = 5;
begin
  FoTela.grEventos.DataSource.DataSet.FieldByName('DTEVENTO');
  EnterTextGrid(FoTela.faipFrmDadosPrisao.grDadosPrisao, FoDados.aipEvento.fpgTipoPrisao,
    nPRISAO_TIPOPRISAO);
  EnterTextGrid(FoTela.faipFrmDadosPrisao.grDadosPrisao, FoDados.aipEvento.fpgConsidera,
    nPRISAO_CONSIDERA);
  EnterTextGrid(FoTela.faipFrmDadosPrisao.grDadosPrisao, FoDados.aipEvento.fpgTipoLocal,
    nPRISAO_TIPOLOCAL);
  EnterTextGrid(FoTela.faipFrmDadosPrisao.grDadosPrisao, FoDados.aipEvento.fpgLocal,
    nPRISAO_LOCAL);
end;

procedure TffpgCadHistoricoParteTests.PreencherGridSursis;
var
  oTela: TfaipCadSursis;
begin
  oTela := PegarTela('faipCadSursis') as TfaipCadSursis;
  EnterTextInto(oTela.grDados, FoDados.aipSursis.aipCondicao);
  oTela.ccCadastro.Execute(acSalvar);
  oTela.ccCadastro.Execute(acFecharForm);
end;

procedure TffpgCadHistoricoParteTests.PreencherGridAbaRestritiva;
begin
  FoTela.faipFrmSentenca.pcSentenca.ActivePage := FoTela.faipFrmSentenca.tsRestritiva;

  EnterTextGrid(FoTela.faipFrmSentenca.grDadosRestritiva2, '6', 0);
  EnterTextGrid(FoTela.faipFrmSentenca.grDadosRestritiva2, 'M', 7);

  FoTela.faipFrmSentenca.grSubst.DataSource.DataSet.Edit;
  FoTela.faipFrmSentenca.grSubst.DataSource.DataSet.FieldByName(
    'FLSUBSTPRIVATIVA').AsString := 'S';
  FoTela.faipFrmSentenca.grSubst.DataSource.DataSet.Post;
  Application.ProcessMessages;
end;

function TffpgCadHistoricoParteTests.ValidarPrevisoes: boolean;
const
  sListaComponentes__: array[1..5] of string =
    ('lbSaidaTemporaria', 'lbProgressaoSemiAberto', 'lbProgressaoAberto',
    'lbLivramentoCondicional', 'lbTerminoDePena');
var
  oComponente: TComponent;
  I: integer;
  sListaComponentes: TStringList;
begin
  result := True;
  try
    sListaComponentes := TStringList.Create;
    sListaComponentes.Add('lbSaidaTemporaria');
    sListaComponentes.Add('lbProgressaoSemiAberto');
    sListaComponentes.Add('lbProgressaoAberto');
    sListaComponentes.Add('lbLivramentoCondicional');
    sListaComponentes.Add('lbTerminoDePena');
    for I := 0 to sListaComponentes.Count - 1 do
    begin
      oComponente := FoTela.aipControleHistoricoParte.GetPrevisaoPresenter.GetView.
        aipContainer.Components[0].FindComponent(sListaComponentes[I]);
      if (FoTela.faipFrmSentenca.grSubst.DataSource.DataSet.FieldByName(
        'FLSUBSTPRIVATIVA').AsString = 'N') and
        (TspLabel(oComponente).Caption = 'Não aplicável') then
      begin
        result := False;
      end;
      if (FoTela.faipFrmSentenca.grSubst.DataSource.DataSet.FieldByName(
        'FLSUBSTPRIVATIVA').AsString = 'S') and
        (TspLabel(oComponente).Caption <> 'Não aplicável') then
      begin
        result := False;
      end;

    end;
  finally
    FreeAndNil(sListaComponentes);
  end;
end;

procedure TffpgCadHistoricoParteTests.VerificarTelaRelatorio(var psMsg: TMessage);
var
  oTela: TForm;
begin
  if gbPegouTela then
    Exit;
  oTela := TForm(FindGlobalComponent('fdigRPPreviewForm'));
  if (oTela <> nil) and (oTela is TfdigRPPreviewForm) and TspForm(oTela).Visible then
  begin
    gbPegouTela := True;
    TFutureWindows.Expect('TffpgSelecaoCeritificadoDigital').ExecProc(CertificarDocumento);
    if not FoDados.fpgGuiaRecolhimento then
      TfdigRPPreviewForm(oTela).SBDone.Click
    else
      TfdigRPPreviewForm(oTela).SBDigitalizar.Click;
  end;
end;

procedure TffpgCadHistoricoParteTests.CertificarDocumento(const poWindow: IWindow);
var
  oTela: TffpgSelecaoCeritificadoDigital;
  oTelaRelatorio: TForm;
begin
  oTela := poWindow.asControl as TffpgSelecaoCeritificadoDigital;
  EnterTextRadioGroup(oTela.rgOpcao, FoDados.fpgAcaoFinalizar);
  EnterTextInto(oTela.cbCertificados, FoDados.fpgCertificado);

  oTela.ccCadastro.Execute(acSelecionar);

  oTelaRelatorio := TForm(FindGlobalComponent('fdigRPPreviewForm'));
  if (oTelaRelatorio <> nil) and (oTelaRelatorio is TfdigRPPreviewForm) and
    TspForm(oTelaRelatorio).Visible then
    TfdigRPPreviewForm(oTelaRelatorio).SBDone.Click;

  if FnHandleTimer <> 0 then
  begin
    KillTimer(FnHandleTimer, 1);
    DeallocateHWnd(FnHandleTimer);
    FnHandleTimer := 0;
  end;
end;

end.


unit ufpgGerenciadorArquivoTests;

interface

uses
  ufpgGerenciadorArquivo, ufpgGUITestCase, ufpgGerenciadorArquivoModelTests,
  ufpgDataModelTests, FutureWindows;

type
  TffpgGerenciadorArquivoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgGerenciadorArquivo;
    FoDados: TffpgGerenciadorArquivoModelTests;
    procedure PreencherDadosGerenciador;
    procedure GerenciadorArquivo;
    procedure SelecionarModelo;
    procedure ConfirmarMovimentacao;
    procedure SelecionarMaisOpcoesPesquisa;
    procedure PegarTelaImprimir(const poWindow: IWindow);
    procedure CompartilharDocumento;
    procedure VerificarObservacao;
    procedure AssinarLiberar;
    procedure SelecionarDocumento;
    procedure PreencherDadosConsultaPorData;
    procedure PreencherDadosConsultaPorNome;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarGerenciadorArquivos;
    procedure TestarConsutarPorProcesso;
    procedure TestarConsultarPorUltimaAlteracao;
    procedure TestarConsutarPorNome;
    procedure TestarConsultaPorUsuarioCriacao;
    procedure TestarConsultaPorOutrasDatas;
    procedure TestarConsultaPorPasta;
    procedure TestarConsultaPorDocsCompartilhados;
    procedure TestarConsultaPorDocsMovPendentes;
    procedure TestarConsultaPorOutrosGrupos;
  end;

implementation

uses
  TestFrameWork, uspInterface, ufpgFuncoesGUITestes, uedtFormImprimir, usajConstante,
  udigVisualizaDocumentoPDF, uggpCompartilhamento, dxBar, ufpgVariaveisTestesGUI,
  Forms, Windows, uedtSelecaoCeritificadoDigital, SysUtils;

{ TffpgGerenciadorArquivoTests }
var
  bAchou: boolean;

const
  CS_IMAGEM = '13';
  CS_IMAGEM2 = '14';


procedure TffpgGerenciadorArquivoTests.TestarGerenciadorArquivos;
begin
  ExecutarRoteiroTestes(GerenciadorArquivo);
end;

procedure TffpgGerenciadorArquivoTests.GerenciadorArquivo;
begin
  AbrirTela;
  FoTela := TffpgGerenciadorArquivo(spTela);
  FoDados := TffpgGerenciadorArquivoModelTests(spDataModelTests);

  if FoDados.fpgPesquisarPorModelos then
    Click(FoTela.tbxrbTipoDeArquivoModelos)
  else
    Click(FoTela.tbxrbTipoDeArquivoDocumentos);

  PreencherDadosGerenciador;

  FoTela.tbxiConsultar.click;
  FoTela.acConsultarExecute(FoTela.tbxiConsultar);

  if FoDados.fpgLocalizarModelo then
    SelecionarModelo
  else
    SelecionarDocumento;


  if FoDados.fpgImprimir then
  begin
    TFutureWindows.Expect('TfedtFormImprimir').ExecProc(PegarTelaImprimir);
    FoTela.imArquivoImprimir.Click;
  end;

  if FoDados.fpgConfirmarMov then
    ConfirmarMovimentacao;

  if FoDados.fpgNomeCompartilhar <> STRING_INDEFINIDO then
    CompartilharDocumento;

  if Fodados.fpgVerificarObservacao then
  begin
    if FoDados.fpgNuDocumento = STRING_INDEFINIDO then
      FoDados.fpgNuDocumento := gsNuDocumento;
    Check(FoDados.fpgNuDocumento <> STRING_INDEFINIDO, 'Número de documento não encontrado.');
    VerificarObservacao;
  end;

  if FoDados.fpgAssinarLiberar then
    AssinarLiberar;

  FecharTela;
end;

function TffpgGerenciadorArquivoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgGerenciadorArquivoModelTests;
end;

procedure TffpgGerenciadorArquivoTests.PreencherDadosGerenciador;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
  begin
    FoDados.fpgNuProcesso := usarProcessoArray;
    FoDados.fpgCdProcesso := gsCdProcesso;
  end;

  if FoDados.fpgConsultaProcesso then
  begin
    check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

    EnterTextInto(FoTela.sajNumeroProcessoConsulta.FdfNumeroProcessoExterno,
      FoDados.fpgNuProcesso);
    sleep(1000);
    application.ProcessMessages;
  end;
  if FoDados.fpgMaisOpcoesPesquisa then
    SelecionarMaisOpcoesPesquisa;

  if FoDados.fpgConsultaData then
    PreencherDadosConsultaPorData;

  if FoDados.fpgConsultaNome then
    PreencherDadosConsultaPorNome;
end;


procedure TffpgGerenciadorArquivoTests.SelecionarModelo;
var
  sNmModelo: string;
begin
  if not FoTela.dbGrid.DataSource.DataSet.IsEmpty then
  begin
    if FoDados.fpgCdModelo <> STRING_INDEFINIDO then
    begin
      FoTela.dbGrid.SetFocus;
      FoTela.dbGrid.FocusedNode.Selected := False;
      FoTela.dbGrid.FocusedNode.Focused := False;
      bAchou := FoTela.eedtGerenciadorArqPesquisa.Locate('CDMODELO', FoDados.fpgCdModelo, []);
      sNmModelo := FoTela.dbGrid.DataSource.DataSet.FieldByName('NMDOCUMENTO').AsString;
      FoTela.dbGrid.FocusedNode.Selected := True;
      FoTela.dbGrid.FocusedNode.Focused := True;
    end
    else
    begin
      while not FoTela.dbGrid.DataSource.DataSet.EOF do
      begin
        sNmModelo := Copy(FoTela.dbGrid.DataSource.DataSet.FieldByName(
          'NMDOCUMENTO').AsString, 0, 25);
        if sNmModelo = FoDados.fpgDescModelo then
        begin
          bAchou := True;
          Break;
        end
        else
          FoTela.dbGrid.DataSource.DataSet.Next;
      end;
    end;
    Check(bAchou, 'Falha - Ao localizar modelo de documento! [' + sNmModelo + ']');
  end
  else
    Check(not FoTela.dbGrid.DataSource.DataSet.IsEmpty, FoTela.tbxlbConsultaHint.Caption);
end;

procedure TffpgGerenciadorArquivoTests.PegarTelaImprimir(const poWindow: IWindow);
var
  oTela: TfedtFormImprimir;
begin
  oTela := poWindow.asControl as TfedtFormImprimir;
  oTela.pbOK.Click;
end;

procedure TffpgGerenciadorArquivoTests.ConfirmarMovimentacao;
begin
  //  bAchou := FoTela.dxConfirmacaoMovimentacao.Enabled and
  //    (FoTela.dxConfirmacaoMovimentacao.Visible = ivALWAYS);
  //  Check(bAchou, 'Falha - Confirmação da Movimentação não disponível!');

  Application.ProcessMessages;
  sleep(7000);
  Application.ProcessMessages;

  PosicionarPonteiroMouse(FoTela.dbGrid);
  CliqueDireitoMouse;
  CliqueSetaBaixo(11);
  CliqueEnter;

  FoTela.dxConfirmacaoMovimentacao.Click;

  Application.ProcessMessages;

end;

procedure TffpgGerenciadorArquivoTests.SelecionarMaisOpcoesPesquisa;
begin
  if (FoDados.fpgOutraDataInicial = STRING_INDEFINIDO) and
    (FoDados.fpgOutraDataFinal = STRING_INDEFINIDO) then
  begin
    FoDados.fpgDataInicio := DateToStr(Now - 1);
    FoDados.fpgDataFinal := DateToStr(Now - 1);
  end;
  FoTela.tbxlkPesquisarMaisClick(FoTela);
  EnterTextCheckBox(FoTela.tbxckUsuarioCriacao, FoDados.fpgPesquisaUsuarioCriacao);
  EnterTextInto(FoTela.edtUsuarioCriacaoCons.dfCodigo, FoDados.fpgNmUsarioCriacao);
  EnterTextCheckBox(FoTela.tbxckCategoria, FoDados.fpgPesquisaCategoria);
  EnterTextInto(FoTela.edtCategoriaConsPesquisa.dfCodigo, FoDados.fpgCdCategoria);
  EnterTextCheckBox(FoTela.tbxckModelo, FoDados.fpgPesquisaModelo);
  EnterTextInto(FoTela.edtModeloCons.dfCodigo, FoDados.fpgCdModelo);
  EnterTextCheckBox(FoTela.tbxckData, FoDados.fpgPesaquisaOutrasDatas);
  EnterTextInto(FoTela.dxdePeriodoInicial, FoDados.fpgOutraDataInicial);
  EnterTextInto(FoTela.dxdePeriodoFinal, FoDados.fpgOutraDataFinal);
  EnterTextCheckBox(FoTela.tbxckNaPasta, FoDados.fpgPesquinaPasta);
  EnterTextInto(FoTela.dxppedPastas, FoDados.fpgPasta);
  EnterTextCheckBox(FoTela.tbxckDocumentosCompartilhados, FoDados.fpgPesquisaDocCompartilhado);
  EnterTextRadioButton(FoTela.tbxrbDocsCompartilhadosPeloUsuario,
    FoDados.fpgCompartilhaPeloUsuario);
  EnterTextRadioButton(FoTela.tbxrbDocsCompartilhadosAoUsuario, FoDados.fpgCompartilhaAoUsuario);
  EnterTextCheckBox(FoTela.tbxckMovimentacaoPendente, FoDados.fpgPesquisaMovimentacaoPendente);
  EnterTextCheckBox(FoTela.tbxckPesquisarOutrosGrupos, FoDados.fpgPesquisaOutrosGrupos);
end;

procedure TffpgGerenciadorArquivoTests.CompartilharDocumento;
var
  oTelaCompartilhar: TfggpCompartilhamento;
begin
  oTelaCompartilhar := TfggpCompartilhamento(PegarTela('fggpCompartilhamento'));
  EnterTextCheckBox(oTelaCompartilhar.dfrbCompartilhadoComo, True);
  EnterTextInto(oTelaCompartilhar.dfnmCompartilhamento, FoDados.fpgNomeCompartilhar, False);
  oTelaCompartilhar.ccCadastro.Execute(acNovo);
  EnterTextGrid(oTelaCompartilhar.spDBGrid, FoDados.fpgUsuario, 1);
  oTelaCompartilhar.ccCadastro.Execute(acSalvar);
end;

procedure TffpgGerenciadorArquivoTests.VerificarObservacao;
begin
  Click(FoTela.tbxrbTipoDeArquivoDocumentos);
  EnterTextInto(FoTela.sajNumeroProcessoConsulta.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcesso, False);
  FoTela.dximConsultar.Click;
  check(FoTela.eedtGerenciadorArqPesquisa.Locate('CDDOCUMENTO', FoDados.fpgNuDocumento, []));
  Click(FoTela.dbGrid);
  ClicarBotaoDXBar(FoTela, 'O&bservações');
  check(FoTela.pnlOBservacoes.Visible and FoTela.grObservacoesDTCRIACAO.Visible and
    FoTela.grObservacoesCC_NMUSUCRIACAO.Visible and FoTela.grObservacoesFLVERIFICADA.Visible and
    FoTela.grObservacoesDEOBSERVACAO.Visible);
  check(FoDados.VerificaObservacaoEditor(FoDados.fpgNuDocumento, FoDados.fpgObservacao));
  FoTela.imArquivoFechar.Click;
end;

procedure TffpgGerenciadorArquivoTests.AssinarLiberar;
var
  oTelaFinalizar: TfedtSelecaoCeritificadoDigital;
begin
  spVerificadorTelas.RegistrarMensagem(
    'A movimentação vinculada ao documento (se existir) será lançada*', 'Sim');
  FoTela.dxFinalizarDocumento.Click;
  Application.ProcessMessages;
  oTelaFinalizar := TfedtSelecaoCeritificadoDigital(PegarTela('fedtSelecaoCeritificadoDigital'));
  EnterTextRadioGroup(oTelaFinalizar.rgOpcao, FoDados.fpgAcaoFinalizar);
  EnterTextInto(oTelaFinalizar.cbCertificados, FoDados.fpgCertificado);
  Application.ProcessMessages;
  spVerificadorTelas.RegistrarMensagem(
    'O documento selecionado necessita da assinatura de Juiz*', 'Sim');
  oTelaFinalizar.dxbbBotoesSelecionar.Click;
end;

procedure TffpgGerenciadorArquivoTests.SelecionarDocumento;
var
  sImagem: string;
begin
  if not FoTela.dbGrid.DataSource.DataSet.IsEmpty then
  begin
    FoTela.dbGrid.DataSource.DataSet.First;
    while not FoTela.dbGrid.DataSource.DataSet.EOF do
    begin
      if FoTela.tbxckMovimentacaoPendente.Checked then
      begin
        sImagem := FoTela.dbGrid.DataSource.DataSet.FieldByName('CDIMAGEM').AsString;
        if (sImagem <> CS_IMAGEM) and (sImagem <> CS_IMAGEM2) then
        begin
          bAchou := True;
          Break;
        end
        else
          FoTela.dbGrid.DataSource.DataSet.Next;
      end
      else
      begin
        if FoTela.dbGrid.DataSource.DataSet.FieldByName('CDPROCESSO').AsString
          = FoDados.fpgCdProcesso then
        begin
          application.ProcessMessages;
          gsNmDocumento := FoTela.dbGrid.DataSource.DataSet.FieldByName('NMDOCUMENTO').AsString;
          bAchou := True;
          if FoDados.fpgEditarDocumento then
          begin
            FoTela.dxArquivoEditar.click;
          end;
          break;
        end
        else
          FoTela.dbGrid.DataSource.DataSet.Next;
      end;
    end;
    Check(bAchou, 'Documento não encontrado.');
  end
  else
    Check(not FoTela.dbGrid.DataSource.DataSet.IsEmpty, FoTela.tbxlbConsultaHint.Caption);
end;

procedure TffpgGerenciadorArquivoTests.PreencherDadosConsultaPorData;
begin
  if (FoDados.fpgDataInicio = STRING_INDEFINIDO) and
    (FoDados.fpgDataFinal = STRING_INDEFINIDO) then
  begin
    FoDados.fpgDataInicio := DateToStr(Now);
    FoDados.fpgDataFinal := DateToStr(Now);
  end;
  EnterTextCheckBox(FoTela.tbxckDataUltimaAlteracao, FoDados.fpgConsultaData);
  EnterTextInto(FoTela.dxDataUltimaAlteracaoInicio, FoDados.fpgDataInicio);
  EnterTextInto(FoTela.dxDataUltimaAlteracaoFim, FoDados.fpgDataFinal);
end;

procedure TffpgGerenciadorArquivoTests.TestarConsultarPorUltimaAlteracao;
begin
  ExecutarRoteiroTestes(GerenciadorArquivo);
end;

procedure TffpgGerenciadorArquivoTests.TestarConsutarPorProcesso;
begin
  ExecutarRoteiroTestes(GerenciadorArquivo);
end;

procedure TffpgGerenciadorArquivoTests.PreencherDadosConsultaPorNome;
begin
  if FoDados.fpgDescModelo = STRING_INDEFINIDO then
  begin
    FoDados.fpgDescModelo := copy(gsNmDocumento, 0, 15);
  end;

  EnterTextInto(FoTela.dxedNomeDocumento, FoDados.fpgDescModelo, False);
end;

procedure TffpgGerenciadorArquivoTests.TestarConsutarPorNome;
begin
  ExecutarRoteiroTestes(GerenciadorArquivo);
end;

procedure TffpgGerenciadorArquivoTests.TestarConsultaPorUsuarioCriacao;
begin
  ExecutarRoteiroTestes(GerenciadorArquivo);
end;

procedure TffpgGerenciadorArquivoTests.TestarConsultaPorPasta;
begin
  ExecutarRoteiroTestes(GerenciadorArquivo);
end;

procedure TffpgGerenciadorArquivoTests.TestarConsultaPorDocsCompartilhados;
begin
  ExecutarRoteiroTestes(GerenciadorArquivo);
end;

procedure TffpgGerenciadorArquivoTests.TestarConsultaPorOutrasDatas;
begin
  ExecutarRoteiroTestes(GerenciadorArquivo);
end;

procedure TffpgGerenciadorArquivoTests.TestarConsultaPorDocsMovPendentes;
begin
  ExecutarRoteiroTestes(GerenciadorArquivo);
end;

procedure TffpgGerenciadorArquivoTests.TestarConsultaPorOutrosGrupos;
begin
  ExecutarRoteiroTestes(GerenciadorArquivo);
end;

end.


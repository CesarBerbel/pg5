unit ufpgCadProcExcepcionalTests;

interface

uses
  ComCtrls, FutureWindows, ufpgGUITestCase, ufpgCadProcExcepcionalModelTests,
  ufpgCadAudiencia, ufpgCadPautaAudiencia, ufpgDataModelTests, ufpgCadProcExcepcional,
  usajConstante, ufpgDadosDistribExcepcional, ufpgConsVaga;

type
  TffpgCadProcExcepcionalTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadProcExcepcional;
    FoDados: TffpgCadProcExcepcionalModelTests;
    FoDadosArmasBens: TffpgCadArmasBensModelTests;

    procedure CadastroProcesso;
    procedure PreencherDadosProcessuais;
    procedure PreencherDadosDirecionamento;
    procedure AlterarDadosProcesso;
    //Armas e Bens
    procedure PreencherDadosArmas;
    procedure PreencherDadosMunicao;
    procedure PreencherDadosVeiculo;
    procedure PreencherDadosImovel;
    procedure PreencherDadosTitulo;
    procedure PreencherDadosOutrosBens;
    procedure SelecionarStituacaoArmasBens;

    procedure SelecionarJuizDeprecante(poDados: TffpgPrecatoriaModelTests);
    procedure CancelarAudiencia(poTelaPauta: TffpgCadPautaAudiencia);
    procedure DefinirPessoa(poDados: TffpgCadParteRepresModelTests);
    procedure PegarTelaModal(const poWindow: IWindow);
    procedure MudarAba(psAba: TTabSheet);
    //SubRoteiros
    procedure PreencherDadosDP;
    procedure PreencherDadosPrecatoria;
    procedure PreencherDadosPartes;
    procedure PreencherArmasBens;
    procedure PreeencherDadosObjetoAcao;
    procedure PreencherDadosOutrosNumeros;
    procedure PreencherDadosAssunto;
    //Verificações
    procedure VerificarCadastroProcesso;
    procedure VerificarEnderecoPrincipal(const poWindow: IWindow);
    procedure CadastrarEndereco(const poWindow: IWindow);
    procedure PreencherDadosEndereco;
    procedure CadastrarEnderecoPrincipal;
    procedure SelecionarVaga;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadastroProcExepcional;
  end;

implementation

uses
  Windows, DB, SysUtils, TestFramework, Forms, ufpgDadosDistribNormal, uspInterface,
  ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgConsTipoParte, usaj5ConsPessoa,
  ufpgResultadoDistribuicao, ufpgFuncoesGUITestes, usaj5CadJuizoDeprecante,
  ufpgConsEnderecoPessoa, uspGUITestCase, ufpgEdicaoDocumento, ufpgEditor,
  uedtSelecaoCeritificadoDigital, ufpgDigPecaProcessual, ufpgConsTipoDocDigital,
  ufpgConsSituacaoBem, usaj5CadPessoaNormal, ufpgDUnitDAO;

var
  sNuProcesso: string;
  //ffpgCadProcessoTests: TffpgCadProcExcepcional;
  bChecarArmasEBens: boolean;
  bChecarOutrosNumeros: boolean;
  bChecarOutroAssunto: boolean;
  bChecarEnderecoPrincipal: boolean;
  bCheckEnderecoPrincipal: boolean;
  sDirecionada: string;

{ TffpgCadProcessoCompletoTests }

function TffpgCadProcExcepcionalTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadProcExcepcionalModelTests;
end;

procedure TffpgCadProcExcepcionalTests.TestarCadastroProcExepcional;
begin
  ExecutarRoteiroTestes(CadastroProcesso);
end;

procedure TffpgCadProcExcepcionalTests.CadastroProcesso;
var
  sNuProtocolo: string;
begin
  FoDados := TffpgCadProcExcepcionalModelTests(spDataModelTests);
  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgCadProcExcepcional');

  FoTela := TffpgCadProcExcepcional(spTela);

  bChecarArmasEBens := False;
  bChecarOutrosNumeros := False;
  bChecarOutroAssunto := False;
  bChecarEnderecoPrincipal := False;
  bCheckEnderecoPrincipal := False;

  if FoDados.fpgProcessoDependente then
  begin
    sNuProtocolo := copy(LerVariavelExterna(CS_NUPROTOCOLO), 1, 13);
    //EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, sNuProtocolo, False);
    FoTela.dfNuProcesso.FdfNumeroProcessoExterno.SetFocus;
    FoTela.dfNuProcesso.FdfNumeroProcessoExterno.DefineTexto(sNuProtocolo);
    Tab(2);
  end
  else
  if FoDados.fpgProcessoExterno then
  begin
    EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, usarProcessoArray, False);
    AlterarDadosProcesso;
    FoTela.ccCadastro.Execute(acSalvar);
    FecharTela;
    VerificarCadastroProcesso;
    Exit;
  end
  else if FoDados.fpgAbrirDoMenu then
    FoTela.ccCadastro.Execute(acNovo);

  application.ProcessMessages;

  sNuProcesso := SomenteNumeros(FoTela.dfNuProcesso.FdfNumeroProcessoExterno.Text +
    FoTela.dfNuProcesso.FdfNumeroProcessoExterno2.Text +
    FoTela.dfNuProcesso.FdfNumeroDependente.Text);

  IncluirProcessoArray(sNuProcesso);

  PreencherDadosProcessuais;

  ExecutarSubRoteiroTestes(PreencherDadosPartes, 'DadosPartes',
    FoDados.fpgCadParteRepresModelTests);

  ExecutarSubRoteiroTestes(PreencherArmasBens, 'DadosArmasBens',
    FoDados.fpgCadArmasBensModelTests);

  ExecutarSubRoteiroTestes(PreeencherDadosObjetoAcao, 'DadosObjetoAcao',
    FoDados.fpgObjetoAcaoModelTests);

  ExecutarSubRoteiroTestes(PreencherDadosOutrosNumeros, 'DadosOutrosNumeros',
    FoDados.fpgOutrosNumerosModelTests);

  ExecutarSubRoteiroTestes(PreencherDadosAssunto, 'DadosAssunto', FoDados.fpgAssuntoModelTests);

  MudarAba(FoTela.tsDadosProcessuais);
  EnterTextInto(FoTela.cbTpSigilo, FoDados.fpgTipoSigilo, False);

  FoTela.ccCadastro.Execute(acSalvar);

  if FoTela.cbTpSigilo.Text <> CS_SIGILO_ABSOLUTO then
  begin
    FoTela.ccCadastro.Execute(acLimpar);
    TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
    EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, sNuProcesso, False);
    gsCdProcesso := FoTela.dfNuProcesso.prpCdProcesso;
  end;

  if FoDados.fpgUsarArquivoExterno then
  begin
    GravarVariavelExterna(CS_NUPROCESSO, sNuProcesso);
    GravarVariavelExterna(CS_CDPROCESSO, gsCdProcesso);
    GravarVariavelExterna(CS_CDVARA, FoDados.fpgCodVaraDirecionada);
    GravarVariavelExterna(CS_CDFORO, FoDados.fpgForo);
  end;

  FecharTela;
  VerificarCadastroProcesso;
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosProcessuais;
begin
  MudarAba(FoTela.tsDadosProcessuais);

  gsCliente := FoDados.RetornarSiglaCliente;

  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    EnterTextInto(FoTela.csClasse.dfCodigo, FoDados.fpgClasse);
    CheckCampoPreenchido(FoTela.csClasse.dfDescricao, FoDados);
    EnterTextInto(FoTela.csCompetencia.dfCdTipoCartorio, FoDados.fpgCompetencia);
    CheckCampoPreenchido(FoTela.csCompetencia.dfDeTipoCartorio, FoDados);
    sDirecionada := CS_TIPO_DISTRIBUICAO_DIRECIONADA_SC;
  end
  else
  begin
    EnterTextInto(FoTela.csCompetencia.dfCdTipoCartorio, FoDados.fpgCompetencia);
    CheckCampoPreenchido(FoTela.csCompetencia.dfDeTipoCartorio, FoDados);
    EnterTextInto(FoTela.csClasse.dfCodigo, FoDados.fpgClasse);
    CheckCampoPreenchido(FoTela.csClasse.dfDescricao, FoDados);
    sDirecionada := CS_TIPO_DISTRIBUICAO_DIRECIONADA;
  end;

  EnterTextInto(FoTela.csAssuntoForm.dfCodigo, FoDados.fpgAssuntoPrincipal, False);
  CheckCampoPreenchido(FoTela.csAssuntoForm.dfDescricao, FoDados);

  EnterTextInto(FoTela.cbArea, FoDados.fpgArea);
  EnterTextInto(FoTela.dfQtVolume, FoDados.fpgVolumes);

  if (not FoDados.fpgSemCustasIniciais) and FoTela.dfNumeroGRJ.EstaNulo and
    (gsCliente <> CS_CLIENTE_PG5_TJSP) then
    spVerificadorTelas.RegistrarMensagem(
      'A GRJ não foi informada. Deseja salvar o processo assim mesmo?', '&Sim')
  else
  begin
    FoTela.ckSemCustaInicial.Checked := FoDados.fpgSemCustasIniciais;
    FoTela.efpgProcesso.FieldByName('flSemCustaInicial').AsString := 'S';
  end;

  EnterTextInto(FoTela.dfVlCausa, FoDados.fpgValoracao);
  EnterTextInto(FoTela.dfDtVlAcao, FoDados.fpgDataValoracao);

  EnterTextInto(FoTela.cbTipoDistrib, FoDados.fpgTipoDistribuicao, False);

  if FoDados.fpgTipoDistribuicao <> 'Sorteio'{CS_PROCESSO_CIVIL_GENERICO_SORTEIO} then
    PreencherDadosDirecionamento;

  if FoTela.csMunicipio.dfcdMunicipio.Enabled then
    EnterTextInto(FoTela.csMunicipio.dfcdMunicipio, FoDados.fpgMunicipio);

  if FoTela.mmObjeto.Enabled then
    EnterTextInto(FoTela.mmObjeto, FoDados.fpgObjetoAcao);

  ExecutarSubRoteiroTestes(PreencherDadosDP, CS_ABA_DADOS_DELEGACIA,
    FoDados.fpgDelegaciaModelTests);

  ExecutarSubRoteiroTestes(PreencherDadosPrecatoria, CS_ABA_DADOS_PRECATORIA,
    FoDados.fpgPrecatoriaModelTests);
end;

procedure TffpgCadProcExcepcionalTests.MudarAba(psAba: TTabSheet);
begin
  if FoTela.pcCadProcesso.ActivePage <> psAba then
  begin
    FoTela.pcCadProcesso.ActivePage := psAba;
    FoTela.pcCadProcessoChange(FoTela);
  end;
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosDirecionamento;
var
  oTelaDistribuicao: TffpgDadosDistribExcepcional;
begin
  oTelaDistribuicao := PegarTela('ffpgDadosDistribExcepcional') as TffpgDadosDistribExcepcional;
  oTelaDistribuicao.csTipoProcessoPrev.ItemIndex := 1;
  EnterTextInto(oTelaDistribuicao.csvara.dfcdVara, FoDados.fpgVara);
  oTelaDistribuicao.csVaga.pbConsulta.Click;
  SelecionarVaga;
  EnterTextInto(oTelaDistribuicao.wflFilaTrabalhoConsPrev.dfcdFila, FoDados.fpgCdFila);
  Tab;
  spVerificadorTelas.RegistrarMensagem(
    'Certifique-se de que a data de distribuição informada está correta. Esta data acarretará no aumento do peso da vara. Deseja continuar?',
    'Sim');
  oTelaDistribuicao.ccCadastro.Execute(acSalvar);
end;

procedure TffpgCadProcExcepcionalTests.SelecionarVaga;
var
  oTelaVaga: TffpgConsVaga;
  bEncontrou: boolean;
begin
  oTelaVaga := PegarTela('ffpgConsVaga') as TffpgConsVaga;
  bEncontrou := oTelaVaga.grDados.DataSource.DataSet.Locate('CDVAGA', Fodados.fpgVaga, []);
  check(bEncontrou, 'Vaga não localizada');
  oTelaVaga.ccCadastro.Execute(acSelecionar);
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosDP;
var
  oModelDP: TffpgDelegaciaModelTests;
begin
  oModelDp := FoDados.fpgDelegaciaModelTests;

  if oModelDp.fpgDataDelito = STRING_INDEFINIDO then
    oModelDp.fpgDataDelito := FormatDateTime('dd/mm/yy', Now);

  EnterTextInto(FoTela.dfdtInfracao, oModelDp.fpgDataDelito, False);

  //Foi setado o valor no dataset porque o componente de TspDateTimeCombo com o metodo EnterTextInto
  // do teste não estava passando o valor para o datafield associado.
  if not (FoTela.efpgProcesso.State in [dsEdit, dsInsert]) then
    FoTela.efpgProcesso.Edit;
  FoTela.efpgProcesso.FindField('dtFato').Value := oModelDp.fpgDataDelito;

  EnterTextGrid(FoTela.grDadosDP, oModelDp.fpgCodDistrito, 0);
  EnterTextGrid(FoTela.grDadosDP, oModelDp.fpgAutoridade, 1);
  EnterTextGrid(FoTela.grDadosDP, oModelDp.fpgCodDocumento, 2);

  if oModelDp.fpgNuDocumento = STRING_INDEFINIDO then
    oModelDp.fpgNuDocumento := IntToStr(Random(99999)) + '/' + FormatDateTime('yyyy', Now);

  EnterTextGrid(FoTela.grDadosDP, oModelDp.fpgNuDocumento, 3);
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosPrecatoria;
var
  oModelPrecatoria: TffpgPrecatoriaModelTests;
begin
  oModelPrecatoria := FoDados.fpgPrecatoriaModelTests;

  EnterTextInto(FoTela.csComarca.dfcdMunicipio, oModelPrecatoria.fpgCdMunicipio);
  EnterTextInto(FoTela.dfNuOrigemPrecatoria, oModelPrecatoria.fpgNuOriPrecatoria);

  if oModelPrecatoria.fpgJuizoDeprecante <> '' then
  begin
    FoTela.pbJuizoDeprec.Click;
    SelecionarJuizDeprecante(oModelPrecatoria);
  end;
end;

procedure TffpgCadProcExcepcionalTests.SelecionarJuizDeprecante(
  poDados: TffpgPrecatoriaModelTests);
var
  oTelaJuizDeprec: Tfsaj5CadJuizoDeprecante;
begin
  oTelaJuizDeprec := PegarTela('fsaj5CadJuizoDeprecante') as Tfsaj5CadJuizoDeprecante;
  EnterTextInto(oTelaJuizDeprec.csComarca.dfcdMunicipio, poDados.fpgCdMunicipio);
  EnterTextInto(oTelaJuizDeprec.dfnmPessoaCons, poDados.fpgJuizoDeprecante);
  oTelaJuizDeprec.pcPastaCadastro.ActivePageIndex := 0;
  oTelaJuizDeprec.pbPesquisar.Click;
  TFutureWindows.Expect('TMessageForm').ExecProc(PressionarSimNaTelaDeConfirmacao);
  oTelaJuizDeprec.ccPai.Execute(acSelecionar);
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosPartes;
var
  oModelPartes: TffpgCadParteRepresModelTests;
  oTelaConsTipoParte: TffpgConsTipoParte;
begin
  oModelPartes := FoDados.fpgCadParteRepresModelTests;

  MudarAba(FoTela.tsParticipacao);

  {$Hints Off}
  oTelaConsTipoParte := TffpgConsTipoParte(PegarTela('ffpgConsTipoParte', False, 0));
  try
    if oTelaConsTipoParte <> nil then
    begin
      EnterTextGrid(oTelaConsTipoParte.grFiltro, oModelPartes.fpgTipoParticipacao, 0);
      oTelaConsTipoParte.ccCadastro.Execute(acSelecionar);
      application.ProcessMessages;
    end
    else {if FoTela.fpgProcessoParte.csTipoParte.dfcdTipoParte.EstaNulo then }
    begin
      if UpperCase(oModelPartes.fpgPolo) = 'A' then
        FoTela.fpgProcessoParte.pbNovaParteAtiva.Click
      else if UpperCase(oModelPartes.fpgPolo) = 'P' then
        FoTela.fpgProcessoParte.pbNovaPartePassiva.Click
      else if UpperCase(oModelPartes.fpgPolo) = 'R' then
        FoTela.fpgProcessoParte.pbNovoAdvogado.Click
      else if UpperCase(oModelPartes.fpgPolo) = 'T' then
        FoTela.fpgProcessoParte.pbNovoTerceiro.Click
      else if UpperCase(oModelPartes.fpgPolo) = 'TE' then
        FoTela.fpgProcessoParte.pbNovaTestemunha.Click;

      oTelaConsTipoParte := TffpgConsTipoParte(PegarTela('ffpgConsTipoParte', False, 0));
      if oTelaConsTipoParte <> nil then
      begin
        EnterTextGrid(oTelaConsTipoParte.grFiltro, oModelPartes.fpgTipoParticipacao, 0);
        oTelaConsTipoParte.grDados.DataSource.DataSet.First;
        while not oTelaConsTipoParte.grDados.DataSource.DataSet.EOF do
        begin
          if oTelaConsTipoParte.grDados.DataSource.DataSet.FieldByName('CDTIPOPARTE').AsString =
            oModelPartes.fpgTipoParticipacao then
          begin
            oTelaConsTipoParte.ccCadastro.Execute(acSelecionar);
            break;
          end
          else
            oTelaConsTipoParte.grDados.DataSource.DataSet.Next;
        end;
        application.ProcessMessages;
      end
      else
      begin
        EnterTextInto(FoTela.fpgProcessoParte.csTipoParte.dfcdTipoParte,
          oModelPartes.fpgTipoParticipacao);
      end;
    end;

    DefinirPessoa(oModelPartes);

    EnterTextInto(FoTela.fpgProcessoParte.cbTipoPessoa, oModelPartes.fpgTipoPessoa);
    EnterTextInto(FoTela.fpgProcessoParte.cbNacionalidade, oModelPartes.fpgNacionalidade);
    EnterTextInto(FoTela.fpgProcessoParte.cbEstadoCivil, oModelPartes.fpgEstadoCivil);
    EnterTextInto(FoTela.fpgProcessoParte.csProfissao.dfcdProfissao, oModelPartes.fpgProfissao);
    EnterTextInto(FoTela.fpgProcessoParte.csComplParte.dfcdComplParte,
      oModelPartes.fpgComplemento);
    EnterTextInto(FoTela.fpgProcessoParte.sajEndereco.dfCEP, oModelPartes.fpgCEP);
    EnterTextInto(FoTela.fpgProcessoParte.sajEndereco.csMunicipio.dfcdMunicipio,
      oModelPartes.fpgMunicipio);

    if oModelPartes.fpgNumero = STRING_INDEFINIDO then
      oModelPartes.fpgNumero := IntToStr(Random(999));

    if (FoTela.fpgProcessoParte.sajEndereco.dfNumero.PegaTexto = STRING_INDEFINIDO) and
      (FoTela.fpgProcessoParte.sajEndereco.dfCEP.PegaTexto <> STRING_INDEFINIDO) then
      EnterTextInto(FoTela.fpgProcessoParte.sajEndereco.dfNumero, oModelPartes.fpgNumero, False);

    if oModelPartes.fpgEnderecoPrincipal then //dar uma olhada
      bChecarEnderecoPrincipal := oModelPartes.fpgEnderecoPrincipal; //dar uma olhada
    sleep(2000);
  finally
    oTelaConsTipoParte := nil;
  end;
end;

procedure TffpgCadProcExcepcionalTests.DefinirPessoa(poDados: TffpgCadParteRepresModelTests);
begin
  if poDados.fpgCPF = STRING_INDEFINIDO then
  begin
    poDados.fpgCPF := RetornaCPFValido;
    EnterTextInto(FoTela.fpgProcessoParte.dfCPF, poDados.fpgCPF, False);
  end;

  if poDados.fgpPreencherPeloCodigoPessoa then
  begin
    if poDados.fpgEsperaMensagemAdvPoloContrario then
      spVerificadorTelas.RegistrarMensagem(
        'Este representante já está vinculado a uma parte do polo contrário. Deseja continuar?*',
        'Sim');
    EnterTextInto(FoTela.fpgProcessoParte.dfcdPessoa, poDados.fpgCdPessoa);
  end
  else
  if poDados.fpgGerarNomeParteAleatorio then
  begin

    poDados.fpgNomeParte := FoTela.fpgProcessoParte.csTipoParte.dfdeCompTipoParte.PegaTexto +
      ' ' + sNuProcesso;

    if UpperCase(poDados.fpgPolo) = 'A' then
      gsNomeParteAtivaCPF := poDados.fpgNomeParte + poDados.fpgCPF
    else if UpperCase(poDados.fpgPolo) = 'P' then
      gsNomePartePassivaCPF := poDados.fpgNomeParte + poDados.fpgCPF
    else if UpperCase(poDados.fpgPolo) = 'R' then
      gsNomeParteRepresentanteCPF := poDados.fpgNomeParte + poDados.fpgCPF
    else if UpperCase(poDados.fpgPolo) = 'T' then
      gsNomeParteTestemunhaCPF := poDados.fpgNomeParte + poDados.fpgCPF;

    TFutureWindows.Expect('Tfsaj5ConsPessoa').ExecProc(PegarTelaModal);
    EnterTextInto(FoTela.fpgProcessoParte.dfnmPessoa, poDados.fpgNomeParte);
  end
  else
  begin
    TFutureWindows.Expect('Tfsaj5ConsPessoa').ExecProc(PegarTelaModal);
    EnterTextInto(FoTela.fpgProcessoParte.dfnmPessoa, poDados.fpgNomeParte);
  end;
  Tab;
end;

procedure TffpgCadProcExcepcionalTests.PegarTelaModal(const poWindow: IWindow);
var
  oTelaConsPessoa: Tfsaj5ConsPessoa;
begin
  oTelaConsPessoa := poWindow.asControl as Tfsaj5ConsPessoa;
  oTelaConsPessoa.ccCadastro.Execute(acSelecionar);
end;

procedure TffpgCadProcExcepcionalTests.PreeencherDadosObjetoAcao;
var
  oModelObjetoAcao: TffpgObjetoAcaoModelTests;
begin
  oModelObjetoAcao := FoDados.fpgObjetoAcaoModelTests;

  MudarAba(FoTela.tsObjetoAcao);
  EnterTextInto(FoTela.dfdeObjetoAcao, oModelObjetoAcao.fpgObjetoAcao);
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosOutrosNumeros;
var
  oModelOutrosNumeros: TffpgOutrosNumerosModelTests;
begin
  oModelOutrosNumeros := FoDados.fpgOutrosNumerosModelTests;
  bChecarOutrosNumeros := True;
  MudarAba(FoTela.tsObservacao);
  FoTela.ccOutroNumero.Execute(acNovo);
  EnterTextGrid(FoTela.grDadosOutroNumero, oModelOutrosNumeros.fpgOutroNumero, 0);
  EnterTextGrid(FoTela.grDadosOutroNumero, oModelOutrosNumeros.fpgDescricao, 1);
  EnterTextInto(FoTela.dfdeObservacao, oModelOutrosNumeros.fpgObservacao);
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosAssunto;
var
  oModelAssunto: TffpgAssuntoModelTests;
begin
  oModelAssunto := FoDados.fpgAssuntoModelTests;
  bChecarOutroAssunto := True;
  MudarAba(FoTela.tsAssuntos);
  FoTela.ccAssuntos.Execute(acNovo);
  EnterTextGrid(FoTela.grDadosAssuntos, oModelAssunto.fpgFlPrincipal, 0);
  EnterTextGrid(FoTela.grDadosAssuntos, oModelAssunto.fpgCdAssunto, 1);
  EnterTextGrid(FoTela.grDadosAssuntos, oModelAssunto.fpgCdAssuntoCompl, 2);
  EnterTextGrid(FoTela.grDadosAssuntos, oModelAssunto.fpgFlEtiqueta, 3);
end;

//procedure TffpgCadProcessoTests.AgendarAudiencia;
//var
//  oTelaPauta: TffpgCadPautaAudiencia;
//begin
//  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
//  FoTela.pbAgendaConciliacao.Click;

//  oTelaPauta := TffpgCadPautaAudiencia(PegarTela('ffpgCadPautaAudiencia'));

//  EnterTextInto(oTelaPauta.ggpTipoAudienciaCons.dfCodigo, FoDados.fpgTipoAudiencia);
//  EnterTextInto(oTelaPauta.dxdePeriodoInicial, DateToStr(Now));
//  oTelaPauta.tbxiLocalizarHorario.Click;

//  oTelaPauta.TBXItem2.Click;

//  if FoDados.fpgCancelarAudiencia then
//    CancelarAudiencia(oTelaPauta);

//  oTelaPauta.imArquivoFechar.Click;
//end;

procedure TffpgCadProcExcepcionalTests.CancelarAudiencia(poTelaPauta: TffpgCadPautaAudiencia);
var
  oTelapropriedades: TffpgCadAudiencia;
  i: integer;
begin
  i := poTelaPauta.planAudiencia.Items.Count - 1;
  poTelaPauta.planAudiencia.items[i].Selected := True;
  Application.ProcessMessages;
  poTelaPauta.planAudiencia.items[i].Focus := True;
  poTelaPauta.planAudienciaItemRightClick(poTelaPauta.planAudiencia,
    poTelaPauta.planAudiencia.items[i]);
  poTelaPauta.acPropriedadesAudiencia.Execute;
  oTelapropriedades := TffpgCadAudiencia(PegarTela('ffpgCadAudiencia'));
  EnterTextInto(otelapropriedades.ggpSituacaoAudiConsDados.dfCodigo, FoDados.fpgSituacaoAudiencia);
  oTelapropriedades.dxbbBotoesSalvar.Click;

end;

//procedure TffpgCadProcessoTests.EmitirDocumento;
//var
//  oTelaEdicao: TffpgEdicaoDocumento;
//begin
//  FoTela.pbEmiteDocumentos.Click;
//  oTelaEdicao := TffpgEdicaoDocumento(PegarTela('ffpgEdicaoDocumento'));

//  EnterTextInto(oTelaEdicao.edtCategoriaCons.dfCodigo, FoDados.fpgCdCategoriaDoc);
//  EnterTextInto(oTelaEdicao.edtModeloCons.dfCodigo, FoDados.fpgCdModeloCategoriaDoc);

//  oTelaEdicao.pcParametrosIntercalacao.ActivePage := oTelaEdicao.tsPartesDestinatarias;
//  oTelaEdicao.btnTodasPartes.Click;
//  oTelaEdicao.dxbbBotoesSalvar.Click;
//  oTelaEdicao.dxbbBotoesSelecionar.click;
//  EditarDocumento;
//  oTelaEdicao.dxbbBotoesFecharForm.Click;
//end;

//procedure TffpgCadProcessoTests.EditarDocumento;
//var
//  OTelaEditor: TffpgEditor;
//begin
//  OTelaEditor := TffpgEditor(PegarTela('ffpgEditor'));
//  OTelaEditor.dxFinalizarDocumento.Click;
//  Application.ProcessMessages;
//  FinalizarDocumento;
//  OTelaEditor.dxbbArquivoFecharEditor.Click;
//end;

//procedure TffpgCadProcessoTests.FinalizarDocumento;
//var
//  oTelaFinalizar: TfedtSelecaoCeritificadoDigital;
//begin
//  oTelaFinalizar := TfedtSelecaoCeritificadoDigital(PegarTela('fedtSelecaoCeritificadoDigital'));

//  spVerificadorTelas.RegistrarMensagem(
//    'O documento selecionado necessita da assinatura de Juiz.*', 'Sim');
//  EnterTextRadioGroup(oTelaFinalizar.rgOpcao, '&Assinar e liberar nos autos digitais');
//  EnterTextInto(oTelaFinalizar.cbCertificados, FoDados.fpgCertificado);
//  oTelaFinalizar.dxbbBotoesSelecionar.Click;
//end;

//procedure TffpgCadProcessoTests.DigitalizarPecas;
//var
//  oTelaDigPecas: TffpgDigPecaProcessual;
//  oTelaTipoDoc: TffpgConsTipoDocDigital;
//begin
//  FoTela.pbDigitalizar.Click;
//  oTelaDigPecas := TffpgDigPecaProcessual(PegarTela('ffpgDigPecaProcessual'));
//  oTelaDigPecas.pbNovaPeca.Click;

//  spVerificadorTelas.RegistrarMensagem('Deseja digitalizar outra página deste documento?', 'Não');
//  oTelaTipoDoc := TffpgConsTipoDocDigital(PegarTela('ffpgConsTipoDocDigital'));
//  oTelaTipoDoc.ccCadastro.Execute(acSelecionar);

//  oTelaDigPecas.ccCadastro.Execute(acSalvar);
//end;

procedure TffpgCadProcExcepcionalTests.PreencherArmasBens;
begin
  FoDadosArmasBens := FoDados.fpgCadArmasBensModelTests;
  MudarAba(FoTela.tsArmasBens);
  bChecarArmasEBens := True;

  FoTela.fpgArmasBens.ccBem.Execute(acNovo);

  EnterTextInto(FoTela.fpgArmasBens.csCategoriaBem.dfcdCategoriaBem,
    FoDadosArmasBens.fpgdfcdCategoriaBem);
  EnterTextInto(FoTela.fpgArmasBens.dfdtEntrada, DateToStr(Now));
  EnterTextInto(FoTela.fpgArmasBens.dfNuControle, FoDadosArmasBens.fpgdfNuControle);
  EnterTextInto(FoTela.fpgArmasBens.dfdtSituacaoBem, DateToStr(Now));

  if FoDadosArmasBens.fpgcsSituacaoBem <> '' then
    SelecionarStituacaoArmasBens;

  Application.ProcessMessages;
  EnterTextInto(FoTela.fpgArmasBens.dfdtLocalFisico, DateToStr(Now));
  EnterTextInto(FoTela.fpgArmasBens.dfdeLocalFisico, FoDadosArmasBens.fpgdfdeLocalFisico);
  EnterTextInto(FoTela.fpgArmasBens.dfnmDepositario, FoDadosArmasBens.fpgdfnmDepositario);

  case StrToInt(FoDadosArmasBens.fpgdfcdCategoriaBem) of
    CN_BEM_ARMA: PreencherDadosArmas;
    CN_BEM_MUNICAO: PreencherDadosMunicao;
    CN_BEM_VEICULO: PreencherDadosVeiculo;
    CN_BEM_IMOVEL: PreencherDadosImovel;
    CN_BEM_TITULO: PreencherDadosTitulo;
    CN_BEM_OUTROSBENS: PreencherDadosOutrosBens;
  end;
end;

procedure TffpgCadProcExcepcionalTests.SelecionarStituacaoArmasBens;
var
  oTelaSitBem: TffpgConsSituacaoBem;
begin
  FoTela.fpgArmasBens.csSituacaoBem.pbConsulta.Click;
  oTelaSitBem := TffpgConsSituacaoBem(PegarTela('ffpgConsSituacaoBem'));
  oTelaSitBem.efpgSituacaoBem.Locate('CDSITUACAOBEM', FoDadosArmasBens.fpgcsSituacaoBem, []);
  oTelaSitBem.ccCadastro.Execute(acSelecionar);
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosArmas;
begin
  EnterTextInto(FoTela.fpgArmasBens.dfdeArma, FoDadosArmasBens.fpgdfdeArma);
  EnterTextInto(FoTela.fpgArmasBens.dfdeSerieArma, FoDadosArmasBens.fpgdfdeSerieArma);
  EnterTextInto(FoTela.fpgArmasBens.dfdeCorArma, FoDadosArmasBens.fpgdfdeCorArma);
  EnterTextInto(FoTela.fpgArmasBens.dfdeMarcaArma, FoDadosArmasBens.fpgdfdeMarcaArma);
  EnterTextInto(FoTela.fpgArmasBens.dfdeDimensaoArma, FoDadosArmasBens.fpgdfdeDimensaoArma);
  EnterTextInto(FoTela.fpgArmasBens.dfdeCalibreArma, FoDadosArmasBens.fpgdfdeCalibreArma);
  EnterTextInto(FoTela.fpgArmasBens.dfdeCaboArma, FoDadosArmasBens.fpgdfdeCaboArma);
  EnterTextInto(FoTela.fpgArmasBens.mmdeComplementoArma, FoDadosArmasBens.fpgmmdeComplementoArma);
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosMunicao;
begin
  FoTela.fpgArmasBens.ccItemBem.Execute(acNovo);
  EnterTextGrid(FoTela.fpgArmasBens.grMunicao, FoDadosArmasBens.fpgdeItemBemMunicao, 0);
  EnterTextGrid(FoTela.fpgArmasBens.grMunicao, FoDadosArmasBens.fpgqtIntactaMunicao, 1);
  EnterTextGrid(FoTela.fpgArmasBens.grMunicao, FoDadosArmasBens.fpgqtDeflagradaMunicao, 2);
  EnterTextGrid(FoTela.fpgArmasBens.grMunicao, FoDadosArmasBens.fpgdeComplementoMunicao, 3);
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosVeiculo;
begin
  EnterTextInto(FoTela.fpgArmasBens.dfnuRenavan, FoDadosArmasBens.fpgdfnuRenavan);
  EnterTextInto(FoTela.fpgArmasBens.dfnuPlaca, FoDadosArmasBens.fpgdfnuPlaca);
  EnterTextInto(FoTela.fpgArmasBens.dfnuChassi, FoDadosArmasBens.fpgdfnuPlaca);
  EnterTextInto(FoTela.fpgArmasBens.dfdeEspecieTipo, FoDadosArmasBens.fpgdfdeEspecieTipo);
  EnterTextInto(FoTela.fpgArmasBens.dfdeMarcaModelo, FoDadosArmasBens.fpgdfdeMarcaModelo);
  EnterTextInto(FoTela.fpgArmasBens.dfnuAnoFab, FoDadosArmasBens.fpgdfnuAnoFab);
  EnterTextInto(FoTela.fpgArmasBens.dfnuAnoMod, FoDadosArmasBens.fpgdfnuAnoMod);
  EnterTextInto(FoTela.fpgArmasBens.dfdeCor, FoDadosArmasBens.fpgdfdeCor);
  EnterTextInto(FoTela.fpgArmasBens.dfnmProprietario, FoDadosArmasBens.fpgdfnmProprietario);
  EnterTextInto(FoTela.fpgArmasBens.mmdeComplemento, FoDadosArmasBens.fpgmmdeComplemento);
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosImovel;
begin
  EnterTextInto(FoTela.fpgArmasBens.dfnuRegistro, FoDadosArmasBens.fpgdfnuRegistro);
  EnterTextInto(FoTela.fpgArmasBens.dfNuMatricula, FoDadosArmasBens.fpgdfNuMatricula);
  EnterTextInto(FoTela.fpgArmasBens.dfdtAvaliacaoImovel, FoDadosArmasBens.fpgdfdtAvaliacaoImovel);
  EnterTextInto(FoTela.fpgArmasBens.dfvlAvaliacaoImovel, FoDadosArmasBens.fpgdfvlAvaliacaoImovel);
  EnterTextInto(FoTela.fpgArmasBens.sajEndereco.dfCEP, FoDadosArmasBens.fpgdfCEP);
  EnterTextInto(FoTela.fpgArmasBens.sajEndereco.csMunicipio.dfcdMunicipio,
    FoDadosArmasBens.fpgdfcdMunicipio);
  EnterTextInto(FoTela.fpgArmasBens.sajEndereco.dfdeBairro, FoDadosArmasBens.fpgdfdeBairro);
  EnterTextInto(FoTela.fpgArmasBens.sajEndereco.dfdeLogradouro,
    FoDadosArmasBens.fpgdfdeLogradouro);
  EnterTextInto(FoTela.fpgArmasBens.sajEndereco.dfNumero, FoDadosArmasBens.fpgdfNumero);
  EnterTextInto(FoTela.fpgArmasBens.mmdeComplemento, FoDadosArmasBens.fpgdfdeComplemento);
  EnterTextInto(FoTela.fpgArmasBens.dfdeImovel, FoDadosArmasBens.fpgdfdeImovel);
  EnterTextInto(FoTela.fpgArmasBens.rgProprietario, FoDadosArmasBens.fpgrgProprietario);
  EnterTextInto(FoTela.fpgArmasBens.dfNmProprietarioImovel,
    FoDadosArmasBens.fpgdfNmProprietarioImovel);
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosTitulo;
begin
  EnterTextInto(FoTela.fpgArmasBens.dfqtBemTitulo, FoDadosArmasBens.fpgdfqtBemTitulo);
  EnterTextInto(FoTela.fpgArmasBens.dfVlTitulo, FoDadosArmasBens.fpgdfqtBemTitulo);
  EnterTextInto(FoTela.fpgArmasBens.mmComplTitulo, FoDadosArmasBens.fpgmmdeComplemento);
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosOutrosBens;
begin
  EnterTextGrid(FoTela.fpgArmasBens.grOutrosBensObj, FoDadosArmasBens.fpgdeItemBem, 0);
  EnterTextGrid(FoTela.fpgArmasBens.grOutrosBensObj, FoDadosArmasBens.fpgqtIntacta, 1);
  EnterTextGrid(FoTela.fpgArmasBens.grOutrosBensObj, FoDadosArmasBens.fpgdeComplemento, 2);
end;

procedure TffpgCadProcExcepcionalTests.VerificarCadastroProcesso;
begin
  checkTrue(FoDados.VerificarCadastroProcesso(sNuProcesso, gsCdProcesso,
    FoDados.fpgTipoSigilo, FoDados.spUsuario), 'O processo não foi cadastrado na base');

  //  if bChecarArmasEBens then
  //    Check(FoDados.VerificarArmasEBensCadastrado(
  //      FoDados.fpgCadArmasBensModelTests.fpgdfcdCategoriaBem,
  //      FoDados.fpgCadArmasBensModelTests.fpgdfdeLocalFisico, sNuProcesso),
  //      'Arma ou bem não cadastrado.');

  if bChecarArmasEBens then
    Application.ProcessMessages;

  if bChecarOutrosNumeros then
    Check(FoDados.VerificarOutrosNumerosObservacao(
      FoDados.fpgOutrosNumerosModelTests.fpgOutroNumero,
      FoDados.fpgOutrosNumerosModelTests.fpgDescricao,
      FoDados.fpgOutrosNumerosModelTests.fpgObservacao,
      sNuProcesso), 'Outros números e observação não cadastrado.');
  if bChecarOutroAssunto then
    Check(FoDados.VerificarOutroAssunto(FoDados.fpgAssuntoModelTests.fpgCdAssunto,
      FoDados.fpgAssuntoModelTests.fpgFlPrincipal, FoDados.fpgAssuntoModelTests.fpgFlEtiqueta,
      sNuProcesso), 'Não foi possível cadastrar outro assunto.');
  if bChecarEnderecoPrincipal then
    Check(bCheckEnderecoPrincipal, 'Endereço principal não selecionado.');
end;

procedure TffpgCadProcExcepcionalTests.CadastrarEnderecoPrincipal;
var
  oTelaEnd: TffpgConsEnderecoPessoa;
begin
  bChecarEnderecoPrincipal := True;
  MudarAba(FoTela.tsParticipacao);
  FoTela.fpgProcessoParte.tvProcessoParte.Items.Item[0].Item[1].Selected := True;
  if FoTela.fpgProcessoParte.sajEndereco.dfCEP.PegaTexto = STRING_INDEFINIDO then
  begin
    TFutureWindows.Expect('TffpgConsEnderecoPessoa').ExecProc(CadastrarEndereco);
    FoTela.fpgProcessoParte.pbConsultarEndereco.Click;
  end;
  application.ProcessMessages;
  if FoDados.fpgCadEnderecoModelTests.fpgEnderecoPrincipal then
  begin
    TFutureWindows.Expect('TffpgConsEnderecoPessoa').ExecProc(VerificarEnderecoPrincipal);
    FoTela.fpgProcessoParte.pbConsultarEndereco.Click;
  end;
end;

procedure TffpgCadProcExcepcionalTests.CadastrarEndereco(const poWindow: IWindow);
var
  oTelaEnd: TffpgConsEnderecoPessoa;
begin
  oTelaEnd := poWindow.asControl as TffpgConsEnderecoPessoa;
  oTelaEnd.ccCadastro.Execute(acNovo);
  PreencherDadosEndereco;
  oTelaEnd.grDados.DataSource.DataSet.First;
  oTelaEnd.grDados.DataSource.DataSet.Edit;
  oTelaEnd.grDados.DataSource.DataSet.FieldByName('CC_PRINCIPAL').AsString := sFLAG_SIM;
  oTelaEnd.grDados.DataSource.DataSet.Post;
  oTelaend.ccCadastro.Execute(acSalvar);
end;


procedure TffpgCadProcExcepcionalTests.AlterarDadosProcesso;
begin
  ExecutarSubRoteiroTestes(CadastrarEnderecoPrincipal, 'DadosEndereco',
    FoDados.fpgCadEnderecoModelTests);
end;

procedure TffpgCadProcExcepcionalTests.VerificarEnderecoPrincipal(const poWindow: IWindow);
var
  oTelaEnd: TffpgConsEnderecoPessoa;
begin
  oTelaEnd := poWindow.asControl as TffpgConsEnderecoPessoa;
  while not oTelaEnd.grDados.DataSource.DataSet.EOF do
  begin
    if oTelaEnd.grDados.DataSource.DataSet.FieldByName('CC_PRINCIPAL').AsString = sFLAG_SIM then
    begin
      bCheckEnderecoPrincipal := True;
      Break;
    end
    else
      oTelaEnd.grDados.DataSource.DataSet.Next;
  end;
  oTelaEnd.ccCadastro.Execute(acFecharForm);
end;

procedure TffpgCadProcExcepcionalTests.PreencherDadosEndereco;
var
  oTelaCadEndereco: Tfsaj5CadPessoaNormal;
  oModelPartes: TffpgCadEnderecoModelTests;
begin
  oModelPartes := FoDados.fpgCadEnderecoModelTests;
  oTelaCadEndereco := PegarTela('fsaj5CadPessoaNormal') as Tfsaj5CadPessoaNormal;
  EnterTextInto(oTelaCadEndereco.sajEndereco.dfCEP, oModelPartes.fpgCEP, False);
  EnterTextInto(oTelaCadEndereco.sajEndereco.dfNumero, IntToStr(Random(999)), False);
  oTelaCadEndereco.dm.ccPessoaEndereco.Novo;
  EnterTextInto(oTelaCadEndereco.sajEndereco.dfCEP, oModelPartes.fpgCEP, False);
  EnterTextInto(oTelaCadEndereco.sajEndereco.dfNumero, IntToStr(Random(999)), False);
  oTelaCadEndereco.bcBotoesCadastro.spControleCadastro.Execute(acSalvar);
  oTelaCadEndereco.bcBotoesCadastro.spControleCadastro.Execute(acFecharForm);
end;

end.


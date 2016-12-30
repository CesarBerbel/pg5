// 22/12/2015 - cesar.almeida - SALT: 186660/23/2
// Refatoração da classe
unit ufpgCadProcessoTests;

interface

uses
  ComCtrls, FutureWindows, ufpgGUITestCase, ufpgCadProcessoModelTests, ufpgCadAudiencia,
  ufpgCadPautaAudiencia, ufpgDataModelTests, ufpgCadProcesso, usajConstante,
  usaj5CadOrgaoSuperior, ufpgConsTipoParte;

type
  TffpgCadProcessoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadProcesso;
    FoDados: TffpgCadProcessoModelTests;
    FoDadosArmasBens: TffpgCadArmasBensModelTests;
    procedure CadastroProcesso;
    procedure PreencherDadosProcessuais;
    procedure PreencherDadosDirecionamento;
    procedure AlterarDadosProcesso;
    //Botoes do cadastro
    procedure DistribuirProcesso;
    procedure DigitalizarPecas;
    procedure AgendarAudiencia;
    procedure EmitirDocumento;
    procedure EditarDocumento;
    procedure FinalizarDocumento;
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
    procedure SelecionarOrgaoSuperior;
    procedure SelecionarTipoParticipacao(poTelaConsTipoParte: TffpgConsTipoParte;
      poDadosPartes: TffpgCadParteRepresModelTests);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadastroProcessoOutroExec;
    procedure TestarCadastroProcesso;
    procedure TestarCadastarEntdereco;
    procedure TestarCadastroProcessoDependencia;
  end;

implementation

uses
  Windows, DB, SysUtils, TestFramework, Forms, ufpgDadosDistribNormal, uspInterface,
  ufpgConstanteGUITests, ufpgVariaveisTestesGUI, usaj5ConsPessoa, ufpgResultadoDistribuicao,
  ufpgFuncoesGUITestes, usaj5CadJuizoDeprecante, ufpgConsEnderecoPessoa,
  uspGUITestCase, ufpgEdicaoDocumento, ufpgEditor, uedtSelecaoCeritificadoDigital,
  ufpgDigPecaProcessual, ufpgConsTipoDocDigital, ufpgConsSituacaoBem,
  usaj5CadPessoaNormal, ufpgDUnitDAO, usajEndereco, usaj5consAssunto, uspSendKeys;

var
  sNuProcesso: string;
  ffpgCadProcessoTests: TffpgCadProcessoTests;
  bChecarArmasEBens: boolean;
  bChecarOutrosNumeros: boolean;
  bChecarOutroAssunto: boolean;
  bChecarEnderecoPrincipal: boolean;
  bCheckEnderecoPrincipal: boolean;
  sDirecionada: string;
  sLivre: string;
  nQtdReu: integer;
  sNomeParte: string;

const
  CS_PARTE_ATIVA = 'A';
  CS_PARTE_PASSIVA = 'P';
  CS_PARTE_REPRESENTANTE = 'R';
  CS_PARTE_TERCEIRA = 'T';
  CS_PARTE_TESTEMUNHA = 'TE';

{ TffpgCadProcessoCompletoTests }

function TffpgCadProcessoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadProcessoModelTests;
end;

procedure TffpgCadProcessoTests.TestarCadastroProcesso;
begin
  ExecutarRoteiroTestes(CadastroProcesso);
end;

procedure TffpgCadProcessoTests.CadastroProcesso;
var
  sNuProtocolo: string;
begin
  FoDados := TffpgCadProcessoModelTests(spDataModelTests);

  if FoDados.fpgAbrirDoMenu then
  begin
    if FoDados.fpgFecharTodasTelas then
      spVerificadorTelas.FecharTelasAbertas;
    AbrirTela;
  end
  else
    spTela := PegarTela('ffpgCadProcesso');

  FoTela := TffpgCadProcesso(spTela);

  bChecarArmasEBens := False;
  bChecarOutrosNumeros := False;
  bChecarOutroAssunto := False;
  bChecarEnderecoPrincipal := False;
  bCheckEnderecoPrincipal := False;

  if FoDados.fpgProcessoDependente then
  begin
    sNuProtocolo := copy(LerVariavelExterna(CS_NUPROTOCOLO), 1, 13);
    EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, sNuProtocolo, False);
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

  nQtdReu := 0;

  ExecutarSubRoteiroTestes(PreencherDadosPartes, 'DadosPartes',
    FoDados.fpgCadParteRepresModelTests);

  if FoDados.fpgControladoForaUso then
    Exit;

  ExecutarSubRoteiroTestes(PreencherArmasBens, 'DadosArmasBens',
    FoDados.fpgCadArmasBensModelTests);

  ExecutarSubRoteiroTestes(PreeencherDadosObjetoAcao, 'DadosObjetoAcao',
    FoDados.fpgObjetoAcaoModelTests);

  ExecutarSubRoteiroTestes(PreencherDadosOutrosNumeros, 'DadosOutrosNumeros',
    FoDados.fpgOutrosNumerosModelTests);

  ExecutarSubRoteiroTestes(PreencherDadosAssunto, 'DadosAssunto', FoDados.fpgAssuntoModelTests);

  MudarAba(FoTela.tsDadosProcessuais);
  EnterTextInto(FoTela.cbTpSigilo, FoDados.fpgTipoSigilo, False);
  EnterTextInto(FoTela.dfQtReu, IntToStr(nQtdReu), False);

  if FoDados.fpgPossuiEqtaAutuacao then
    spVerificadorTelas.RegistrarMensagem('O processo informado*', '&Não');

  FoTela.ccCadastro.Execute(acSalvar);

  gsCdProcesso := FoTela.efpgProcesso.FieldByName('cdProcesso').AsString;
  gsCdObjeto := FoTela.efpgProcesso.FieldByName('cdObjeto').AsString;

  if FoDados.fpgUsarArquivoExterno then
  begin
    GravarVariavelExterna(CS_NUPROCESSO, sNuProcesso);
    GravarVariavelExterna(CS_CDPROCESSO, gsCdProcesso);
    GravarVariavelExterna(CS_CDVARA, FoDados.fpgCodVaraDirecionada);
  end;
  GravarVariavelExterna(CS_CDFORO, FoDados.fpgForo);

  if FoDados.fpgDistribuir then
    DistribuirProcesso;

  if FoDados.fpgAgendarAudiencia then
    AgendarAudiencia;

  if FoDados.fpgEmitirDocs then
    EmitirDocumento;

  if FoDados.fpgDigitalizarPecas then
    DigitalizarPecas;

  FoTela.ccCadastro.Execute(acLimpar);
  FecharTela;
  VerificarCadastroProcesso;
end;

procedure TffpgCadProcessoTests.PreencherDadosProcessuais;
var
  oTelaConsAssunto: Tfsaj5ConsAssunto;
begin
  MudarAba(FoTela.tsDadosProcessuais);

  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    EnterTextInto(FoTela.csClasse.dfCodigo, FoDados.fpgClasse);
    CheckCampoPreenchido(FoTela.csClasse.dfDescricao, FoDados);

    EnterTextInto(FoTela.csCompetencia.dfCdTipoCartorio, FoDados.fpgCompetencia);
    CheckCampoPreenchido(FoTela.csCompetencia.dfDeTipoCartorio, FoDados);
    sDirecionada := CS_TIPO_DISTRIBUICAO_DIRECIONADA_SC;
    sLivre := CS_TIPO_DISTRIBUICAO_SORTEIO_SC;
  end
  else
  begin
    EnterTextInto(FoTela.csCompetencia.dfCdTipoCartorio, FoDados.fpgCompetencia);
    CheckCampoPreenchido(FoTela.csCompetencia.dfDeTipoCartorio, FoDados);
    EnterTextInto(FoTela.csClasse.dfCodigo, FoDados.fpgClasse);
    CheckCampoPreenchido(FoTela.csClasse.dfDescricao, FoDados);
    if gsCliente = CS_CLIENTE_PG5_TJSP then
    begin
      sDirecionada := CS_TIPO_DISTRIBUICAO_DIRECIONADA;
      sLivre := CS_TIPO_DISTRIBUICAO_LIVRE_SP;
    end
    else
    begin
      sDirecionada := 'Vinculada';
      sLivre := 'Automática';
    end;
  end;
  spVerificadorTelas.PararVerificacao;

  TFutureWindows.Expect('TMessageForm').ExecCloseWindow;
  EnterTextInto(FoTela.csAssuntoForm.dfCodigo, FoDados.fpgAssuntoPrincipal, False);

  if FoTela.csAssuntoForm.dfDescricao.EstaNulo and (gsCliente = CS_CLIENTE_PG5_TJSP) then
  begin
    FoTela.csAssuntoForm.pbConsulta.Click;
    oTelaConsAssunto := PegarTela('fsaj5ConsAssunto') as Tfsaj5ConsAssunto;
    oTelaConsAssunto.ccCadastro.Execute(acSelecionar);
  end;

  spVerificadorTelas.IniciarVerificacao;
  CheckCampoPreenchido(FoTela.csAssuntoForm.dfDescricao, FoDados);

  EnterTextInto(FoTela.cbArea, FoDados.fpgArea);
  EnterTextInto(FoTela.dfQtVolume, FoDados.fpgVolumes);

  if (not FoDados.fpgSemCustasIniciais) and FoTela.dfNumeroGRJ.EstaNulo and
    (gsCliente = CS_CLIENTE_PG5_TJSC) then
    spVerificadorTelas.RegistrarMensagem(
      'A GRJ não foi informada. Deseja salvar o processo assim mesmo?', '&Sim')
  else
  begin
    FoTela.ckSemCustaInicial.Checked := FoDados.fpgSemCustasIniciais;
    FoTela.efpgProcesso.FieldByName('flSemCustaInicial').AsString := 'S';
  end;

  if FoDados.fpgOrgaoSuperior <> STRING_INDEFINIDO then
  begin
    EnterTextInto(FoTela.dfNmOrgaoSuperior, FoDados.fpgOrgaoSuperior);
    SelecionarOrgaoSuperior;
  end;

  EnterTextInto(FoTela.dfVlCausa, FoDados.fpgValoracao);
  EnterTextInto(FoTela.dfDtVlAcao, FoDados.fpgDataValoracao);

  EnterTextInto(FoTela.cbTipoDistrib, FoDados.fpgTipoDistribuicao, False);

  if FoTela.cbTipoDistrib.Text <> sLivre then
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

procedure TffpgCadProcessoTests.MudarAba(psAba: TTabSheet);
begin
  if FoTela.pcCadProcesso.ActivePage <> psAba then
  begin
    FoTela.pcCadProcesso.ActivePage := psAba;
    FoTela.pcCadProcessoChange(FoTela);
  end;
end;

procedure TffpgCadProcessoTests.PreencherDadosDirecionamento;
var
  oTelaDadosDistribNormal: TffpgDadosDistribNormal;
begin
  oTelaDadosDistribNormal := TffpgDadosDistribNormal(PegarTela('ffpgDadosDistribNormal'));

  if oTelaDadosDistribNormal.csVara.Visible then
    EnterTextInto(oTelaDadosDistribNormal.csVara.dfcdVara, FoDados.fpgCodVaraDirecionada);

  if oTelaDadosDistribNormal.dfNuProcessoRefer.Visible then
    EnterTextInto(oTelaDadosDistribNormal.dfNuProcessoRefer.FdfNumeroDependente, sNuProcesso);

  oTelaDadosDistribNormal.mmdeMotivoPrevencao.Lines.Add(FoDados.fpgMotivo);

  oTelaDadosDistribNormal.ccCadastro.Execute(acSalvar);
  oTelaDadosDistribNormal.ccCadastro.Execute(acFecharForm);

  Application.ProcessMessages;
end;

procedure TffpgCadProcessoTests.PreencherDadosDP;
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

procedure TffpgCadProcessoTests.PreencherDadosPrecatoria;
var
  oModelPrecatoria: TffpgPrecatoriaModelTests;
begin
  oModelPrecatoria := FoDados.fpgPrecatoriaModelTests;

  // spVerificadorTelas.RegistrarMensagem('Foram realizadas*', '&Sim');

  EnterTextInto(FoTela.csComarca.dfcdMunicipio, oModelPrecatoria.fpgCdMunicipio);
  EnterTextInto(FoTela.dfNuOrigemPrecatoria, oModelPrecatoria.fpgNuOriPrecatoria);

  FoTela.pbJuizoDeprec.Click;
  SelecionarJuizDeprecante(oModelPrecatoria);

end;

procedure TffpgCadProcessoTests.SelecionarJuizDeprecante(poDados: TffpgPrecatoriaModelTests);
var
  oTelaJuizDeprec: Tfsaj5CadJuizoDeprecante;
begin
  oTelaJuizDeprec := PegarTela('fsaj5CadJuizoDeprecante') as Tfsaj5CadJuizoDeprecante;
  oTelaJuizDeprec.pcPastaCadastro.ActivePageIndex := 0;
  if oTelaJuizDeprec.csComarcaCons.dfnmMunicipio.EstaNulo then
    EnterTextInto(oTelaJuizDeprec.csComarcaCons.dfcdMunicipio, poDados.fpgCdMunicipio);
  if not oTelaJuizDeprec.bcBotoesCadastro.AcaoHabilitado(acSelecionar) then
  begin
    oTelaJuizDeprec.ccPai.Execute(acNovo);
    EnterTextInto(oTelaJuizDeprec.dfnmPessoa, poDados.fpgJuizoDeprecante);
    EnterTextInto(oTelaJuizDeprec.sajEnderecoPrincipal.dfCEP, CS_CEP_PADRAO_SP, False);
    if oTelaJuizDeprec.sajEnderecoPrincipal.csMunicipio.dfnmMunicipio.EstaNulo then
      EnterTextInto(oTelaJuizDeprec.sajEnderecoPrincipal.csMunicipio.dfcdMunicipio,
        poDados.fpgCdMunicipio);

    if oTelaJuizDeprec.sajEnderecoPrincipal.dfdeLogradouro.EstaNulo then
      EnterTextInto(oTelaJuizDeprec.sajEnderecoPrincipal.dfdeLogradouro, CS_NOME_RUA);

    EnterTextInto(oTelaJuizDeprec.sajEnderecoPrincipal.dfNumero, IntToStr(random(3)), False);
    oTelaJuizDeprec.ccPai.Execute(acSalvar);
  end;
  Application.ProcessMessages;
  oTelaJuizDeprec.ccPai.Execute(acSelecionar);
end;

procedure TffpgCadProcessoTests.PreencherDadosPartes;
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
      SelecionarTipoParticipacao(oTelaConsTipoParte, oModelPartes);
    end
    //    else
    //    if FoTela.fpgProcessoParte.csTipoParte.dfcdTipoParte.EstaNulo then
    //    begin
    //      FoTela.fpgProcessoParte.csTipoParte.pbConsulta.Click;
    //      oTelaConsTipoParte := TffpgConsTipoParte(PegarTela('ffpgConsTipoParte', False, 0));
    //      SelecionarTipoParticipacao(oTelaConsTipoParte, oModelPartes);
    //    end
    else
    begin
      if not oModelPartes.fpgNaoClicarBotaoParte then
      begin
        if (UpperCase(oModelPartes.fpgPolo) = CS_PARTE_ATIVA) and
          (FoTela.fpgProcessoParte.csTipoParte.dfcdTipoParte.EstaNulo) then
          FoTela.fpgProcessoParte.pbNovaParteAtiva.Click
        else
        if UpperCase(oModelPartes.fpgPolo) = CS_PARTE_PASSIVA then
        begin
          FoTela.fpgProcessoParte.pbNovaPartePassiva.Click;
          Inc(nQtdReu);
        end
        else if UpperCase(oModelPartes.fpgPolo) = CS_PARTE_REPRESENTANTE then
          FoTela.fpgProcessoParte.pbNovoAdvogado.Click
        else if UpperCase(oModelPartes.fpgPolo) = CS_PARTE_TERCEIRA then
          FoTela.fpgProcessoParte.pbNovoTerceiro.Click
        else if UpperCase(oModelPartes.fpgPolo) = CS_PARTE_TESTEMUNHA then
          FoTela.fpgProcessoParte.pbNovaTestemunha.Click;
      end;
      if FoTela.fpgProcessoParte.csTipoParte.dfcdTipoParte.EstaNulo then
      begin
        oTelaConsTipoParte := TffpgConsTipoParte(PegarTela('ffpgConsTipoParte', False, 0));
        if (not oModelPartes.fpgNaoClicarBotaoCunsultaParte) and
          (not assigned(oTelaConsTipoParte)) then
        begin
          FoTela.fpgProcessoParte.csTipoParte.pbConsulta.Click;
          oTelaConsTipoParte := TffpgConsTipoParte(PegarTela('ffpgConsTipoParte', False, 0));
        end;
      end;
      SelecionarTipoParticipacao(oTelaConsTipoParte, oModelPartes);
      application.ProcessMessages;
    end;

    DefinirPessoa(oModelPartes);
    if FoDados.fpgControladoForaUso then
      Exit;

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
    // 01/11/2016  - Carlos.Gaspar - TASK: 67011
    EnterTextCheckBox(FoTela.fpgProcessoParte.cbxIdoso, oModelPartes.fpgcbxIdoso);
    EnterTextCheckBox(FoTela.fpgProcessoParte.cbxDoencaGrave, oModelPartes.fpgcbxDoencaGrave);
    EnterTextCheckBox(FoTela.fpgProcessoParte.cbxJusticaGratuita,
      oModelPartes.fpgcbxJusticaGratuita);

  finally
    oTelaConsTipoParte := nil;
  end;
end;


procedure TffpgCadProcessoTests.DefinirPessoa(poDados: TffpgCadParteRepresModelTests);
var
  sCPFExterno: string;
begin
  if poDados.fpgCPF = STRING_INDEFINIDO then
  begin
    poDados.fpgCPF := RetornaCPFValido;
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

    poDados.fpgNomeParte := removerAcentuacao(
      FoTela.fpgProcessoParte.csTipoParte.dfdeCompTipoParte.PegaTexto) + ' ' + sNuProcesso;


    //Luciano
    sNomeParte := LerVariavelExterna(CS_NOME_PARTE);
    if (sNomeParte <> '') and (UpperCase(poDados.fpgPolo) = CS_PARTE_ATIVA) then
      poDados.fpgNomeParte := sNomeParte;

    if UpperCase(poDados.fpgPolo) = CS_PARTE_ATIVA then
      gsNomeParteAtivaCPF := poDados.fpgNomeParte + poDados.fpgCPF
    else if UpperCase(poDados.fpgPolo) = CS_PARTE_PASSIVA then
      gsNomePartePassivaCPF := poDados.fpgNomeParte + poDados.fpgCPF
    else if UpperCase(poDados.fpgPolo) = CS_PARTE_REPRESENTANTE then
      gsNomeParteRepresentanteCPF := poDados.fpgNomeParte + poDados.fpgCPF
    else if UpperCase(poDados.fpgPolo) = CS_PARTE_TERCEIRA then
      gsNomeParteTestemunhaCPF := poDados.fpgNomeParte + poDados.fpgCPF;
    //03/11/2016 - Raphael.Whitlock - Task: 67188
    if FoDados.fpgControladoForaUso then
    begin
      TFutureWindows.Expect('Tfsaj5ConsPessoa').ExecProc(PegarTelaModal);
      EnterTextInto(FoTela.fpgProcessoParte.dfnmPessoa, gsNomeParteAtivaCPF);
      spVerificadorTelas.RegistrarMensagem(
        'Já existe outra pessoa em uso com o mesmo documento*', '&OK');
      poDados.fpgCPF := SomenteNumeros(LerVariavelExterna(CS_CPF));
      StartExpectingException(EAbort);
      EnterTextInto(FoTela.fpgProcessoParte.dfCPF, poDados.fpgCPF);
      StopExpectingException();
      Application.ProcessMessages;
      spVerificadorTelas.RegistrarMensagem('Foram realizadas alterações no(a) Processo*', 'Não');
      FecharTela;
      exit;
    end;

    TFutureWindows.Expect('Tfsaj5ConsPessoa').ExecProc(PegarTelaModal);
    EnterTextInto(FoTela.fpgProcessoParte.dfnmPessoa, poDados.fpgNomeParte);
  end
  else
  begin
    TFutureWindows.Expect('Tfsaj5ConsPessoa').ExecProc(PegarTelaModal);
    EnterTextInto(FoTela.fpgProcessoParte.dfnmPessoa, poDados.fpgNomeParte);
  end;
  //12/09/2016 - Raphael.Whitlock - Atribuir CDPESSOA antes de CPF, pois CPF bloqueia CDPESSOA.
  sCPFExterno := SomenteNumeros(LerVariavelExterna(CS_CPF));
  if sCPFExterno <> '' then
    poDados.fpgCPF := sCPFExterno;
  EnterTextInto(FoTela.fpgProcessoParte.dfCPF, poDados.fpgCPF, False);
  Tab;
end;

procedure TffpgCadProcessoTests.PegarTelaModal(const poWindow: IWindow);
var
  oTelaConsPessoa: Tfsaj5ConsPessoa;
begin
  oTelaConsPessoa := poWindow.asControl as Tfsaj5ConsPessoa;
  if not FoDados.fpgControladoForaUso then
    oTelaConsPessoa.ccCadastro.Execute(acSelecionar)
  else
    oTelaConsPessoa.ccCadastro.Execute(acNovo);
end;

procedure TffpgCadProcessoTests.DistribuirProcesso;
var
  oTelaResultadoDistribuicao: TffpgResultadoDistribuicao;
begin
  FoTela.pbDistribuiProcesso.Click;
  oTelaResultadoDistribuicao := TffpgResultadoDistribuicao(PegarTela('ffpgResultadoDistribuicao'));
  CheckNotNull(oTelaResultadoDistribuicao, 'Não achou a tela ffpgResultadoDistribuicao');
  gsVara := Copy(SomenteNumeros(oTelaResultadoDistribuicao.lbNmVara.Caption), 1, 3);
  gsVaga := Copy(SomenteNumeros(oTelaResultadoDistribuicao.lbNmVaga.Caption), 1, 3);
  oTelaResultadoDistribuicao.Close;
  Application.ProcessMessages;
end;

procedure TffpgCadProcessoTests.PreeencherDadosObjetoAcao;
var
  oModelObjetoAcao: TffpgObjetoAcaoModelTests;
begin
  oModelObjetoAcao := FoDados.fpgObjetoAcaoModelTests;

  MudarAba(FoTela.tsObjetoAcao);
  EnterTextInto(FoTela.dfdeObjetoAcao, oModelObjetoAcao.fpgObjetoAcao);
end;

procedure TffpgCadProcessoTests.PreencherDadosOutrosNumeros;
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

procedure TffpgCadProcessoTests.PreencherDadosAssunto;
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

procedure TffpgCadProcessoTests.AgendarAudiencia;
var
  oTelaPauta: TffpgCadPautaAudiencia;
begin
  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  FoTela.pbAgendaConciliacao.Click;

  oTelaPauta := TffpgCadPautaAudiencia(PegarTela('ffpgCadPautaAudiencia'));

  EnterTextInto(oTelaPauta.ggpTipoAudienciaCons.dfCodigo, FoDados.fpgTipoAudiencia);
  EnterTextInto(oTelaPauta.dxdePeriodoInicial, DateToStr(Now));
  oTelaPauta.tbxiLocalizarHorario.Click;

  oTelaPauta.TBXItem2.Click;

  if FoDados.fpgCancelarAudiencia then
    CancelarAudiencia(oTelaPauta);

  oTelaPauta.imArquivoFechar.Click;
end;

procedure TffpgCadProcessoTests.CancelarAudiencia(poTelaPauta: TffpgCadPautaAudiencia);
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

procedure TffpgCadProcessoTests.EmitirDocumento;
var
  oTelaEdicao: TffpgEdicaoDocumento;
begin
  FoTela.pbEmiteDocumentos.Click;
  oTelaEdicao := TffpgEdicaoDocumento(PegarTela('ffpgEdicaoDocumento'));

  EnterTextInto(oTelaEdicao.edtCategoriaCons.dfCodigo, FoDados.fpgCdCategoriaDoc);
  EnterTextInto(oTelaEdicao.edtModeloCons.dfCodigo, FoDados.fpgCdModeloCategoriaDoc);

  oTelaEdicao.pcParametrosIntercalacao.ActivePage := oTelaEdicao.tsPartesDestinatarias;
  oTelaEdicao.btnTodasPartes.Click;
  oTelaEdicao.dxbbBotoesSalvar.Click;
  oTelaEdicao.dxbbBotoesSelecionar.click;
  EditarDocumento;
  oTelaEdicao.dxbbBotoesFecharForm.Click;
end;

procedure TffpgCadProcessoTests.EditarDocumento;
var
  OTelaEditor: TffpgEditor;
begin
  OTelaEditor := TffpgEditor(PegarTela('ffpgEditor'));
  OTelaEditor.dxFinalizarDocumento.Click;
  Application.ProcessMessages;
  FinalizarDocumento;
  OTelaEditor.dxbbArquivoFecharEditor.Click;
end;

procedure TffpgCadProcessoTests.FinalizarDocumento;
var
  oTelaFinalizar: TfedtSelecaoCeritificadoDigital;
begin
  oTelaFinalizar := TfedtSelecaoCeritificadoDigital(PegarTela('fedtSelecaoCeritificadoDigital'));

  spVerificadorTelas.RegistrarMensagem(
    'O documento selecionado necessita da assinatura de Juiz.*', 'Sim');
  EnterTextRadioGroup(oTelaFinalizar.rgOpcao, '&Assinar e liberar nos autos digitais');
  EnterTextInto(oTelaFinalizar.cbCertificados, FoDados.fpgCertificado);
  oTelaFinalizar.dxbbBotoesSelecionar.Click;
end;

procedure TffpgCadProcessoTests.DigitalizarPecas;
var
  oTelaDigPecas: TffpgDigPecaProcessual;
  oTelaTipoDoc: TffpgConsTipoDocDigital;
begin
  FoTela.pbDigitalizar.Click;
  oTelaDigPecas := TffpgDigPecaProcessual(PegarTela('ffpgDigPecaProcessual'));
  oTelaDigPecas.pbNovaPeca.Click;

  spVerificadorTelas.RegistrarMensagem('Deseja digitalizar outra página deste documento?', 'Não');
  oTelaTipoDoc := TffpgConsTipoDocDigital(PegarTela('ffpgConsTipoDocDigital'));
  oTelaTipoDoc.ccCadastro.Execute(acSelecionar);

  oTelaDigPecas.ccCadastro.Execute(acSalvar);
end;

procedure TffpgCadProcessoTests.PreencherArmasBens;
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

procedure TffpgCadProcessoTests.SelecionarStituacaoArmasBens;
var
  oTelaSitBem: TffpgConsSituacaoBem;
begin
  FoTela.fpgArmasBens.csSituacaoBem.pbConsulta.Click;
  oTelaSitBem := TffpgConsSituacaoBem(PegarTela('ffpgConsSituacaoBem'));
  oTelaSitBem.efpgSituacaoBem.Locate('CDSITUACAOBEM', FoDadosArmasBens.fpgcsSituacaoBem, []);
  oTelaSitBem.ccCadastro.Execute(acSelecionar);
end;

procedure TffpgCadProcessoTests.PreencherDadosArmas;
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

procedure TffpgCadProcessoTests.PreencherDadosMunicao;
begin
  FoTela.fpgArmasBens.ccItemBem.Execute(acNovo);
  EnterTextGrid(FoTela.fpgArmasBens.grMunicao, FoDadosArmasBens.fpgdeItemBemMunicao, 0);
  EnterTextGrid(FoTela.fpgArmasBens.grMunicao, FoDadosArmasBens.fpgqtIntactaMunicao, 1);
  EnterTextGrid(FoTela.fpgArmasBens.grMunicao, FoDadosArmasBens.fpgqtDeflagradaMunicao, 2);
  EnterTextGrid(FoTela.fpgArmasBens.grMunicao, FoDadosArmasBens.fpgdeComplementoMunicao, 3);
end;

procedure TffpgCadProcessoTests.PreencherDadosVeiculo;
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

procedure TffpgCadProcessoTests.PreencherDadosImovel;
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

procedure TffpgCadProcessoTests.PreencherDadosTitulo;
begin
  EnterTextInto(FoTela.fpgArmasBens.dfqtBemTitulo, FoDadosArmasBens.fpgdfqtBemTitulo);
  EnterTextInto(FoTela.fpgArmasBens.dfVlTitulo, FoDadosArmasBens.fpgdfqtBemTitulo);
  EnterTextInto(FoTela.fpgArmasBens.mmComplTitulo, FoDadosArmasBens.fpgmmdeComplemento);
end;

procedure TffpgCadProcessoTests.PreencherDadosOutrosBens;
begin
  EnterTextGrid(FoTela.fpgArmasBens.grOutrosBensObj, FoDadosArmasBens.fpgdeItemBem, 0);
  EnterTextGrid(FoTela.fpgArmasBens.grOutrosBensObj, FoDadosArmasBens.fpgqtIntacta, 1);
  EnterTextGrid(FoTela.fpgArmasBens.grOutrosBensObj, FoDadosArmasBens.fpgdeComplemento, 2);
end;

procedure TffpgCadProcessoTests.VerificarCadastroProcesso;
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

procedure TffpgCadProcessoTests.CadastrarEnderecoPrincipal;
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

procedure TffpgCadProcessoTests.CadastrarEndereco(const poWindow: IWindow);
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

procedure TffpgCadProcessoTests.AlterarDadosProcesso;
begin
  ExecutarSubRoteiroTestes(CadastrarEnderecoPrincipal, 'DadosEndereco',
    FoDados.fpgCadEnderecoModelTests);
end;

procedure TffpgCadProcessoTests.VerificarEnderecoPrincipal(const poWindow: IWindow);
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

procedure TffpgCadProcessoTests.PreencherDadosEndereco;
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

procedure TffpgCadProcessoTests.TestarCadastarEntdereco;
begin
  ExecutarRoteiroTestes(CadastroProcesso);
end;

procedure TffpgCadProcessoTests.TestarCadastroProcessoOutroExec;
begin
  ExecutarRoteiroTestes(CadastroProcesso);
end;

procedure TffpgCadProcessoTests.TestarCadastroProcessoDependencia;
begin
  ExecutarRoteiroTestes(CadastroProcesso);
end;

procedure TffpgCadProcessoTests.SelecionarOrgaoSuperior;
var
  oTelaOrgSup: Tfsaj5CadOrgaoSuperior;
begin
  oTelaOrgSup := PegarTela('fsaj5CadOrgaoSuperior') as Tfsaj5CadOrgaoSuperior;
  oTelaOrgSup.ccPai.Execute(acSelecionar);
end;

procedure TffpgCadProcessoTests.SelecionarTipoParticipacao(poTelaConsTipoParte: TffpgConsTipoParte;
  poDadosPartes: TffpgCadParteRepresModelTests);
var
  sValorSemAcento: string;
begin
  if Assigned(poTelaConsTipoParte) then
  begin
    EnterTextCheckBox(poTelaConsTipoParte.cbListarTodos, True);
    EnterTextGrid(poTelaConsTipoParte.grFiltro, RemoverAcentuacao(
      poDadosPartes.fpgTipoParticipacao), 1);
    Tab;
    Sleep(1000);
    Application.ProcessMessages;
    if poTelaConsTipoParte.grDados.DataSource.DataSet.RecordCount > 1 then
    begin
      poTelaConsTipoParte.grDados.DataSource.DataSet.First;
      while not poTelaConsTipoParte.grDados.DataSource.DataSet.EOF do
      begin
        sValorSemAcento := RemoverAcentuacao(
          poTelaConsTipoParte.grDados.DataSource.DataSet.FieldByName(
          'DECOMPTIPOPARTE').AsString);
        if sValorSemAcento = RemoverAcentuacao(poDadosPartes.fpgTipoParticipacao) then
        begin
          Sleep(1000);
          application.ProcessMessages;
          Break;
        end
        else
          poTelaConsTipoParte.grDados.DataSource.DataSet.Next;
      end;
    end;
    poTelaConsTipoParte.ccCadastro.Execute(acSelecionar);
    application.ProcessMessages;
  end;
end;

end.


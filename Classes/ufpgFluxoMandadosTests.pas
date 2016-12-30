unit ufpgFluxoMandadosTests;

interface

uses
  uspTestCase, {uspDataModelTests,} TestFramework, ufpgFuncoesTestes, ufpgGUITestCase, ufpgDataModelTests;

type

  TfpgFluxoMandadosBase = class(TfpgGUITestCase)
  public
    procedure TestarConsultaBasicaMandados;
    procedure TestarConsultaAvancadaMandados;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure SetUp; override;
    procedure TearDown; override;
  end;

  TfpgFluxoMandados = class(TfpgFluxoMandadosBase)
  published
    procedure TestarGerarImprimriGRJ_1_6_1;
    procedure TestarEmitirMandadosEnderecosNaoAtendidos_1_6_2;
    procedure TestarEmitirMandadosEnderecosAtendidos_1_6_2;
    procedure TestarVerificarRecebimentoMandadoFila_1_6_3;
    procedure TestarDistribuirMandadoAtividadeFluxo_1_6_4;
    procedure TestarConsultaBasicaMandadosCM_1_6_5_1;
    procedure TestarConsultaAvancadaMandadosCM_1_6_5_2;
    procedure TestarEnviarParaFilaAgImpressaoCentral_1_6_6;
    procedure TestarCertificacaoDoMandadoPeloFluxo_1_6_7;
    procedure TestarCertificacaoDoMandadoPeloFluxo_1_6_8;
    procedure TestarConsultaBasicaMandados_1_6_9_1;
    procedure TestarConsultaAvancadaMandados_1_6_9_2;
    procedure TestarMudarParaFilaAgAnalise_1_6_10;
    procedure TestarRedistribuirMandadoFluxo_1_6_11;
    procedure TestarVerificarFilaAgAnalise_1_6_12;
  end;

  TfpgFluxoMandados_MS = class(TfpgFluxoMandadosBase)
  published
    procedure TestarGeracaoImpressaoGRJCustasIntermediarias;
    procedure TestarEmitirMandadosEnderecosAtendidos;
    procedure TestarRemessaCartorioparaCentralMandados;
    procedure TestarRecebimentoPelaCentralDeMandados;
    procedure TestarDistribuicaoMandado;
    procedure TestarGerarGuiaOficial;
    procedure TestarRemeterParaOficialDeJustica;
    procedure TestarReceberMandadoDaCentralDeJustica;
    procedure TestarCertificarMandadoPeloAgente;
    procedure TestarRemessaParaCentralPeloAgente;
    procedure TestarGerarAtoCumprimentoRemeterCentral;
  end;

  TfpgFluxoCentralCompartilhada = class(TfpgFluxoMandadosBase)
  public
    procedure TestarConsultaBasicaMandados_1_7_4;
    procedure TestarConsultaAvancadaMandados_1_7_4;
    procedure TestarDistribuirMandadoFluxo_1_7_5;
    procedure TestarEnvioParaFilaAgImpressaoCentral_1_7_8;
    procedure TestarCertificacaoPeloFluxo_1_7_9;
    procedure TestarCertificacaoSemCumprimentoPeloFluxo_1_7_10;
    procedure TestarEstaNaFilaAgAnalise_1_7_12_13;
  end;

  TfpgFluxoCentralCompartilhadaProcessosDigitais = class(TfpgFluxoCentralCompartilhada)
  published
    procedure TestarGerarImprimirGRJ_1_7_1_1;
    procedure TestarEmissaodeMandadoCMC_1_7_2_1;
    procedure TestarConsultaBasicaMandados_1_7_4_1;
    procedure TestarConsultaAvancadaMandados_1_7_4_3;
    procedure TestarDistribuirMandadoFluxo_1_7_5_1;
    procedure TestarConsultaBasicaMandadosCM_1_7_7_1;
    procedure TestarConsultaAvancadaMandadosCM_1_7_7_3;
    procedure TestarEnvioParaFilaAgImpressaoCentralCMC_1_7_8;
    procedure TestarCertificacaoDoMandadoPeloFluxo_1_7_9;
    procedure TestarCertificacaoDoMandadoSemCumprimentoPeloFluxo_1_7_10;
    procedure TestarConsultaBasicaMandados_1_7_11_1;
    procedure TestarConsultaAvancadaMandados_1_7_11_3;
    procedure TestarEstaNaFilaAgAnalise_1_7_12;
  end;

  TfpgFluxoCentralCompartilhadaProcessosFisicos = class(TfpgFluxoCentralCompartilhada)
  published
    procedure TestarGerarImprimirGRJ_1_7_1_2;
    procedure TestarEmissaodeMandadoCMC_1_7_2_2;
    procedure TestarConsultaBasicaMandados_1_7_4_2;
    procedure TestarConsultaAvancadaMandados_1_7_4_4;
    procedure TestarDistribuirMandadoFluxo_1_7_5_2;
    procedure TestarConsultaBasicaMandadosCM_1_7_7_2;
    procedure TestarConsultaAvancadaMandadosCM_1_7_7_4;
    procedure TestarEnvioParaFilaAgImpressaoCentralCMC_1_7_8;
    procedure TestarCertificacaoDoMandadoPeloFluxo_1_7_9;
    procedure TestarCertificacaoDoMandadoSemCumprimentoPeloFluxo_1_7_10;
    procedure TestarConsultaBasicaMandados_1_7_11_2;
    procedure TestarConsultaAvancadaMandados_1_7_11_4;
    procedure TestarEstaNaFilaAgAnalise_1_7_13;
  end;

  TfpgFluxoSemCentral = class(TfpgFluxoMandadosBase)
  public
    procedure TestarConfirmacaoDeValoresDiligencia_1_5_18;
  published
    procedure TestarCadastrarProcesso;
    procedure TestarGerarGRJeBaixar;
    procedure TestarRemeterCartorio;
    procedure TestarEmitirMandado;
    procedure TestarRemeterAgente;
    procedure TestarReceberAgente;
    procedure TestarCadastrarAtos;
    procedure TestarReceberCartorio;
    procedure TestarValidarVinculacao;
    procedure TestarImpressaoCertidao_1_5_19;
    procedure TestarJuntadaMandado_1_5_20;
  end;

  TfpgFluxoManddosPrisao = class(TfpgFluxoMandadosBase)
  published
    procedure TestarMandadosPrisao_1_5_22;
    procedure TestarEmissaoComMaisDeDuasCapitulacoesDiferentes_1_5_22_1;
    procedure TestarEmissaoComplementoMovimentacaoAtoOrdinatorio_1_6_13;
  end;

implementation


uses
  SysUtils, ufpgCalcCustaCompletaInicialProcTests, ufpgEdicaoDocumentoTests,
  ufpgVariaveisTestes, ufpgVisualizaFluxoTrabalhoTests, ufpgFluxoMandadosModelTests,
  ufpgConsultaDadosMandadoTests, ufpgConsultaMandadosTests, ufpgConsultaMandadosModelTests,
  ufpgDigPecaProcessualTests, ufpgVisualizaFluxoTrabalhoModelTests, ufpgRedistribuicaoTests,
  ufpgRemessaTests, usmdRemessaCartorioCentralTests, usmdRemessaAgenteCentralCompletaTests,
  usmdRemessaAgenteCartorioCompletaTests, ufpgCadProcessoTests, ufpgGerenciadorArquivoTests,
  ufpgCalcCustaCompletaIntermediariaProcTests, usmdTransferenciaMandadoTests, ufpgCadGuiaTests;


// 22/10/2015 - Felipe.s SALT: 186660/20/8
function TfpgFluxoMandadosBase.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgFluxoMandadosModelTests;
end;

// 30/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandadosBase.SetUp;
begin
  spAbrirTelaNoSetUp := False;
  spFecharTelaNoTearDown := False;
  inherited;
end;

// 30/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandadosBase.TearDown;
begin
  inherited;
end;

// 30/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandadosBase.TestarConsultaBasicaMandados;
var
  ffpgConsultaDadosMandadoTests: TffpgConsultaDadosMandadoTests;
  oModelTest: TffpgVisualizaFluxoTrabalhoModelTests;
begin
  ffpgConsultaDadosMandadoTests := TffpgConsultaDadosMandadoTests.Create; //PC_OK
  oModelTest := TffpgVisualizaFluxoTrabalhoModelTests.Create;
  try
    gbDeveTrocarUsuario := False;
    oModelTest.PegarDadosMandado(gsNuMandado, gbMandadoDistribuido);
    ffpgConsultaDadosMandadoTests.ExecutarRoteiroTestes(
      ffpgConsultaDadosMandadoTests.ConsultaBasicaMandado);
  finally
    ffpgConsultaDadosMandadoTests.FreeAndNilTest; //PC_OK
    oModelTest.Free;
  end;
end;

// 30/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandadosBase.TestarConsultaAvancadaMandados;
var
  ffpgConsultaMandadosTests: TffpgConsultaMandadosTests;
  oModelTest: TffpgVisualizaFluxoTrabalhoModelTests;
begin
  ffpgConsultaMandadosTests := TffpgConsultaMandadosTests.Create; //PC_OK
  oModelTest := TffpgVisualizaFluxoTrabalhoModelTests.Create;
  try
    gbDeveTrocarUsuario := False;
    oModelTest.PegarDadosMandado(gsNuMandado, gbMandadoDistribuido);
    ffpgConsultaMandadosTests.ExecutarRoteiroTestes(
      ffpgConsultaMandadosTests.ConsultaAvancadaMandado);
  finally
    ffpgConsultaMandadosTests.FreeAndNilTest; //PC_OK
    oModelTest.Free;
  end;
end;

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarGerarImprimriGRJ_1_6_1;
var
  ffpgCalcCustaCompletaInicialProcTests: TffpgCalcCustaCompletaInicialProcTests;
begin
  gbErroTest := False;
  gbLogarNoSetup := False;
  ffpgCalcCustaCompletaInicialProcTests := TffpgCalcCustaCompletaInicialProcTests.Create; //PC_OK
  try
    ffpgCalcCustaCompletaInicialProcTests.ExecutarRoteiroTestes(
      ffpgCalcCustaCompletaInicialProcTests.TestarGeracaoImpressaoGRJ_1_6_1,
      'TestarGeracaoImpressaoGRJ_1_6_1');
  finally
    ffpgCalcCustaCompletaInicialProcTests.FreeAndNilTest; //PC_OK
  end;
end;

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarEmitirMandadosEnderecosAtendidos_1_6_2;
var
  ffpgEdicaoDocumentoTests: TffpgEdicaoDocumentoTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgEdicaoDocumentoTests := TffpgEdicaoDocumentoTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := False;
    ffpgEdicaoDocumentoTests.ExecutarRoteiroTestes(
      ffpgEdicaoDocumentoTests.TestarEmitirMandadosEnderecosAtendidos_1_6_2,
      'TestarGeracaoImpressaoGRJ_1_6_2');
    ffpgEdicaoDocumentoTests.FecharTela;
  finally
    ffpgEdicaoDocumentoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarEmitirMandadosEnderecosNaoAtendidos_1_6_2;
var
  ffpgEdicaoDocumentoTests: TffpgEdicaoDocumentoTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgEdicaoDocumentoTests := TffpgEdicaoDocumentoTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := False;
    ffpgEdicaoDocumentoTests.ExecutarRoteiroTestes(
      ffpgEdicaoDocumentoTests.TestarEmitirMandadosEnderecosNaoAtendidos_1_6_2,
      'TestarGeracaoImpressaoGRJ_1_6_2');
    ffpgEdicaoDocumentoTests.FecharTela;
  finally
    ffpgEdicaoDocumentoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarVerificarRecebimentoMandadoFila_1_6_3;
var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := False;
    ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
      ffpgVisualizaFluxoTrabalhoTests.VerificarRecebimentoMandadoFila_1_6_3,
      'TestarEnvioParaFilaAgDistribuicaoCentral_1_6_3');
  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarDistribuirMandadoAtividadeFluxo_1_6_4;
var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
      ffpgVisualizaFluxoTrabalhoTests.DistribuirMandadoFluxo,
      'DistribuirMandadoAtividadeFluxo_1_6_4');
  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarConsultaBasicaMandadosCM_1_6_5_1;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  gbMandadoDistribuido := True;
  TestarConsultaBasicaMandados;
end;

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarConsultaAvancadaMandadosCM_1_6_5_2;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  gbMandadoDistribuido := True;
  TestarConsultaAvancadaMandados;
end;

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarEnviarParaFilaAgImpressaoCentral_1_6_6;
var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := False;
    ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
      ffpgVisualizaFluxoTrabalhoTests.EnviarParaFilaAgImpressaoCentral_1_6_6,
      'EnviarParaFilaAgImpressaoCentral_1_6_6');
  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarCertificacaoDoMandadoPeloFluxo_1_6_7;
var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
      ffpgVisualizaFluxoTrabalhoTests.CertificacaoDoMandadoPeloFluxo_1_6_7,
      'CertificacaoDoMandadoPeloFluxo_1_6_7');
  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarCertificacaoDoMandadoPeloFluxo_1_6_8;
var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    //**********Pré-Requisito**************
    gsNuProcesso := gsNuProcessosArray[1];
    gsNuMandado := gsNuMandadoArray[1];
    gsDataEmissao := gsDataEmissaoArray[1];
    TestarDistribuirMandadoAtividadeFluxo_1_6_4;
    TestarEnviarParaFilaAgImpressaoCentral_1_6_6;
    //*************************************
    gbDeveTrocarUsuario := True;
    ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
      ffpgVisualizaFluxoTrabalhoTests.CertificacaoDoMandadoPeloFluxo_1_6_8,
      'CertificacaoDoMandadoPeloFluxo_1_6_8');
  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest;  //PC_OK
  end;
end;

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarConsultaBasicaMandados_1_6_9_1;
begin

  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');

  gsNuProcesso := gsNuProcessosArray[0];
  gsNuMandado := gsNuMandadoArray[0];
  gsDataEmissao := gsDataEmissaoArray[0];
  gbMandadoDistribuido := True;
  TestarConsultaBasicaMandados;

  gsNuProcesso := gsNuProcessosArray[1];
  gsNuMandado := gsNuMandadoArray[1];
  gsDataEmissao := gsDataEmissaoArray[1];
  gbMandadoDistribuido := True;
  TestarConsultaBasicaMandados;
end;

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarConsultaAvancadaMandados_1_6_9_2;
begin

  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');

  gsNuProcesso := gsNuProcessosArray[0];
  gsNuMandado := gsNuMandadoArray[0];
  gsDataEmissao := gsDataEmissaoArray[0];
  gbMandadoDistribuido := True;
  TestarConsultaAvancadaMandados;

  gsNuProcesso := gsNuProcessosArray[1];
  gsNuMandado := gsNuMandadoArray[1];
  gsDataEmissao := gsDataEmissaoArray[1];
  gbMandadoDistribuido := True;
  TestarConsultaAvancadaMandados;
end;

// 13/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarRedistribuirMandadoFluxo_1_6_11;
var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    gsNuProcesso := gsNuProcessosArray[1];
    gsNuMandado := gsNuMandadoArray[1];
    ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
      ffpgVisualizaFluxoTrabalhoTests.RedistribuirMandadoFluxo_1_6_11,
      'RedistribuirMandadoFluxo_1_6_11');
  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 13/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarMudarParaFilaAgAnalise_1_6_10;

var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    gsNuProcesso := gsNuProcessosArray[0];
    gsNuMandado := gsNuMandadoArray[0];
    ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
      ffpgVisualizaFluxoTrabalhoTests.MudarParaFilaAgAnalise_1_6_10,
      'MudarParaFilaAgAnalise_1_6_10');
  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 13/10/2015  - Leandro.Humbert - SALT: 186660/20/8
procedure TfpgFluxoMandados.TestarVerificarFilaAgAnalise_1_6_12;
var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
begin
  gbLogarNoSetup := True;
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := False;
    gsNuProcesso := gsNuProcessosArray[0];
    gsNuMandado := gsNuMandadoArray[0];
    ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
      ffpgVisualizaFluxoTrabalhoTests.VerificarFilaAgAnalise_1_6_12,
      'VerificarFilaAgAnalise_1_6_12');
  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 22/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.TestarGerarImprimirGRJ_1_7_1_1;
var
  ffpgCalcCustaCompletaInicialProcTests: TffpgCalcCustaCompletaInicialProcTests;
begin
  gbErroTest := False;
  gbLogarNoSetup := False;
  ffpgCalcCustaCompletaInicialProcTests := TffpgCalcCustaCompletaInicialProcTests.Create; //PC_OK
  try
    ffpgCalcCustaCompletaInicialProcTests.FecharTela;
    ffpgCalcCustaCompletaInicialProcTests.spAbrirTelaNoSetUp := False;
    gbCentralCompartilhada := True;
    ffpgCalcCustaCompletaInicialProcTests.ExecutarRoteiroTestes(
      ffpgCalcCustaCompletaInicialProcTests.TestarGeracaoImpressaoGRJ_1_6_1,
      'TestarGeracaoImpressaoGRJ_1_7_1_1');
  finally
    ffpgCalcCustaCompletaInicialProcTests.FreeAndNilTest; //PC_OK
  end;
end;

// 22/10/2015 - Felipe.s SALT: 186660/20/8                   
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.TestarGerarImprimirGRJ_1_7_1_2;
var
  ffpgCalcCustaCompletaInicialProcTests: TffpgCalcCustaCompletaInicialProcTests;
begin
  ffpgCalcCustaCompletaInicialProcTests := TffpgCalcCustaCompletaInicialProcTests.Create; //PC_OK
  try
    ffpgCalcCustaCompletaInicialProcTests.FecharTela;
    ffpgCalcCustaCompletaInicialProcTests.spAbrirTelaNoSetUp := False;
    gbCentralCompartilhada := True;
    ffpgCalcCustaCompletaInicialProcTests.ExecutarRoteiroTestes(
      ffpgCalcCustaCompletaInicialProcTests.TestarGeracaoImpressaoGRJ_1_6_1,
      'TestarGeracaoImpressaoGRJ_1_7_1_2');
  finally
    ffpgCalcCustaCompletaInicialProcTests.FreeAndNilTest; //PC_OK
  end;
end;

// 26/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.TestarEmissaodeMandadoCMC_1_7_2_1;
var
  ffpgEdicaoDocumentoTests: TffpgEdicaoDocumentoTests;
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
  ffpgDigPecaProcessualTests: TffpgDigPecaProcessualTests;
  i: integer;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgDigPecaProcessualTests := TffpgDigPecaProcessualTests.Create; //PC_OK
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  ffpgEdicaoDocumentoTests := TffpgEdicaoDocumentoTests.Create; //PC_OK
  try
    ffpgEdicaoDocumentoTests.FecharTela;
    SetLength(gsDataEmissaoArray, High(gsNuProcessosArray) + 1);
    SetLength(gsNuMandadoArray, High(gsNuProcessosArray) + 1);
    gbDeveTrocarUsuario := True;
    for i := Low(gsNuProcessosArray) to High(gsNuProcessosArray) do
    begin
      gsNuProcesso := gsNuProcessosArray[i];
      //Pré Requisito: Digitalizar petição para processos digitais
      ffpgDigPecaProcessualTests.ExecutarRoteiroTestes(
        ffpgDigPecaProcessualTests.TestarEmissaodeMandadoDigitalCMC_1_7_2_1,
        'TestarEmissaodeMandadoDigitalCMC_1_7_2_1');
      //Abre Emissao de Documento pelo Fluxo de Trabalho
      ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
        ffpgVisualizaFluxoTrabalhoTests.EmissaoMandadoDigitalCMC_1_7_2_1,
        'TestarEmissaodeMandadoDigitalCMC_1_7_2_1');
      //Trata a tela de Emissão de Documento
      ffpgEdicaoDocumentoTests.spAbrirTelaNoSetUp := False;
      ffpgEdicaoDocumentoTests.ExecutarRoteiroTestes(
        ffpgEdicaoDocumentoTests.TestarEmissaodeMandadoCMC_1_7_2,
        'TestarEmissaodeMandadoDigitalCMC_1_7_2_1');
      gsDataEmissaoArray[i] := gsDataEmissao;
      gsNuMandadoArray[i] := gsNuMandado;
    end;
  finally
    ffpgEdicaoDocumentoTests.FreeAndNilTest; //PC_OK
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
    ffpgDigPecaProcessualTests.FreeAndNilTest; //PC_OK
  end;
end;

// 26/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.TestarEmissaodeMandadoCMC_1_7_2_2;
var
  ffpgEdicaoDocumentoTests: TffpgEdicaoDocumentoTests;
  i: integer;
begin
  ffpgEdicaoDocumentoTests := TffpgEdicaoDocumentoTests.Create; //PC_OK
  try
    SetLength(gsDataEmissaoArray, High(gsNuProcessosArray) + 1);
    SetLength(gsNuMandadoArray, High(gsNuProcessosArray) + 1);
    gbDeveTrocarUsuario := True;
    for i := Low(gsNuProcessosArray) to High(gsNuProcessosArray) do
    begin
      gsNuProcesso := gsNuProcessosArray[i];
      //Trata a tela de Emissão de Documento
      ffpgEdicaoDocumentoTests.ExecutarRoteiroTestes(
        ffpgEdicaoDocumentoTests.TestarEmissaodeMandadoCMC_1_7_2,
        'TestarEmissaodeMandadoFisicoCMC_1_7_2_2');
      gsDataEmissaoArray[i] := gsDataEmissao;
      gsNuMandadoArray[i] := gsNuMandado;
    end;
  finally
    ffpgEdicaoDocumentoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 26/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhada.TestarConsultaBasicaMandados_1_7_4;
var
  i: integer;
begin
  for i := Low(gsNuProcessosArray) to High(gsNuProcessosArray) do
  begin
    gsNuProcesso := gsNuProcessosArray[i];
    gsNuMandado := gsNuMandadoArray[i];
    gsDataEmissao := gsDataEmissaoArray[i];
    TestarConsultaBasicaMandados;
  end;
end;

// 28/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhada.TestarConsultaAvancadaMandados_1_7_4;
var
  i: integer;
begin
  for i := Low(gsNuProcessosArray) to High(gsNuProcessosArray) do
  begin
    gsNuProcesso := gsNuProcessosArray[i];
    gsNuMandado := gsNuMandadoArray[i];
    gsDataEmissao := gsDataEmissaoArray[i];
    TestarConsultaAvancadaMandados;
  end;
end;

// 26/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.TestarConsultaBasicaMandados_1_7_4_1;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  gbMandadoDistribuido := False;
  TestarConsultaBasicaMandados_1_7_4;
end;

// 26/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.TestarConsultaBasicaMandados_1_7_4_2;
begin
  gbMandadoDistribuido := False;
  TestarConsultaBasicaMandados_1_7_4;
end;

// 28/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.TestarConsultaAvancadaMandados_1_7_4_3;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  gbMandadoDistribuido := False;
  TestarConsultaAvancadaMandados_1_7_4;
end;

// 28/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.TestarConsultaAvancadaMandados_1_7_4_4;
begin
  gbMandadoDistribuido := False;
  TestarConsultaAvancadaMandados_1_7_4;
end;

// 28/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhada.TestarDistribuirMandadoFluxo_1_7_5;
var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
  i: integer;
begin
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    gbCentralCompartilhada := True;
    gbDeveTrocarUsuario := True;
    for i := Low(gsNuProcessosArray) to High(gsNuProcessosArray) do
    begin
      gsNuProcesso := gsNuProcessosArray[i];
      gsNuMandado := gsNuMandadoArray[i];
      ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
        ffpgVisualizaFluxoTrabalhoTests.DistribuirMandadoFluxo,
        'TestarDistribuirMandadoFluxo_1_7_5');
    end;

  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 28/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.TestarDistribuirMandadoFluxo_1_7_5_1;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  TestarDistribuirMandadoFluxo_1_7_5;
end;

// 28/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.TestarDistribuirMandadoFluxo_1_7_5_2;
begin
  TestarDistribuirMandadoFluxo_1_7_5;
end;

// 28/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.TestarConsultaBasicaMandadosCM_1_7_7_1;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  gbMandadoDistribuido := True;
  TestarConsultaBasicaMandados_1_7_4;
end;

// 28/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.TestarConsultaBasicaMandadosCM_1_7_7_2;
begin
  gbMandadoDistribuido := True;
  TestarConsultaBasicaMandados_1_7_4;
end;

// 28/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.TestarConsultaAvancadaMandadosCM_1_7_7_3;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  gbMandadoDistribuido := True;
  TestarConsultaAvancadaMandados_1_7_4;
end;

// 28/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.TestarConsultaAvancadaMandadosCM_1_7_7_4;
begin
  gbMandadoDistribuido := True;
  TestarConsultaAvancadaMandados_1_7_4;
end;

// 28/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhada.TestarEnvioParaFilaAgImpressaoCentral_1_7_8;
var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
  i: integer;
begin
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    ffpgVisualizaFluxoTrabalhoTests.spAbrirTelaNoSetUp := True;
    for i := Low(gsNuProcessosArray) to High(gsNuProcessosArray) do
    begin
      gsNuProcesso := gsNuProcessosArray[i];
      gsNuMandado := gsNuMandadoArray[i];
      ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
        ffpgVisualizaFluxoTrabalhoTests.EnviarParaFilaAgImpressaoCentral_1_6_6,
        'TestarEnvioParaFilaAgImpressaoCentralCMC_1_7_8');
    end;
  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.
TestarEnvioParaFilaAgImpressaoCentralCMC_1_7_8;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  TestarEnvioParaFilaAgImpressaoCentral_1_7_8;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.
TestarEnvioParaFilaAgImpressaoCentralCMC_1_7_8;
begin
  TestarEnvioParaFilaAgImpressaoCentral_1_7_8;
end;

// 30/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhada.TestarCertificacaoPeloFluxo_1_7_9;
var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
begin
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := False;
    gsNuProcesso := gsNuProcessosArray[0];
    gsNuMandado := gsNuMandadoArray[0];
    ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
      ffpgVisualizaFluxoTrabalhoTests.CertificacaoDoMandadoPeloFluxo_1_6_7,
      'TestarCertificacaoDoMandadoPeloFluxo_1_7_9');
  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.
TestarCertificacaoDoMandadoPeloFluxo_1_7_9;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  TestarCertificacaoPeloFluxo_1_7_9;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.TestarCertificacaoDoMandadoPeloFluxo_1_7_9;
begin
  TestarCertificacaoPeloFluxo_1_7_9;
end;

// 30/10/2015 - Felipe.s SALT: 186660/20/8
procedure TfpgFluxoCentralCompartilhada.TestarCertificacaoSemCumprimentoPeloFluxo_1_7_10;
var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
begin
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := False;
    gsNuProcesso := gsNuProcessosArray[1];
    gsNuMandado := gsNuMandadoArray[1];
    ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
      ffpgVisualizaFluxoTrabalhoTests.CertificacaoDoMandadoPeloFluxo_1_6_8,
      'TestarCertificacaoDoMandadoSemCumprimentoPeloFluxoCMC_1_7_10');
  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.
TestarCertificacaoDoMandadoSemCumprimentoPeloFluxo_1_7_10;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  TestarCertificacaoSemCumprimentoPeloFluxo_1_7_10;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.
TestarCertificacaoDoMandadoSemCumprimentoPeloFluxo_1_7_10;
begin
  TestarCertificacaoSemCumprimentoPeloFluxo_1_7_10;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.TestarConsultaBasicaMandados_1_7_11_1;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  gbMandadoDistribuido := True;
  TestarConsultaBasicaMandados_1_7_4;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.TestarConsultaBasicaMandados_1_7_11_2;
begin
  gbMandadoDistribuido := True;
  TestarConsultaBasicaMandados_1_7_4;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.TestarConsultaAvancadaMandados_1_7_11_3;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  gbMandadoDistribuido := True;
  TestarConsultaAvancadaMandados_1_7_4;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.TestarConsultaAvancadaMandados_1_7_11_4;
begin
  gbMandadoDistribuido := True;
  TestarConsultaAvancadaMandados_1_7_4;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhada.TestarEstaNaFilaAgAnalise_1_7_12_13;
var
  ffpgVisualizaFluxoTrabalhoTests: TffpgVisualizaFluxoTrabalhoPGTests;
begin
  ffpgVisualizaFluxoTrabalhoTests := TffpgVisualizaFluxoTrabalhoPGTests.Create; //PC_OK
  try
    gsNuProcesso := gsNuProcessosArray[0];
    gsNuMandado := gsNuMandadoArray[0];
    gbDeveTrocarUsuario := True;
    ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
      ffpgVisualizaFluxoTrabalhoTests.MudarParaFilaAgAnalise_1_6_10,
      'TestarMoverParaFilaAgAnalise_1_7_12_13');
    ffpgVisualizaFluxoTrabalhoTests.ExecutarRoteiroTestes(
      ffpgVisualizaFluxoTrabalhoTests.VerificarFilaAgAnalise_1_6_12,
      'TestarEstaNaFilaAgAnalise_1_7_12_13');
  finally
    ffpgVisualizaFluxoTrabalhoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhadaProcessosFisicos.TestarEstaNaFilaAgAnalise_1_7_13;
begin
  TestarEstaNaFilaAgAnalise_1_7_12_13;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoCentralCompartilhadaProcessosDigitais.TestarEstaNaFilaAgAnalise_1_7_12;
begin
  gbLogarNoSetup := True;
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  TestarEstaNaFilaAgAnalise_1_7_12_13;
end;


{ TfpgFluxoSemCentral }

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoSemCentral.TestarCadastrarProcesso;
var
  ffpgCadProccesso: TffpgCadProcessoTests;
begin
  gbErroTest := False;
  gbLogarNoSetup := False;
  ffpgCadProccesso := TffpgCadProcessoTests.Create; //PC_OK
  try
    ffpgCadProccesso.ExecutarRoteiroTestes(ffpgCadProccesso.PreencherCadastroProcesso,
      'TestarConfirmacaoDeValoresDiligencia_1_5_18');
    ffpgCadProccesso.FecharTela;
  finally
    ffpgCadProccesso.FreeAndNilTest; //PC_OK
  end;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoSemCentral.TestarEmitirMandado;
var
  ffpgRemessaCartorio: TfsmdRemessaCartorioCentralTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  gbDeveTrocarUsuario := True;
  ffpgRemessaCartorio := TfsmdRemessaCartorioCentralTests.Create; //PC_OK
  try
    ffpgRemessaCartorio.spVerificadorTelas.RegistrarMensagem('Não foi possível*', 'OK');
    ffpgRemessaCartorio.ExecutarRoteiroTestes(ffpgRemessaCartorio.EmitirMandado,
      'TestarConfirmacaoDeValoresDiligencia_1_5_18');
  finally
    ffpgRemessaCartorio.FreeAndNilTest; //PC_OK
  end;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoSemCentral.TestarGerarGRJeBaixar;
var
  ffpgCustas: TffpgCalcCustaCompletaInicialProcTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  gbDeveTrocarUsuario := False;
  ffpgCustas := TffpgCalcCustaCompletaInicialProcTests.Create; //PC_OK
  try
    ffpgCustas.ExecutarRoteiroTestes(ffpgCustas.CadastrarComplemento,
      'TestarConfirmacaoDeValoresDiligencia_1_5_18');
  finally
    ffpgCustas.FreeAndNilTest;  //PC_OK
  end;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoSemCentral.TestarRemeterCartorio;
var
  ffpgRemessa: TffpgRemessaTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgRemessa := TffpgRemessaTests.Create; //PC_OK
  try
    ffpgRemessa.ExecutarRoteiroTestes(ffpgRemessa.RealizarRemessa,
      'TestarConfirmacaoDeValoresDiligencia_1_5_18');
  finally
    ffpgRemessa.FreeAndNilTest; //PC_OK
  end;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoSemCentral.TestarRemeterAgente;
var
  ffpgRemessaCartorio: TfsmdRemessaCartorioCentralTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  gbDeveTrocarUsuario := False;
  ffpgRemessaCartorio := TfsmdRemessaCartorioCentralTests.Create; //PC_OK
  try
    ffpgRemessaCartorio.RemeterCartorioAgente;
  finally
    ffpgRemessaCartorio.FreeAndNilTest; //PC_OK
  end;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoSemCentral.TestarReceberAgente;
var
  fsmdRemessaCartorioCentralTests: TfsmdRemessaCartorioCentralTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  fsmdRemessaCartorioCentralTests := TfsmdRemessaCartorioCentralTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    fsmdRemessaCartorioCentralTests.ExecutarRoteiroTestes(
      fsmdRemessaCartorioCentralTests.ReceberAgenteCartorio,
      'TestarConfirmacaoDeValoresDiligencia_1_5_18_1');
  finally
    fsmdRemessaCartorioCentralTests.FreeAndNilTest; //PC_OK
  end;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoSemCentral.TestarCadastrarAtos;
var
  oRemessaTests: TfsmdRemessaAgenteCartorioCompletaTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  gbDeveTrocarUsuario := False;
  oRemessaTests := TfsmdRemessaAgenteCartorioCompletaTests.Create; //PC_OK
  try
    oRemessaTests.ExecutarRoteiroTestes(oRemessaTests.CadastrarAtos,
      'TestarConfirmacaoDeValoresDiligencia_1_5_18');
  finally
    oRemessaTests.FreeAndNilTest; //PC_OK
  end;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoSemCentral.TestarReceberCartorio;
var
  ffpgRemessaCartorio: TfsmdRemessaCartorioCentralTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgRemessaCartorio := TfsmdRemessaCartorioCentralTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    ffpgRemessaCartorio.ExecutarRoteiroTestes(ffpgRemessaCartorio.ReceberCartorioAgente,
      'TestarConfirmacaoDeValoresDiligencia_1_5_18');
  finally
    ffpgRemessaCartorio.FreeAndNilTest; //PC_OK
  end;
end;

// 05/11/2015 leandro.humbert SALT:186660/22/5
procedure TfpgFluxoSemCentral.TestarConfirmacaoDeValoresDiligencia_1_5_18;
begin
  TestarCadastrarProcesso;
  TestarGerarGRJeBaixar;
  TestarRemeterCartorio;
  TestarEmitirMandado;
  TestarRemeterAgente;
  TestarReceberAgente;
  TestarCadastrarAtos;
  TestarReceberCartorio;
end;

procedure TfpgFluxoSemCentral.TestarImpressaoCertidao_1_5_19;
var
  fpgGerenciadorArquivoTests: TffpgGerenciadorArquivoTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  fpgGerenciadorArquivoTests := TffpgGerenciadorArquivoTests.Create; //PC_OK
  try
    fpgGerenciadorArquivoTests.ExecutarRoteiroTestes(
      fpgGerenciadorArquivoTests.TestarImpressaoCertidao_1_5_19, 'TestarImpressaoCertidao_1_5_19');
  finally
    fpgGerenciadorArquivoTests.FreeAndNilTest; //PC_OK
  end;
end;

procedure TfpgFluxoSemCentral.TestarJuntadaMandado_1_5_20;
var
  fpgGerenciadorArquivoTests: TffpgGerenciadorArquivoTests;
  oModel: TffpgFluxoMandadosModelTests;
begin
  gbLogarNoSetup := True;
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  oModel := TffpgFluxoMandadosModelTests.Create;
  fpgGerenciadorArquivoTests := TffpgGerenciadorArquivoTests.Create; //PC_OK
  try
    fpgGerenciadorArquivoTests.spFecharTelaNoTearDown := False;
    fpgGerenciadorArquivoTests.ExecutarRoteiroTestes(
      fpgGerenciadorArquivoTests.TestarJuntadaMandado_1_5_20, 'TestarJuntadaMandado_1_5_20');
    Check(oModel.VerificarPublicaPessoa(gsNuProcesso), 'Falha - Ao validar Publicação Pessoa!');
  finally
    fpgGerenciadorArquivoTests.FreeAndNilTest; //PC_OK
    oModel.Free;
  end;
end;

procedure TfpgFluxoSemCentral.TestarValidarVinculacao;
var
  oModel: TffpgFluxoMandadosModelTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  oModel := TffpgFluxoMandadosModelTests.Create;
  try
    Check(oModel.VerificarVincRecColMand(gsNuProcesso, gsNuMandado, gsCdCalculoGRJ),
      'Falha - Ao validar vinculações!');
  finally
    oModel.Free;
  end;
end;

{ TfpgFluxoManddosPrisao }

procedure TfpgFluxoManddosPrisao.TestarEmissaoComplementoMovimentacaoAtoOrdinatorio_1_6_13;
var
  oEdicaoTests: TffpgEdicaoDocumentoTests;
begin
  oEdicaoTests := TffpgEdicaoDocumentoTests.Create; //PC_OK
  try
    oEdicaoTests.ExecutarRoteiroTestes(
      oEdicaoTests.EmissaoMandadoPrisaoComplementoMovAtoOrdinatorio_1_6_13,
      'EmissaoMandadoPrisaoComplementoMovAtoOrdinatorio_1_6_13');
  finally
    oEdicaoTests.FreeAndNilTest; //PC_OK
  end;
end;

procedure TfpgFluxoManddosPrisao.TestarMandadosPrisao_1_5_22;
var
  oEdicaoTests: TffpgEdicaoDocumentoTests;
begin
  oEdicaoTests := TffpgEdicaoDocumentoTests.Create; //PC_OK
  try
    oEdicaoTests.ExecutarRoteiroTestes(oEdicaoTests.TestarMandadosPrisao_1_5_22,
      'TestarMandadosPrisao_1_5_22');
  finally
    oEdicaoTests.FreeAndNilTest; //PC_OK
  end;
end;

procedure TfpgFluxoManddosPrisao.TestarEmissaoComMaisDeDuasCapitulacoesDiferentes_1_5_22_1;
var
  oEdicaoTests: TffpgEdicaoDocumentoTests;
begin
  oEdicaoTests := TffpgEdicaoDocumentoTests.Create; //PC_OK
  try
    oEdicaoTests.ExecutarRoteiroTestes(
      oEdicaoTests.TestarEmissaoMandadoPrisaoMaisDeDuasCapitulacoesDiferentes_1_5_22_1,
      'TestarEmissaoMandadoPrisaoMaisDeDuasCapitulacoesDiferentes_1_5_22_1');
  finally
    oEdicaoTests.FreeAndNilTest; //PC_OK
  end;
end;

procedure TfpgFluxoMandados_MS.TestarGeracaoImpressaoGRJCustasIntermediarias;
var
  ffpgCalcCustaCompletaIntermediariaProcTests: TffpgCalcCustaCompletaIntermediariaProcTests;
begin

  TffpgCadProcessoTests.PegarInstancia.ExecutarRoteiroTestes(
    TffpgCadProcessoTests.PegarInstancia.PreencherCadastroProcesso,
    'TestarRecebimentoMandadoAgenteConfirmarValorDaReserva_1_5_13');

  ffpgCalcCustaCompletaIntermediariaProcTests := TffpgCalcCustaCompletaIntermediariaProcTests.Create; //PC_OK
  try
    //Gerar guia custas intermediarias
    ffpgCalcCustaCompletaIntermediariaProcTests.ExecutarRoteiroTestes(
      ffpgCalcCustaCompletaIntermediariaProcTests.GeracaoImpressaoGRJCustasIntermediarias,
      'TestarRecebimentoMandadoAgenteConfirmarValorDaReserva_1_5_13');
  finally
    ffpgCalcCustaCompletaIntermediariaProcTests.FreeAndNilTest; //pc_ok
  end;
end;

procedure TfpgFluxoMandados_MS.TestarEmitirMandadosEnderecosAtendidos;
var
  ffpgRemessaCartorio: TfsmdRemessaCartorioCentralTests;
begin
  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  ffpgRemessaCartorio := TfsmdRemessaCartorioCentralTests.Create; //pc_ok
  try
    //Emitir Mandado e remeter para Central de mandados
    ffpgRemessaCartorio.ExecutarRoteiroTestes(ffpgRemessaCartorio.EmitirMandado,
      'TestarRecebimentoMandadoAgenteConfirmarValorDaReserva_1_5_13');
  finally
    ffpgRemessaCartorio.FreeAndNilTest;//pc_ok
  end;
end;

// 04/01/2016 - Felipe.s SALT:186660/23/8
procedure TfpgFluxoMandados_MS.TestarRemessaCartorioparaCentralMandados;
var
  RemessaCartorioCentralTests: TfsmdRemessaCartorioCentralTests;
begin
  //  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  RemessaCartorioCentralTests := TfsmdRemessaCartorioCentralTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    RemessaCartorioCentralTests.ExecutarRoteiroTestes(
      RemessaCartorioCentralTests.RemessaProcessoCentral,
      'TestarRemessaCartorioparaCentralMandados_1_8_5');
  finally
    RemessaCartorioCentralTests.FreeAndNilTest; //PC_OK
  end;
end;

// 05/01/2016 - Felipe.s SALT:186660/23/8
procedure TfpgFluxoMandados_MS.TestarRecebimentoPelaCentralDeMandados;
var
  RemessaCartorioCentralTests: TfsmdRemessaCartorioCentralTests;
begin
  //  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  RemessaCartorioCentralTests := TfsmdRemessaCartorioCentralTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    RemessaCartorioCentralTests.ExecutarRoteiroTestes(
      RemessaCartorioCentralTests.ReceberProcessoCentral,
      'TestarRecebimentoPelaCentralDeMandados_1_8_6');
  finally
    RemessaCartorioCentralTests.FreeAndNilTest; //PC_OK
  end;
end;

// 05/01/2016 - Felipe.s SALT:186660/23/8
procedure TfpgFluxoMandados_MS.TestarDistribuicaoMandado;
var
  TransferenciaMandadoTests: TfsmdTransferenciaMandadoTests;
begin
  //  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  TransferenciaMandadoTests := TfsmdTransferenciaMandadoTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    TransferenciaMandadoTests.ExecutarRoteiroTestes(TransferenciaMandadoTests.DistribuirMandado,
      'TestarDistribuicaoMandado_1_8_7');
  finally
    TransferenciaMandadoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 06/01/2016 - Felipe.s SALT:186660/23/8
procedure TfpgFluxoMandados_MS.TestarRemeterParaOficialDeJustica;
var
  RemessaCartorioCentralTests: TfsmdRemessaCartorioCentralTests;
begin
  //  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  RemessaCartorioCentralTests := TfsmdRemessaCartorioCentralTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    RemessaCartorioCentralTests.ExecutarRoteiroTestes(
      RemessaCartorioCentralTests.RemeterCentralAgente,
      'TestarRemeterParaOficialDeJustica_1_8_8');
  finally
    RemessaCartorioCentralTests.FreeAndNilTest; //PC_OK
  end;
end;

// 06/01/2016 - Felipe.s SALT:186660/23/8
procedure TfpgFluxoMandados_MS.TestarReceberMandadoDaCentralDeJustica;
var
  RemessaCartorioCentralTests: TfsmdRemessaCartorioCentralTests;
begin
  //  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  RemessaCartorioCentralTests := TfsmdRemessaCartorioCentralTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    RemessaCartorioCentralTests.ExecutarRoteiroTestes(
      RemessaCartorioCentralTests.ReceberCentralAgente,
      'TestarReceberMandadoDaCentralDeJustica_1_8_9');
  finally
    RemessaCartorioCentralTests.FreeAndNilTest; //PC_OK
  end;
end;

// 07/01/2016 - Felipe.s SALT:186660/23/8
procedure TfpgFluxoMandados_MS.TestarCertificarMandadoPeloAgente;
var
  EdicaoDocumentoTests: TffpgEdicaoDocumentoTests;
begin
  //  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  EdicaoDocumentoTests := TffpgEdicaoDocumentoTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    EdicaoDocumentoTests.ExecutarRoteiroTestes(EdicaoDocumentoTests.CertificarMandadoPeloAgente,
      'TestarCertificarMandadoPeloAgente_1_8_10');
  finally
    EdicaoDocumentoTests.FreeAndNilTest; //PC_OK
  end;
end;

// 07/01/2016 - Felipe.s SALT:186660/23/8
procedure TfpgFluxoMandados_MS.TestarRemessaParaCentralPeloAgente;
var
  RemessaAgenteCentralCompletaTests: TfsmdRemessaAgenteCentralCompletaTests;
begin
  //  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  RemessaAgenteCentralCompletaTests := TfsmdRemessaAgenteCentralCompletaTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    RemessaAgenteCentralCompletaTests.ExecutarRoteiroTestes(
      RemessaAgenteCentralCompletaTests.RemessaParaCentralPeloAgente,
      'TestarRemessaParaCentralPeloAgente_1_8_11');
  finally
    RemessaAgenteCentralCompletaTests.FreeAndNilTest; //PC_OK
  end;
end;

// 07/01/2016 - Felipe.s SALT:186660/23/8
procedure TfpgFluxoMandados_MS.TestarGerarAtoCumprimentoRemeterCentral;
var
  RemessaAgenteCentralCompletaTests: TfsmdRemessaAgenteCentralCompletaTests;
begin
  //  checkFalse(gbErroTest, 'Falha - Erro do Fluxo na Atividade Anterior!');
  RemessaAgenteCentralCompletaTests := TfsmdRemessaAgenteCentralCompletaTests.Create; //PC_OK
  try
    gbDeveTrocarUsuario := True;
    RemessaAgenteCentralCompletaTests.ExecutarRoteiroTestes(
      RemessaAgenteCentralCompletaTests.GerarAtoCumprimentoRemeterCentral,
      'TestarGerarAtoCumprimentoRemeterCentral_1_8_12');
  finally
    RemessaAgenteCentralCompletaTests.FreeAndNilTest; //PC_OK
  end;
end;

procedure TfpgFluxoMandados_MS.TestarGerarGuiaOficial;
begin
  // Gerar guia de pagamento para o Oficial
  TffpgCadGuiaTests.PegarInstancia.ExecutarRoteiroTestes(
    TffpgCadGuiaTests.PegarInstancia.CadastrarGuia,
    'TestarRecebimentoMandadoAgenteConfirmarValorDaReserva_1_5_13');
end;

end.


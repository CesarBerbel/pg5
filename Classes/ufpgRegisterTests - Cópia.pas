unit ufpgRegisterTests;

interface


uses TestFramework, uspTestCase,
  ufpgCadProcessoTests,
  ufpgCadHistoricoParteTests,
  ufpgCadArmasBensPG5Tests,
  ufpgCadMovimentacaoUnitariaTests,
  ufpgCadModeloTests,
  ufpgEdicaoDocumentoTests,
  ufpgRemessaTests,
  ufpgVisualizaFluxoTrabalhoTests,
  ufpgDigPecaProcessualTests,
  ufpgEditorTests,
  ufpgGerenciadorArquivoTests,
  ufpgFluxoMandadosTests,
  ufpgCalcCustaCompletaInicialProcTests,
  usmdRemessaCartorioCentralTests,
  usmdTransferenciaMandadoTests,
  ufpgRedistribuicaoTests,
  usmdRemessaAgenteCentralCompletaTests,
  ufpgConsProcAvancadaTests,
  ufpgCancelaRedistForoTests,
  usarConsARsJuntPendTests,
  ufpgRelFichaProcTests,
  ufpgCadUnificacaoTests,
  ufpgRedistribLoteVagaTests,
  ufpgConsSenhaProcessoTests,
  usggFavoritosTests,
  usggConsBibliotecaTests;


procedure RegistrarTestes;

implementation

procedure RegistrarTestes;
begin

//Cadastro
  TspTestCase.RegisterTestXLS('Interface\Cadastro\Processos',
    TffpgCadProcessoTests);
  TspTestCase.RegisterTestXLS('Interface\Cadastro\Armas e bens', TffpgCadArmasBensPG5Tests);
  RegisterTest('Interface\Cadastro\Digitaliza��o de Pe�as Processuais',
    TffpgDigPecaProcessualTests.Suite);

  RegisterTest('Interface\Unifica��o Processo',
    TffpgCadUnificacaoTests.Suite);

  RegisterTest('Interface\Cadastro\Redistribui��o entre Vagas', TffpgRedistribLoteVagaTests.Suite);

//Expediente
  RegisterTest('Interface\Expediente\Cadastro de Modelos de Documentos',
    TffpgCadModeloTests.Suite);
  RegisterTest('Interface\Expediente\Emiss�o De Documento', TffpgEdicaoDocumentoTests.Suite);
  RegisterTest('Interface\Expediente\Editor de Documentos', TffpgEditorTests.Suite);
  RegisterTest('Interface\Expediente\Gerenciador de Arquivos', TffpgGerenciadorArquivoTests.Suite);

//Andamento
  RegisterTest('Interface\Andamento\Movimenta��o Unit�ria',
    TffpgCadMovimentacaoUnitariaTests.Suite);
  RegisterTest('Interface\Andamento\Fluxo de Trabalho', TffpgVisualizaFluxoTrabalhoTests.Suite);
  RegisterTest('Interface\Andamento\Fluxo de Trabalho', TfpgTestarFluxoTrabalho_1_4_11.Suite);


//Carga
  RegisterTest('Interface\Carga\Remessa', TffpgRemessaTests.Suite);
  RegisterTest('Interface\Carga\Redistribui��o entre Foros - Cancelamento',
    TffpgCancelaRedistForoTests.Suite);

//Custas
  RegisterTest('Interface\Custas\Iniciais - Processo',
    TffpgCalcCustaCompletaInicialProcTests.Suite);

//AR
  RegisterTest('Interface\AR\Fluxo de AR', TfsarConsARsJuntPendTests.Suite);

//Consulta
  RegisterTest('Interface\Consulta\Consulta Avan�ada de Processos',
    TffpgConsProcAvancadaTests.Suite);

//Relatorios
  RegisterTest('Interface\Relat�rios\Processos\Ficha do Processo', TffpgRelFichaProcTests.Suite);

//Mandandos
  RegisterTest('Interface\Mandados', TfpgFluxoMandados.Suite);
  RegisterTest('Interface\Mandados',
    TfpgFluxoCentralCompartilhadaProcessosDigitais.Suite);
  RegisterTest('Interface\Mandados\TestarConfirmacaoDeValoresDiligencia_1_5_18',
    TfpgFluxoSemCentral.Suite);
  RegisterTest('Interface\Mandados', TfpgFluxoManddosPrisao.Suite);
  RegisterTest('Interface\Mandados\Remessa para central de mandados',
    TfsmdRemessaCartorioCentralTests.Suite);
  RegisterTest('Interface\Mandados\Distribui��o\Transfer�ncia',
    TfsmdTransferenciaMandadoTests.Suite);
  RegisterTest('Interface\Mandados\Redistribui��o', TffpgRedistribuicaoTests.Suite);
  RegisterTest('Interface\Mandados\Cadastro de Atos',
    TfsmdRemessaAgenteCentralCompletaTests.Suite);

  //Ferramentas
  RegisterTest('Interface\Ferramentas\Consultas\Cadastro', TfsggFavoritosTests.Suite);
  RegisterTest('Interface\Ferramentas\Consultas\Cadastro', TfsggConsBibliotecaTests.Suite);
  
//Em Avaliacao - BUGs

  {
  RegisterTest('Interface\Avaliacao\Certid�o\Cadastro de Certid�o\Modelo 6_12',
    TfsgcCadPedidoTests.Suite);
  RegisterTest('Interface\Avaliacao\Certid�o\Fila',
    TfsgcFilaGeralIndicTests.Suite);
  }
  RegisterTest('Interface\Avaliacao\Andamento\Hist�rico de Partes',
    TffpgCadHistoricoParteTests.Suite);
  RegisterTest('Interface\Avaliacao\Andamento\Senha do Processo',
    TffpgConsSenhaProcessoTests.Suite);

end;

initialization
   RegistrarTestes;

end.

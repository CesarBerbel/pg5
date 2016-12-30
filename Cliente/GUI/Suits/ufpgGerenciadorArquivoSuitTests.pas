unit ufpgGerenciadorArquivoSuitTests;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgGerenciadorArquivoTests, ufpgEdicaoDocumentoTests,
  ufpgEditorTests, ufpgMaterializaProcessoTests, ufpgVariaveisTestesGUI,
  ufpgConstanteGUITests, ufpgConfirmacaoMovTests, ufpgCadMovimentacaoUnitariaTests,
  ufpgCadModeloTests;

implementation

const
  CS_CAMINHO_TESTE = 'Gerenciador de Arquivos';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    //Cadastro de Processo
    RegisterTest(CS_CAMINHO_TESTE + ' Confirmar Estrutura de pasta, Assinar e movimentações',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    //Materializar Processo
    RegisterTest(CS_CAMINHO_TESTE + ' Confirmar Estrutura de pasta, Assinar e movimentações',
      TffpgMaterializaProcessoTests.Create('TestarMaterializaProcesso', ''));

    //Emitir Documento
    RegisterTest(CS_CAMINHO_TESTE + ' Confirmar Estrutura de pasta, Assinar e movimentações',
      TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento', 'TestarEmissaoConfirmaMov'));
    //'TestarGerenciadorConfirmaMov'));

    //Editor
    RegisterTest(CS_CAMINHO_TESTE + ' Confirmar Estrutura de pasta, Assinar e movimentações',
      TffpgEditorTests.Create('TestarEditor', 'TestarEmissaoConfirmaMov'));
    //'TestarGerenciadorConfirmaMov'));

    //Movimentação Documento
    RegisterTest(CS_CAMINHO_TESTE + ' Confirmar Estrutura de pasta, Assinar e movimentações',
      TffpgCadMovimentacaoUnitariaTests.Create('TestarCadastrarMovUnitaria',
      'TestarCadastrarMovUnitaria'));

    //Gerenciador Arquivo
    RegisterTest(CS_CAMINHO_TESTE + ' Confirmar Estrutura de pasta, Assinar e movimentações',
      TffpgGerenciadorArquivoTests.Create('TestarGerenciadorArquivos',
      'TestarGerenciadorConfirmaMov', 1, True));
  end
  else
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPenalSimples'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarGerenciadorArquivo'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarGerenciadorArquivo'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgGerenciadorArquivoTests.Create(
      'TestarGerenciadorArquivos', 'TestarEdicaoGerenciador'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarEdicaoGerenciador'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgGerenciadorArquivoTests.Create(
      'TestarConsutarPorProcesso', 'TestarGerenciadorArquivo'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgGerenciadorArquivoTests.Create(
      'TestarConsultarPorUltimaAlteracao', 'TestarConsultarArquivoDataUltimaAlteracao'));


    RegisterTest(CS_CAMINHO_TESTE, TffpgGerenciadorArquivoTests.Create(
      'TestarConsutarPorNome', 'TestarConsultaPorNome'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgGerenciadorArquivoTests.Create(
      'TestarConsultaPorUsuarioCriacao', 'TestarConsultaPorUsuarioCriacao'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgGerenciadorArquivoTests.Create(
      'TestarConsultaPorOutrasDatas', 'TestarConsultaPorOutrasDatas'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgGerenciadorArquivoTests.Create(
      'TestarConsultaPorDocsCompartilhados', 'TestarConsultaPorDocsCompartilhados'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgGerenciadorArquivoTests.Create(
      'TestarConsultaPorDocsMovPendentes', 'TestarConsultaPorDocsMovPendentes'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgGerenciadorArquivoTests.Create(
      'TestarConsultaPorOutrosGrupos', 'TestarConsultaPorOutrosGrupos', 1, True));
  end;
end.


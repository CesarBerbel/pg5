unit ufpgEdicaoDocumentoSuitTests;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgEdicaoDocumentoTests,
  ufpgCadProcessoTests, usajConstante, ufpgEditorTests, ufpgImportacaoArquivosMultimidiaTests,
  ufpgCadModeloTests, ufpgGerenciadorArquivoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Emitir expediente\';


initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    //Emissão de expediente normal
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarEmissaoExpedientes_1_12_20'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarEmissaoExpedientes_1_12_20'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarEmissaoExpedientes_1_12_20', 1, True));

    //-------------------

    if gsCliente = 'erro' then
    begin
      //Suite que substitui o teste TestarEmissaoDeDocumentosUsandoModeloCriado_1_12_3
      RegisterTest(CS_CAMINHO_TESTE + 'Emitir documentos usando o modelo criado',
        TffpgCadModeloTests.Create('TestarCadastrarModelo',
        'TestarEmissaoDeDocumentosUsandoModeloCriado_1_12_3'));

      RegisterTest(CS_CAMINHO_TESTE + 'Emitir documentos usando o modelo criado',
        TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'ProcessoPenalGenerico'));

      RegisterTest(CS_CAMINHO_TESTE + 'Emitir documentos usando o modelo criado',
        TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
        'TestarEmissaoDeDocumentosUsandoModeloCriado_1_12_3'));

      RegisterTest(CS_CAMINHO_TESTE + 'Emitir documentos usando o modelo criado',
        TffpgEditorTests.Create('TestarEditor',
        'TestarEmissaoDeDocumentosUsandoModeloCriado_1_12_3'));

      RegisterTest(CS_CAMINHO_TESTE + 'Emitir documentos usando o modelo criado',
        TffpgGerenciadorArquivoTests.Create('TestarGerenciadorArquivos',
        'TestarEmissaoDeDocumentosUsandoModeloCriado_1_12_3'));

      RegisterTest(CS_CAMINHO_TESTE + 'Emitir documentos usando o modelo criado',
        TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
        'TestarEmissaoDeDocumentosUsandoModeloCriado_1_12_3_1'));

      RegisterTest(CS_CAMINHO_TESTE + 'Emitir documentos usando o modelo criado',
        TffpgEditorTests.Create('TestarEditor',
        'TestarEmissaoDeDocumentosUsandoModeloCriado_1_12_3_1',
        1, True));

      //Suite que substitui o teste TestaremissaoDeDocumentoDaCategoriaEdital_1_2_34
      RegisterTest(CS_CAMINHO_TESTE + 'Edital e observar os procedimentos de publicação',
        TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'ProcessoAlteracaoDocumento'));

      RegisterTest(CS_CAMINHO_TESTE + 'Edital e observar os procedimentos de publicação',
        TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
        'TestarEmissaoAlterarDocumento_1_2_34'));

      RegisterTest(CS_CAMINHO_TESTE + 'Edital e observar os procedimentos de publicação',
        TffpgEditorTests.Create('TestarEditor', 'TestarEmissaoAlterarDocumento_1_2_34'));

      RegisterTest(CS_CAMINHO_TESTE + 'Edital e observar os procedimentos de publicação',
        TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
        'TestarEmissaoAlterarDocumento_1_2_34_1', 1, True));

      //-------------------

      //Suite que substitui o teste TestarEmissaoDeOficioDespacho_1_3_1 e TestarEmissaoDocumentoDestacados_1_3_2
      RegisterTest(CS_CAMINHO_TESTE + 'Um ofício e um despacho - marcar “amarelo” e salvar',
        TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'ProcessoAlteracaoDocumento'));

      RegisterTest(CS_CAMINHO_TESTE + 'Um ofício e um despacho - marcar “amarelo” e salvar',
        TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
        'TestarEmissaoDeOficioDespacho_1_3_1'));

      RegisterTest(CS_CAMINHO_TESTE + 'Um ofício e um despacho - marcar “amarelo” e salvar',
        TffpgEditorTests.Create('TestarEditor', 'TestarEmissaoDeOficioDespacho_1_3_1', 1, True));
    end;
    //---------------------

    //Suite que substitui o teste TestarEmissaoDocumentoDestacados_1_3_3
    RegisterTest(CS_CAMINHO_TESTE + 'Emitr o ofício Modelo 7937 - Digital',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'ProcessoCartaPrecatoria'));

    RegisterTest(CS_CAMINHO_TESTE + 'Emitr o ofício Modelo 7937 - Digital',
      TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarEmitirOficioComModelo_1_3_3', 1, True));

    //--------------------------

    if gsCliente = 'erro' then
    begin

      //Suite que substitui o teste TestarEmitirOficiosProcessoDigital_1_3_4
      RegisterTest(CS_CAMINHO_TESTE + 'Emitir ofícios em processo digital',
        TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'TestarCadastroOficioDigital'));

      RegisterTest(CS_CAMINHO_TESTE + 'Emitir ofícios em processo digital',
        TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
        'TestarEmitirOficiosProcessoDigital_1_3_4'));

      RegisterTest(CS_CAMINHO_TESTE + 'Emitir ofícios em processo digital',
        TffpgEditorTests.Create('TestarEditor', 'TestarEmitirOficiosProcessoDigital_1_3_4',
        1, True));

      //--------------------------


      //Suite que substitui o teste  TestarModelosFormaPostagemAR_1_3_5
      RegisterTest(CS_CAMINHO_TESTE + 'Modelos com forma de postagem AR',
        TffpgCadProcessoTests.Create('TestarCadastroProcesso',
        'TestarModelosFormaPostagemAR_1_3_5'));

      RegisterTest(CS_CAMINHO_TESTE + 'Modelos com forma de postagem AR',
        TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
        'TestarModelosFormaPostagemAR_1_3_5'));

      RegisterTest(CS_CAMINHO_TESTE + 'Modelos com forma de postagem AR',
        TffpgEditorTests.Create('TestarEditor', 'TestarModelosFormaPostagemAR_1_3_5', 1, True));

      //Suite que substitui o teste TestarEmissaoAtoCitacao_1_4_12
      RegisterTest(CS_CAMINHO_TESTE + 'Gerar atos', TffpgCadProcessoTests.Create(
        'TestarCadastroProcesso', 'ProcessoPenalGenerico'));

      RegisterTest(CS_CAMINHO_TESTE + 'Gerar atos',
        TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
        'TestarEmissaoAtoCitacao_1_4_12'));

      RegisterTest(CS_CAMINHO_TESTE + 'Gerar atos', TffpgEditorTests.Create(
        'TestarEditor', 'TestarEmissaoAtoCitacao_1_4_12'));

      RegisterTest(CS_CAMINHO_TESTE + 'Gerar atos',
        TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
        'TestarEmissaoAtoCitacao_1_4_12_1', 1, True));

      //------------------------
      //Suite que substitui o teste TestarGerarAtoIntimacaoComCitação_1_4_23
      RegisterTest(CS_CAMINHO_TESTE + 'Fazer uma intimação para um convênio',
        TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'ProcessoPenalGenerico'));

      RegisterTest(CS_CAMINHO_TESTE + 'Fazer uma intimação para um convênio',
        TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
        'TestarGerarAtoIntimacaoComCitacao_1_4_23'));

      RegisterTest(CS_CAMINHO_TESTE + 'Fazer uma intimação para um convênio',
        TffpgEditorTests.Create('TestarEditor', 'TestarGerarAtoIntimacaoComCitacao_1_4_23'));

      RegisterTest(CS_CAMINHO_TESTE + 'Fazer uma intimação para um convênio',
        TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
        'TestarGerarAtoIntimacaoComCitacao_1_4_23_1'));

      RegisterTest(CS_CAMINHO_TESTE + 'Fazer uma intimação para um convênio',
        TffpgEditorTests.Create('TestarEditor', 'TestarGerarAtoIntimacaoComCitacao_1_4_23_1',
        1, True));

      //-------------------------

      //Suite que substitui o teste TestarImportarArquivoMultimidiaLiberarDocumento_1_11_2
      RegisterTest(CS_CAMINHO_TESTE + 'Importação de arquivos multimídia',
        TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'ProcessoPenalGenerico'));

      RegisterTest(CS_CAMINHO_TESTE + 'Importação de arquivos multimídia',
        TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
        'TestarImportarArquivoMultimidiaLiberarDocumento_1_11_2'));

      RegisterTest(CS_CAMINHO_TESTE + 'Importação de arquivos multimídia',
        TffpgEditorTests.Create('TestarEditor',
        'TestarImportarArquivoMultimidiaLiberarDocumento_1_11_2'));
      //Importar arquivo de multimidia pelo Editor
      RegisterTest(CS_CAMINHO_TESTE + 'Importação de arquivos multimídia',
        TffpgImportacaoArquivosMultimidiaTests.Create('TestarImportacaoArquivosMultimidia',
        'TestarImportarArquivoMultimidiaLiberarDocumento_1_11_2'));
      //Importar arquivo de multimidia pelo Menu
      RegisterTest(CS_CAMINHO_TESTE + 'Importação de arquivos multimídia',
        TffpgImportacaoArquivosMultimidiaTests.Create('TestarImportacaoArquivosMultimidia',
        'TestarImportarArquivoMultimidiaLiberarDocumento_1_11_2_1', 1, True));

    end;
  end
  else
  begin
    //Emissão de expediente normal
    RegisterTest(CS_CAMINHO_TESTE + 'Expediente Normal',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'CadastroProcessoPenalSorteio'));

    RegisterTest(CS_CAMINHO_TESTE + 'Expediente Normal',
      TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento', 'TestarEmissaoExpedientesNormal'));

    RegisterTest(CS_CAMINHO_TESTE + 'Expediente Normal',
      TffpgEditorTests.Create('TestarEditor', 'TestarEmissaoExpedientesNormal', 1, True));
  end;
end.


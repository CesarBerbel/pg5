unit usgcCertidaoFilasSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, usgcFilaGeralIndicTests,
  usgcFilaAguardProcesTests, usgcCadPedidoTests, usgcPesqPedidoTests,
  ufpgAnalisePedidoTests, usgcFilaEmAnaliseIndicTests, usgcFilaSuspProcesTests,
  usgcMudaSituacaoPedTests, usgcFilaAguardEntregaTests, usgcFilaAguardImpressaoTests,
  usgcCadEntregaTests, usgcFilaPedidosExpiradosTests, usgcFilaSuspAnaliseTests,
  ufpgCadProcessoTests, usgcFilaAguardAnaliseTests;

implementation

const
  CS_CAMINHO_TESTE = 'Certidão';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    //**************** CADASTRO DE PEDIDO ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Cadastro de Pedidos',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoReaproveitaDados', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '\ Cadastro de Pedidos',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoReaproveitaModelo', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '\ Cadastro de Pedidos',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoReaproveitaPessoa', 1, True));

    //**************** CONSULTA DE PEDIDO ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Consulta de Pedidos',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Consulta de Pedidos',
      TfsgcPesqPedidoTests.Create('TestarPesqPedido', 'TestarPesqPedido', 1, True));

    //**************** AGUARDANDO PROCESSAMENTO ****************              
    //COMENTADO POIS COM O PSS5 ATIVO O PROCESSO NAO FICA NA FILA.
    //    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Processamento',
    //      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    //    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Processamento',
    //      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
    //      'TestarMudaSituacaoPedAguardProcessamento'));

    //    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Processamento',
    //      TfsgcFilaAguardProcesTests.Create('TestarFilaAguardProces',
    //      'TestarFilaAguardProcesPrioriza', 1, True));

    //**************** EM PROCESSAMENTO ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Em Processamento',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Em Processamento',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoPedEmProcessamento', 1, True));

    //**************** PROCESSAMENTO SUSPENSO ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Processamento Suspenso',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Processamento Suspenso',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoPedProcSuspenso'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Processamento Suspenso',
      TfsgcFilaSuspProcesTests.Create('TestarFilaProcSuspenso', '', 1, True));

    //**************** AGUARDANDO ANALISE ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Analise',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Analise',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoPedAguardAnalise'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Analise',
      TfsgcFilaAguardAnaliseTests.Create('TestarFilaAguardAnalise',
      'TestarFilaAguardAnalise', 1, True));

    //**************** EM ANALISE ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Em análise',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Em análise',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed', 'TestarMudaSituacaoPedEmAnalise'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Em análise',
      TfsgcFilaEmAnaliseIndicTests.Create('TestarFilaEmAnaliseIndic',
      'TestarConsultaPerdidoEmAnalise', 1, True));

    //**************** AGUARDAND0 IMPRESSÃO ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Impressão',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Impressão',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoPedAgImpressao'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Impressão',
      TfsgcFilaAguardImpressaoTests.Create('TestarFilaAguardImpressao', '', 1, True));

    //**************** AGUARDAND0 IMPRESSÃO - REPROCESSAR ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Impressão - Reprocessar',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Impressão - Reprocessar',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoPedAgImpressao'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Impressão - Reprocessar',
      TfsgcFilaAguardImpressaoTests.Create('TestarFilaAguardImpressao',
      'TestarFilaAguardImpressaoReprocessar', 1, True));

    //**************** AGUARDANDO ENTREGA ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Entrega',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Entrega',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoPedAguardEntrega'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Entrega',
      TfsgcFilaAguardEntregaTests.Create('TestarFilaAguardEntrega',
      'TestarFilaAguardEntregaEntregar', 1, True));

    //**************** AGUARDANDO ENTREGA - REEMISAO CERTIDOES ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Entrega - Reemissão Certidões',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Entrega - Reemissão Certidões',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoPedAguardEntrega'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Aguardando Entrega - Reemissão Certidões',
      TfsgcFilaAguardEntregaTests.Create('TestarFilaAguardEntrega',
      'TestarFilaAguardEntregaReemissaoCertidao', 1, True));

    //**************** PEDIDOS EXPIRADOS ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Pedidos Expirados',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Pedidos Expirados',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed', 'TestarMudaSituacaoPedExpirados'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Pedidos Expirados',
      TfsgcFilaPedidosExpiradosTests.Create('TestarFilaPedidosExpirados',
      'TestarFilaPedidosExpirados', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Excluir',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Excluir',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoFilaAguardPesqManual'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Excluir',
      TfsgcFilaGeralIndicTests.Create('TestarFilaUnicaPedidos',
      'TestarFilaUnicaPedidosExcluir', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Atender',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Atender',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoFilaAguardPesqManual'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Atender',
      TfsgcFilaGeralIndicTests.Create('TestarFilaUnicaPedidos',
      'TestarFilaUnicaPedidosAtender', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Distribuir',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Distribuir',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoPedAguardAnalise'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Distribuir',
      TfsgcFilaGeralIndicTests.Create('TestarFilaUnicaPedidos',
      'TestarFilaUnicaPedidosDistribuir', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Liberar',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Liberar',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoFilaEmPesqManual'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Liberar',
      TfsgcFilaGeralIndicTests.Create('TestarFilaUnicaPedidos',
      'TestarFilaUnicaPedidosLiberar', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Analisar',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Analisar',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoPedAguardAnalise'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Analisar',
      TfsgcFilaGeralIndicTests.Create('TestarFilaUnicaPedidos',
      'TestarFilaUnicaPedidosAnalisar', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Emitir',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Emitir',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoPedAgImpressao'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Única \ Emitir',
      TfsgcFilaGeralIndicTests.Create('TestarFilaUnicaPedidos',
      'TestarFilaUnicaPedidosEmitir', 1, True));

    //**************** ENTREGA ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Entrega', TfsgcCadPedidoTests.Create(
      'TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Entrega', TfsgcMudaSituacaoPedTests.Create(
      'TestarMudaSituacaoPed', 'TestarMudaSituacaoPedAguardEntrega'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Entrega', TfsgcCadEntregaTests.Create(
      'TestarCadEntrega', 'TestarCadEntrega', 1, True));


    //**************** VERIFICAÇÃO DO PROCESSAMENTO DO PEDIDO ****************
    RegisterTest(CS_CAMINHO_TESTE + 'Verificação do Processamento do Pedido',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso', CS_PROCESSO_PENAL_GENERICO_SORTEIO));

    RegisterTest(CS_CAMINHO_TESTE + 'Verificação do Processamento do Pedido',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + 'Verificação do Processamento do Pedido',
      TffpgAnalisePedidoTests.Create('TestarAnalisePedido', 'TestarAnalisePedido', 1, True));

    //**************** AGUARDAND0 ANALISE ****************
    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Pedido Aguardando Suspenso',
      TfsgcCadPedidoTests.Create('TestarCadPedido', 'TestarCadPedidoBasico'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Pedido Aguardando Suspenso',
      TfsgcMudaSituacaoPedTests.Create('TestarMudaSituacaoPed',
      'TestarMudaSituacaoFilaSuspAnalise'));

    RegisterTest(CS_CAMINHO_TESTE + '\ Filas \ Pedido Aguardando Suspenso',
      TfsgcFilaSuspAnaliseTests.Create('TestarFilaSuspAnalise', '', 1, True));
  end;
end.


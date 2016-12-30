unit ufpgConfigIntimaAdvSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgCadMovimentacaoUnitariaTests,
  ufpgConfigIntimaAdvTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgCertPubIntimaAdvTests, ufpgCertEmiIntimaAdvTests, ufpgConsRelacaoTodasTests;

implementation

const
  CS_CAMINHO_TESTE = 'Publicação / Intimação de Advogados';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE + '/ Configuração / Por Consulta de Período',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Configuração / Por Consulta de Período',
      TffpgCadMovimentacaoUnitariaTests.Create('TestarCadastrarMovUnitaria',
      'TestarPublicarProcesso'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Configuração / Por Consulta de Período',
      TffpgConfigIntimaAdvTests.Create('TestarConfigIntimaAdv',
      'TestarPublicarProcesso', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '/ Configuração / Por Consulta de Processo',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Configuração / Por Consulta de Processo',
      TffpgCadMovimentacaoUnitariaTests.Create('TestarCadastrarMovUnitaria',
      'TestarPublicarProcesso'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Configuração / Por Consulta de Processo',
      TffpgConfigIntimaAdvTests.Create('TestarConfigIntimaAdv', 'TestarConfigPublicaProcesso'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Configuração / Por Consulta de Processo',
      TffpgConsRelacaoTodasTests.Create('TestarConsRelacaoTodas',
      'TestarConsRelacaoTodasPorProcesso', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certidão de Publicação',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certidão de Publicação',
      TffpgCadMovimentacaoUnitariaTests.Create('TestarCadastrarMovUnitaria',
      'TestarPublicarProcesso'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certidão de Publicação',
      TffpgConfigIntimaAdvTests.Create('TestarConfigIntimaAdv', 'TestarPublicarProcesso'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certidão de Publicação',
      TffpgCertPubIntimaAdvTests.Create('TestarCertPubIntimaAdv',
      'TestarCertidaoPublicacao', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certidão de Emissão',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certidão de Emissão',
      TffpgCadMovimentacaoUnitariaTests.Create('TestarCadastrarMovUnitaria',
      'TestarPublicarProcesso'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certidão de Emissão',
      TffpgConfigIntimaAdvTests.Create('TestarConfigIntimaAdv',
      'TestarPublicaProcessoSemCertidao'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certidão de Emissão',
      TffpgCertEmiIntimaAdvTests.Create('TestarCertEmiIntimaAdv',
      'TestarCertidaoEmissaoIntimaAdv', 1, True));
  end;
end.


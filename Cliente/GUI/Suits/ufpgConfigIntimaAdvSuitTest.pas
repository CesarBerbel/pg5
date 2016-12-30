unit ufpgConfigIntimaAdvSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgCadMovimentacaoUnitariaTests,
  ufpgConfigIntimaAdvTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgCertPubIntimaAdvTests, ufpgCertEmiIntimaAdvTests, ufpgConsRelacaoTodasTests;

implementation

const
  CS_CAMINHO_TESTE = 'Publica��o / Intima��o de Advogados';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE + '/ Configura��o / Por Consulta de Per�odo',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Configura��o / Por Consulta de Per�odo',
      TffpgCadMovimentacaoUnitariaTests.Create('TestarCadastrarMovUnitaria',
      'TestarPublicarProcesso'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Configura��o / Por Consulta de Per�odo',
      TffpgConfigIntimaAdvTests.Create('TestarConfigIntimaAdv',
      'TestarPublicarProcesso', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '/ Configura��o / Por Consulta de Processo',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Configura��o / Por Consulta de Processo',
      TffpgCadMovimentacaoUnitariaTests.Create('TestarCadastrarMovUnitaria',
      'TestarPublicarProcesso'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Configura��o / Por Consulta de Processo',
      TffpgConfigIntimaAdvTests.Create('TestarConfigIntimaAdv', 'TestarConfigPublicaProcesso'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Configura��o / Por Consulta de Processo',
      TffpgConsRelacaoTodasTests.Create('TestarConsRelacaoTodas',
      'TestarConsRelacaoTodasPorProcesso', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certid�o de Publica��o',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certid�o de Publica��o',
      TffpgCadMovimentacaoUnitariaTests.Create('TestarCadastrarMovUnitaria',
      'TestarPublicarProcesso'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certid�o de Publica��o',
      TffpgConfigIntimaAdvTests.Create('TestarConfigIntimaAdv', 'TestarPublicarProcesso'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certid�o de Publica��o',
      TffpgCertPubIntimaAdvTests.Create('TestarCertPubIntimaAdv',
      'TestarCertidaoPublicacao', 1, True));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certid�o de Emiss�o',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certid�o de Emiss�o',
      TffpgCadMovimentacaoUnitariaTests.Create('TestarCadastrarMovUnitaria',
      'TestarPublicarProcesso'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certid�o de Emiss�o',
      TffpgConfigIntimaAdvTests.Create('TestarConfigIntimaAdv',
      'TestarPublicaProcessoSemCertidao'));

    RegisterTest(CS_CAMINHO_TESTE + '/ Certid�o de Emiss�o',
      TffpgCertEmiIntimaAdvTests.Create('TestarCertEmiIntimaAdv',
      'TestarCertidaoEmissaoIntimaAdv', 1, True));
  end;
end.


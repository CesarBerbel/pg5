unit ufpgRedistribuicaoForoSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgRedistribuicaoForoTests, ufpgRecebRedistForoTests,
  ufpgCancelaRedistForoTests;

const
  CS_CAMINHO_TESTE = 'Redistribui��o para outro foro\';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_CIVIL_GENERICO_DIRECIONADA));

    RegisterTest(CS_CAMINHO_TESTE + ' sem foro preenchido',
      TffpgRedistribuicaoForoTests.Create('TestarRedistribuicaoForo',
      'TestarRedistribuirSemPreencherForo'));

    RegisterTest(CS_CAMINHO_TESTE + ' e cancelamento da redistribui��o',
      TffpgRedistribuicaoForoTests.Create('TestarRedistribuicaoForo', STRING_INDEFINIDO));

    RegisterTest(CS_CAMINHO_TESTE + ' e cancelamento da redistribui��o',
      TffpgCancelaRedistForoTests.Create('TestarCancelarRedistForo', STRING_INDEFINIDO, 1, True));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_CIVIL_GENERICO_DIRECIONADA));

    RegisterTest(CS_CAMINHO_TESTE + ' sem Motivo Preenchido',
      TffpgRedistribuicaoForoTests.Create('TestarRedistribuicaoForo',
      'TestarRedistribuirSemPreencherMotivo'));

    RegisterTest(CS_CAMINHO_TESTE + ' e recebe redistribui��o',
      TffpgRedistribuicaoForoTests.Create('TestarRedistribuicaoForo', ''));

    RegisterTest(CS_CAMINHO_TESTE + ' e recebe redistribui��o',
      TffpgRecebRedistForoTests.Create('TestarRecebRedistForo', STRING_INDEFINIDO, 1, True));
  end;
end.


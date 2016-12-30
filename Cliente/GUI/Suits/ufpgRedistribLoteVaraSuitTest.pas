unit ufpgRedistribLoteVaraSuitTest;

interface

uses
  TestFramework, ufpgRedistribLoteVaraTests, ufpgCadProcessoTests, ufpgConstanteGUITests,
  ufpgVariaveisTestesGUI;

implementation

const
  CS_CAMINHO_TESTE = 'Redistribuição de processo entre vara\';
  CS_COM_SIGILO = 'Com Sigilo';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    //--
    RegisterTest(CS_CAMINHO_TESTE + ' por Sorteio', TffpgCadProcessoTests.Create(
      'TestarCadastroProcesso', CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    RegisterTest(CS_CAMINHO_TESTE + ' por Sorteio',
      TffpgRedistribLoteVaraTests.Create('TestarRedistribuicaoEntreVara',
      'TestarRedistribuicaoEntreVaraSorteio', 1, True));
    //--

    //--
    RegisterTest(CS_CAMINHO_TESTE + ' direcionada', TffpgCadProcessoTests.Create(
      'TestarCadastroProcesso', CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    RegisterTest(CS_CAMINHO_TESTE + ' direcionada',
      TffpgRedistribLoteVaraTests.Create('TestarRedistribuicaoEntreVara',
      'TestarRedistribuicaoEntreVaraDirecionada', 1, True));
    //--

    //--
    RegisterTest(CS_CAMINHO_TESTE + ' por dependência',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso', CS_PROCESSO_PENAL_GENERICO_SORTEIO));

    RegisterTest(CS_CAMINHO_TESTE + ' por dependência',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    RegisterTest(CS_CAMINHO_TESTE + ' por dependência',
      TffpgRedistribLoteVaraTests.Create('TestarRedistribuicaoEntreVara',
      'TestarRedistribuicaoEntreVaraDependencia', 1, True));
    //--

  end
  else
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    //--
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRedistribLoteVaraTests.Create(
      'TestarRedistribuicaoEntreVara', STRING_INDEFINIDO, 1, True));
    //--

    //--
    RegisterTest(CS_CAMINHO_TESTE + CS_COM_SIGILO, TffpgCadProcessoTests.Create(
      'TestarCadastroProcesso', 'ProcessoPenalComSigilo'));

    RegisterTest(CS_CAMINHO_TESTE + CS_COM_SIGILO,
      TffpgRedistribLoteVaraTests.Create('TestarRedistribuicaoEntreVara',
      STRING_INDEFINIDO, 1, True));
    //--
  end;

end.


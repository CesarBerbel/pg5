unit ufpgPrevisoesPenaSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  usajConstante, ufpgCadHistoricoParteTests, ufpgCadPecTests;

implementation

const
  CS_CAMINHO_TESTE = 'Calculo das previsões de pena';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoCriminalDirecionadoSimples'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadHistoricoParteTests.Create('TestarHistoricoPartes',
      'CadastrarHistoricoComRestritiva'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadPecTests.Create('TestarCadastroDoPEC',
      'CadastroPecRestritiva'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadHistoricoParteTests.Create('TestarHistoricoPartes',
      'VisualizarPrevisoesComRestritiva', 1, True));
  end;

end.


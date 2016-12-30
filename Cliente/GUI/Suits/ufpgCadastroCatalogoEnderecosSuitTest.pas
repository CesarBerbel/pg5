unit ufpgCadastroCatalogoEnderecosSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Fazer um cadastro no catálogo de endereços (Cadastro de Processo)';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoSimples', 1, True))
  else if gsCliente = CS_CLIENTE_PG5_TJSP then
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPenalDirecionada', 1, True))
  else
  if gsCliente = CS_CLIENTE_PG5_TJMS then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPenalCatalogoEndereco'));
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastarEntdereco',
      'TestarCadastrarEndereco1_12_10', 1, True));
  end;
end.


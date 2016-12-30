unit ufpgRedistribLoteVagaSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgRedistribLoteVagaTests,
  ufpgCadProcessoTests;

implementation

const
  CS_CAMINHO_TESTE_SORTEIO = 'Redistribuição de processo entre vaga por sorteio';
  CS_CAMINHO_TESTE_DIRECIONADO = 'Redistribuição de processo entre vaga por direcionamento';

var
  ofpgRedistribLoteVagaTestsDirecionada: TffpgRedistribLoteVagaTests;
  ofpgRedistribLoteVagaTestsSorteio: TffpgRedistribLoteVagaTests;

initialization
  RegisterTest(CS_CAMINHO_TESTE_DIRECIONADO, TffpgCadProcessoTests.Create(
    'TestarCadastroProcesso', CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

  ofpgRedistribLoteVagaTestsDirecionada :=
    TffpgRedistribLoteVagaTests.Create('TestarRedistribuicaoEntreVaga',
    'TestarRedistribuicaoEntreVagaDirecionada', 1, True);

  RegisterTest(CS_CAMINHO_TESTE_DIRECIONADO, ofpgRedistribLoteVagaTestsDirecionada);

  if gsCliente <> CS_CLIENTE_PG5_TJMS then
  begin
    RegisterTest(CS_CAMINHO_TESTE_SORTEIO, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    ofpgRedistribLoteVagaTestsSorteio :=
      TffpgRedistribLoteVagaTests.Create('TestarRedistribuicaoEntreVaga',
      'TestarRedistribuicaoEntreVagaSorteio', 1, True);

    RegisterTest(CS_CAMINHO_TESTE_SORTEIO, ofpgRedistribLoteVagaTestsSorteio);
  end;
end.


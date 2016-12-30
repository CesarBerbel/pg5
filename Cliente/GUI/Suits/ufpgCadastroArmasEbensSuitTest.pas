unit ufpgCadastroArmasEbensSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadArmasBensPG5Tests,
  ufpgCadProcessoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastro de Processo - Armas e bens';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'ProcessoPenalGenerico'))
  else
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPenalSorteio'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadArmasBensPG5Tests.Create('TestarCadastroDeArmasEBens',
    'TestarCadastroDeArmas'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadArmasBensPG5Tests.Create('TestarCadastroDeArmasEBens',
    'TestarCadastroDeMunicao'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadArmasBensPG5Tests.Create('TestarCadastroDeArmasEBens',
    'TestarCadastroDeVeiculo'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadArmasBensPG5Tests.Create('TestarCadastroDeArmasEBens',
    'TestarCadastroDeImovel'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadArmasBensPG5Tests.Create('TestarCadastroDeArmasEBens',
    'TestarCadastroDeTtitulo'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadArmasBensPG5Tests.Create('TestarCadastroDeArmasEBens',
    'TestarCadastroDeObjeto', 1, True));

  //  RegisterTest(CS_CAMINHO_TESTE, TffpgCadArmasBensPG5Tests.Create('TestarCadastroDeArmasEBens',
  //    'TestarExcluirArma'));
end.


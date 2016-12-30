unit ufpgCadProcessoDependenteSuitTests;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoDependenteTests,
  ufpgCadProcessoTests, ufpgMaterializaProcessoTests, ufpgExecutarRoteiroPROTests,
  ufpgCadJuntadaPetTests, ufpgCancelJuntadaPetTests, ufpgCadApensamentoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastro de processo dependente\';

initialization
  // 12/08/2016  - Carlos.Gaspar - SALT:
  // Comentado, dando erro build noturno
  //  if gsCliente = CS_CLIENTE_PG5_TJSC then
  //  begin
  //    //Suit substitui o teste TestarPeticaoInicialApensamento
  //    RegisterTest(CS_CAMINHO_TESTE + 'Apensamento', TffpgCadProcessoTests.Create(
  //      'TestarCadastroProcesso', 'TestarApensarProcesso'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Apensamento',
  //      TffpgExecutarRoteiroPROTests.Create('TestarPeticaoInicialApensamento'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Apensamento',
  //      TffpgCadProcessoDependenteTests.Create('TestarCadProcessoDependente',
  //      'TestarPeticaoInicialApensamento', 1, True));

  //    //Suit substitui o teste TestarCadastrarProcessoDependente
  //    RegisterTest(CS_CAMINHO_TESTE + 'Petição intermediária em processo com sigilo absoluto',
  //      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
  //      'TestarCadastrarProcessoDependente '));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Petição intermediária em processo com sigilo absoluto',
  //      TffpgExecutarRoteiroPROTests.Create('TestarPeticaoInicialApensamento'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Petição intermediária em processo com sigilo absoluto',
  //      TffpgCadProcessoDependenteTests.Create('TestarCadProcessoDependente',
  //      'TestarCadastrarProcessoDependente', 1, True));

  //    //Suit substitui o teste TestarJuntarPeticaoIntermediariaFisico_1_1_22_2 e
  //    //TestarCancelamentoDeJuntadaPeticaoIntermediaria_1_1_23
  //    RegisterTest(CS_CAMINHO_TESTE + 'Juntar uma petição intermediária físico',
  //      TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'TestarCadastrarProcessoFisco'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Juntar uma petição intermediária físico',
  //      TffpgMaterializaProcessoTests.Create('TestarMaterializaProcesso', ''));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Juntar uma petição intermediária físico',
  //      TffpgExecutarRoteiroPROTests.Create('TestarJuntarPeticaoIntermediariaFisico_1_1_22_2'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Juntar uma petição intermediária físico',
  //      TffpgCadProcessoDependenteTests.Create('TestarCadProcessoDependente',
  //      'TestarJuntarPeticaoIntermediariaFisico_1_1_22_2'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Juntar uma petição intermediária físico',
  //      TffpgCadJuntadaPetTests.Create('TestarCadastroBasicoJuntadaPet',
  //      'TestarJuntarPeticaoIntermediariaFisico_1_1_22_2'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Juntar uma petição intermediária físico',
  //      TffpgCancelJuntadaPetTests.Create('TestarCancelamentoJuntada',
  //      'TestarCancelamentoDeJuntadaPeticaoIntermediaria_1_1_23', 1, True));

  //    //Suit substitui o teste TestarCadastrarPeticaoProcessoDependente1_1_36
  //    RegisterTest(CS_CAMINHO_TESTE + 'Cadastrar um processo pela tela cadastro de petições',
  //      TffpgExecutarRoteiroPROTests.Create('TestarProtocoloExcepPeticaoInicialGrid'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Cadastrar um processo pela tela cadastro de petições',
  //      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
  //      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Cadastrar um processo pela tela cadastro de petições',
  //      TffpgExecutarRoteiroPROTests.Create('TestarCadastrarPeticaoProcessoDependente1_1_36'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Cadastrar um processo pela tela cadastro de petições',
  //      TffpgCadProcessoDependenteTests.Create('TestarCadProcessoDependente',
  //      'TestarCadastrarPeticaoProcessoDependente1_1_36', 1, True));

  //  end
  //  else
  //  begin
  //    RegisterTest(CS_CAMINHO_TESTE + 'Apensamento', TffpgCadProcessoTests.Create(
  //      'TestarCadastroProcesso', 'CadastroProcessoPenalSorteio'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Apensamento',
  //      TffpgExecutarRoteiroPROTests.Create('TestarPeticaoIntermediaria'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Apensamento',
  //      TffpgCadProcessoDependenteTests.Create('TestarCadProcessoDependente',
  //      'TestarPeticaoInicialApensamento'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Apensamento',
  //      TffpgCadApensamentoTests.Create('TestarApensarProcesso',
  //      'TestarApensarProcessoCadProcDependente', 1, True));

  //    //Juntada
  //    RegisterTest(CS_CAMINHO_TESTE + 'Juntada', TffpgCadProcessoTests.Create(
  //      'TestarCadastroProcesso', 'CadastroProcessoPenalSorteio'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Juntada', TffpgMaterializaProcessoTests.Create(
  //      'TestarMaterializaProcesso', STRING_INDEFINIDO));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Juntada', TffpgExecutarRoteiroPROTests.Create(
  //      'TestarPeticaoIntermediaria'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Juntada', TffpgCadProcessoDependenteTests.Create(
  //      'TestarCadProcessoDependente', 'TestarJuntada'));

  //    RegisterTest(CS_CAMINHO_TESTE + 'Juntada', TffpgCadJuntadaPetTests.Create(
  //      'TestarCadastroBasicoJuntadaPet', 'TestarCadastroJuntadaPetFisico', 1, True));
  //  end;

end.


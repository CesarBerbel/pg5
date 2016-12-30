unit ufpgConsPeticaoIntermEletronicaTests;

interface

uses
  Windows, ADODB, Forms, Classes, SysUtils, TestFramework, FutureWindows,
  ufpgConsPeticaoIntermEletronica, uspDUnitDAO, uspForm, uspInterface,
  ufpgCadProcessoDependente, ufpgGUITestCase, uspFuncoes, uspDataModelTests,
  usajConstante, DB, uspGUITestCase, ufpgFuncoesTestes, ufpgConsPeticaoIntermEletronicaModelTests,
  shellapi, ufpgMenu, ufpgCadProcesso, ufpgConsTipoParte, ufpgResultadoDistribuicao,
  ufpgDadosDistribNormal, ufpgConsProtocolo, ufpgConstanteTests, ufpgDataModelTests;

type
  TffpgConsPeticaoIntermEletronicaTests = class(TfpgGUITestCase)
  private
    procedure CadastrarPeticaoIntermediaria;
    procedure CadastrarPeticao;
    //20/07/2015 - luciano.fagundes - SALT: 186660/8/8
    procedure CadastrarPeticaoIntermediariaTodasCategorias;
    procedure CadastroProcesso;
    procedure ProtolocaProcesso;
    procedure CadastrarPeticaoIntermediariaTodasCategorias2;
    procedure DistribuirProcesso(poTela: TffpgCadProcesso);
    procedure FecharResultadoDistribuicao;
    procedure ConsProtocolo(poTelaCadPeticao: TffpgCadProcessoDependente; psClasse: string);
    procedure PreencherParteProcesso(poTela: TffpgCadProcesso; psTipo: string);
    //--

  public
    FoTela: TffpgConsPeticaoIntermEletronica;
    FoDados: TffpgConsPeticaoIntermEletronicaModelTests;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadastrarPeticaoIntermediaria;
    //20/07/2015 - luciano.fagundes - SALT: 186660/8/8
    procedure TestarCadastrarPetTodasCategorias;
  end;

implementation

uses
  ufpgVariaveisTestes;

var
  gsClasse: string;
  gsNuProtocolo: string;
  bTestePro2: boolean;

const
  CS_ATIVO = 'A';
  CS_PASSIVO = 'P';
  CS_AUTOR = 'Autor ';
  CS_REU = 'Reu ';


{ TFproConsPeticaoIntermEletronicaTests }

procedure TffpgConsPeticaoIntermEletronicaTests.CadastrarPeticaoIntermediaria;
var
  bProcessoNaoCancelado: boolean;
begin
  AbrirTela;
  FoTela := TffpgConsPeticaoIntermEletronica(spTela);
  FoDados := TffpgConsPeticaoIntermEletronicaModelTests(spDataModelTests);

  repeat
    FoTela.ccCadastro.Execute(acConsultar);
    application.ProcessMessages;
    sleep(500);
    application.ProcessMessages;

    FoTela.ccCadastro.Execute(acConsultar);
  until FoTela.grPeticoes.DataSource.DataSet <> nil;

  bProcessoNaoCancelado := True;
  FoTela.grPeticoes.DataSource.DataSet.First;

  while (not FoTela.grPeticoes.DataSource.DataSet.EOF) and bProcessoNaoCancelado do
  begin
    gsNuProcesso := SomenteNumeros(FoTela.grPeticoes.DataSource.DataSet.fields[2].AsString);
    gsNuProtocolo := FoTela.grPeticoes.DataSource.DataSet.fields[3].AsString;
    bProcessoNaoCancelado := FoDados.VerificarProcessoCancelado(gsNuProcesso);
    FoTela.grPeticoes.DataSource.DataSet.Next;
    sleep(500);
    application.ProcessMessages;
  end;


  TFutureWindows.Expect('TfsajAssistente').ExecCloseWindow;
  FoTela.pbCadastrar.Click;
  CadastrarPeticao;


  check(FoDados.VerificarPeticaoCadastrada(gsNuProcesso, gsClasse),
    'A Petição Intermediária não foi cadastrada');
end;

function TffpgConsPeticaoIntermEletronicaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgConsPeticaoIntermEletronicaModelTests;
end;

procedure TffpgConsPeticaoIntermEletronicaTests.CadastrarPeticao;
var
  oTelaProcDependente: TffpgCadProcessoDependente;
begin
  oTelaProcDependente := PegarTela('ffpgCadProcessoDependente') as TffpgCadProcessoDependente;
  if Assigned(oTelaProcDependente) then
  begin
    if oTelaProcDependente.dfnuProcesso.FdfNumeroProcessoExterno.PegaTexto = '' then
      EnterTextInto(oTelaProcDependente.dfnuProcesso.FdfNumeroProcessoExterno,
        gsNuProcesso, False);
    if oTelaProcDependente.dfnuProtocolo.PegaTexto = '' then
      EnterTextInto(oTelaProcDependente.dfnuProtocolo, gsNuProtocolo, False);
    if oTelaProcDependente.csClasse.PegaTexto = '' then
      EnterTextInto(oTelaProcDependente.csClasse.dfCodigo, FoDados.fpgClasse);
    gsClasse := oTelaProcDependente.csClasse.PegaTexto;
    CheckCampoPreenchido(oTelaProcDependente.csClasse.dfDescricao, FoDados);
    oTelaProcDependente.ccCadastro.Execute(acSalvar);
  end;
end;

procedure TffpgConsPeticaoIntermEletronicaTests.TestarCadastrarPeticaoIntermediaria;
begin
  ExecutarRoteiroTestes(CadastrarPeticaoIntermediaria);
end;

//20/07/2015 - luciano.fagundes - SALT: 186660/8/8
procedure TffpgConsPeticaoIntermEletronicaTests.TestarCadastrarPetTodasCategorias;
begin
  ExecutarRoteiroTestes(CadastrarPeticaoIntermediariaTodasCategorias);
end;

//20/07/2015 - luciano.fagundes - SALT: 186660/8/8
procedure TffpgConsPeticaoIntermEletronicaTests.CadastrarPeticaoIntermediariaTodasCategorias;
begin
  AbrirTela;
  FoTela := TffpgConsPeticaoIntermEletronica(spTela);
  FoDados := TffpgConsPeticaoIntermEletronicaModelTests(spDataModelTests);

  bTestePro2 := False;

  TFutureWindows.Expect('TfsajAssistente').ExecCloseWindow;

  ProtolocaProcesso;

  gsNuProcesso := LerVariavelExterna(CS_NUPROTOCOLO);

  CadastroProcesso;

  bTestePro2 := True;

  ProtolocaProcesso;

  CadastrarPeticaoIntermediariaTodasCategorias2;

  check(FoDados.VerificarPeticaoIntermediaria(gsNuProcesso),
    'Petição Intermediária não cadastrada');

end;

//20/07/2015 - luciano.fagundes - SALT: 186660/8/8
procedure TffpgConsPeticaoIntermEletronicaTests.CadastrarPeticaoIntermediariaTodasCategorias2;
var
  oTelaCadPeticao: TffpgCadProcessoDependente;
begin
  ffpgMenu.imffpgCadProcessoDependente.Click;
  oTelaCadPeticao := TffpgCadProcessoDependente(PegarTela('ffpgCadProcessoDependente'));

  TFutureWindows.Expect('TfsajAssistente').ExecCloseWindow;

  EnterTextInto(oTelaCadPeticao.dfNuProcesso.FdfNumeroProcessoExterno, gsNuProcesso);

  ConsProtocolo(oTelaCadPeticao, FoDados.fpgClasse1);
  ConsProtocolo(oTelaCadPeticao, FoDados.fpgClasse2);
  ConsProtocolo(oTelaCadPeticao, FoDados.fpgClasse3);
  ConsProtocolo(oTelaCadPeticao, FoDados.fpgClasse4);
  ConsProtocolo(oTelaCadPeticao, FoDados.fpgClasse5);

  oTelaCadPeticao.ccCadastro.Execute(acFecharForm);

end;

//20/07/2015 - luciano.fagundes - SALT: 186660/8/8
procedure TffpgConsPeticaoIntermEletronicaTests.ConsProtocolo(
  poTelaCadPeticao: TffpgCadProcessoDependente; psClasse: string);
var
  oTelaConsProtocolo: TffpgConsProtocolo;
begin
  TFutureWindows.Expect('TfsajAssistente').ExecCloseWindow;
  poTelaCadPeticao.tvProcDependente.TopItem.Selected := True;
  poTelaCadPeticao.ccCadastro.Execute(acNovo);
  oTelaConsprotocolo := TffpgConsProtocolo(PegarTela('ffpgConsProtocolo', False, 500));
  if Assigned(oTelaConsprotocolo) then
    oTelaConsProtocolo.ccCadastro.Execute(acSelecionar);
  if poTelaCadPeticao.csClasse.PegaTexto = STRING_INDEFINIDO then
    EnterTextInto(poTelaCadPeticao.csClasse.dfCodigo, psClasse);
  poTelaCadPeticao.ccCadastro.Execute(acSalvar);
end;

//20/07/2015 - luciano.fagundes - SALT: 186660/8/8
procedure TffpgConsPeticaoIntermEletronicaTests.CadastroProcesso;
var
  oTelaCadastroProcesso: TffpgCadProcesso;
begin
  ffpgMenu.imffpgCadProcesso.Click;
  oTelaCadastroProcesso := TffpgCadProcesso(PegarTela('ffpgCadProcesso'));

  spVerificadorTelas.RegistrarMensagem(
    'A GRJ não foi informada. Deseja salvar o processo assim mesmo?', '&Sim');

  EnterTextInto(oTelaCadastroProcesso.dfNuProcesso.FdfNumeroProcessoExterno,
    copy(gsNuProcesso, 1, 13), False);
  GravarVariavelExterna(CS_NUPROCESSO, gsNuProcesso);
  EnterTextInto(oTelaCadastroProcesso.csCompetencia.dfCdTipoCartorio, FoDados.fpgCompetencia);
  EnterTextInto(oTelaCadastroProcesso.csClasse.dfCodigo, FoDados.fpgClasse);
  EnterTextInto(oTelaCadastroProcesso.csAssuntoForm.dfCodigo, FoDados.fpgAssunto);

  PreencherParteProcesso(oTelaCadastroProcesso, CS_ATIVO);
  PreencherParteProcesso(oTelaCadastroProcesso, CS_PASSIVO);

  oTelaCadastroProcesso.ccCadastro.Execute(acSalvar);

  DistribuirProcesso(oTelaCadastroProcesso);

  oTelaCadastroProcesso.Close;
end;

procedure TffpgConsPeticaoIntermEletronicaTests.PreencherParteProcesso(poTela: TffpgCadProcesso;
  psTipo: string);
var
  sNuDoc, stexto: string;
begin
  poTela.pcCadProcesso.ActivePage := poTela.tsParticipacao;
  poTela.pcCadProcessoChange(poTela.pcCadProcesso);

  if UpperCase(psTipo) = 'A' then
  begin
    poTela.fpgProcessoParte.pbNovaParteAtiva.Click;
    sTexto := CS_AUTOR;
  end
  else
  if UpperCase(psTipo) = 'P' then
  begin
    poTela.fpgProcessoParte.pbNovaPartePassiva.Click;
    sTexto := CS_REU;
  end;

  sTexto := sTexto + poTela.dfNuProcesso.FdfNumeroProcessoExterno.PegaTexto;

  sNuDoc := RetornaCPFValido;
  EnterTextInto(poTela.fpgProcessoParte.dfCPF, sNuDoc, False);

  EnterTextInto(poTela.fpgProcessoParte.dfnmPessoa, sTexto, False);
  poTela.fpgProcessoParte.OnExitCampoNomeParte(poTela);

  EnterTextInto(poTela.fpgProcessoParte.sajEndereco.dfCEP, FoDados.fpgCEP, False);
  EnterTextInto(poTela.fpgProcessoParte.sajEndereco.dfNumero, IntToStr(Random(999)));
end;

//20/07/2015 - luciano.fagundes - SALT: 186660/8/8
procedure TffpgConsPeticaoIntermEletronicaTests.DistribuirProcesso(poTela: TffpgCadProcesso);
begin
  //spVerificadorTelas.RegistrarMensagem(
  //  'A GRJ não foi informada. Deseja salvar o processo assim mesmo?', '&Sim');
  poTela.pcCadProcesso.ActivePage := poTela.tsDadosProcessuais;
  poTela.pbDistribuiProcesso.Click;
  FecharResultadoDistribuicao;
  Application.ProcessMessages;
end;

//20/07/2015 - luciano.fagundes - SALT: 186660/8/8
procedure TffpgConsPeticaoIntermEletronicaTests.FecharResultadoDistribuicao;
var
  oTelaResultadoDistribuicao: TffpgResultadoDistribuicao;
begin
  oTelaResultadoDistribuicao := TffpgResultadoDistribuicao(PegarTela('ffpgResultadoDistribuicao'));
  CheckNotNull(oTelaResultadoDistribuicao, 'Não achou a tela ffpgResultadoDistribuicao');
  oTelaResultadoDistribuicao.ccCadastro.Execute(acFecharForm);
  Application.ProcessMessages;
end;

//20/07/2015 - luciano.fagundes - SALT: 186660/8/8
procedure TffpgConsPeticaoIntermEletronicaTests.ProtolocaProcesso;
begin
  // 16/09/2015  - Carlos.Gaspar - SALT: 156660/15/10
  //  if AppPROEhLocal('PRO') then
  //    ShellExecute(handle, 'open', PChar('TrocaSistema.exe'), 'PRO', '', SW_HIDE);
  if not bTestePro2 then
  begin
    ExecutarEAguardar('C:\SAJ\PG5\Clientes\SAJPRO\' + 'ProAppTests.exe' +
      ' CriarRepositorioProtocolo', False);
  end
  else
  begin
    ExecutarEAguardar('C:\SAJ\PG5\Clientes\SAJPRO\' + 'ProAppTests.exe' +
      ' TestarPeticaoIntermediaria', False);
  end;
  //  if AppPROEhLocal('PRO') then
  //    ShellExecute(handle, 'open', PChar('TrocaSistema.exe'), 'PG', '', SW_HIDE);
end;

end.


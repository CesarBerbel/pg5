//29/04/2016 - Shirleano.Junior - Task: 43061
// Refatorado.
unit ufpgEnvioRecursoEletronicoTests;

interface

uses
  ufpgGUITestCase, ufpgEnvioRecursoEletronicoModelTests, ufpgDataModelTests,
  ufpgEnvioRecursoEletronico;

type
  TffpgEnvioRecursoEletronicoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgEnvioRecursoEletronico;
    FoDados: TffpgEnvioRecursoEletronicoModelTests;
    procedure EnvioRecursosEletronicos;
    procedure PreencherDados;
    procedure EnviarRecurso;
    procedure SelecionarPartes;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarEnvioRecursosEletronicos;
  end;

implementation

{ TfpgEnvioRecursoEletronicoTests }

uses
  usajConstante, Forms, Classes, SysUtils, TestFramework, uspInterface, DB,
  uspSendKeys, ufpgConstanteGUITests, ufpgFuncoesGUITestes,
  ufpgSelecaoPartesEnvioRecursoEletronico;

function TffpgEnvioRecursoEletronicoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgEnvioRecursoEletronicoModelTests;
end;

procedure TffpgEnvioRecursoEletronicoTests.EnvioRecursosEletronicos;
begin
  AbrirTela;
  FoTela := TffpgEnvioRecursoEletronico(spTela);
  FoDados := (Self.spDataModelTests) as TffpgEnvioRecursoEletronicoModelTests;

  EnviarRecurso;

  FecharTela;
  Check(FoDados.VerificarSitProcesso('G', FoDados.fpgnuprocesso), 'O processo nº ' +
    FoDados.fpgNuProcesso + ' não foi enviado para o 2º grau.');
end;

procedure TffpgEnvioRecursoEletronicoTests.TestarEnvioRecursosEletronicos;
begin
  ExecutarRoteiroTestes(EnvioRecursosEletronicos);
end;

procedure TffpgEnvioRecursoEletronicoTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  EnterTextInto(FoTela.csClasse.dfCodigo, FoDados.fpgCdClasse);
  EnterTextInto(FoTela.csAssuntosSG.dfCodigo, FoDados.fpgCdAssuntoSG);
  EnterTextInto(FoTela.csJuiz.dfcdAgente, FoDados.fpgCdJuiz);
end;

procedure TffpgEnvioRecursoEletronicoTests.EnviarRecurso;
begin
  PreencherDados;
  FoTela.pbAdicionarParte.Click;
  SelecionarPartes;
  //  spVerificadorTelas.RegistrarMensagem('Foram realizadas alterações*', 'Sim');
  spVerificadorTelas.RegistrarMensagem(
    'O envio do recurso eletrônico foi concluído com sucesso.', 'OK');
  FoTela.ccCadastro.Execute(acSalvar);
  FoTela.pbEnviar.Click;
end;

procedure TffpgEnvioRecursoEletronicoTests.SelecionarPartes;
var
  oTelaSelecao: TffpgSelecaoPartesEnvioRecursoEletronico;
  sTipo: string;
begin
  oTelaSelecao := PegarTela('ffpgSelecaoPartesEnvioRecursoEletronico') as
    TffpgSelecaoPartesEnvioRecursoEletronico;
  oTelaSelecao.esajParte.First;
  while not oTelaSelecao.esajParte.EOF do
  begin
    if oTelaSelecao.esajParte.FieldByName('CC_FLSELECIONAR').AsString <> 'S' then
    begin
      EnviarTeclas(oTelaSelecao.tlParticipacao, '({HOME} )');

      if Pos(CS_AUTOR, oTelaSelecao.esajParte.FieldByName('nmPessoa').AsString) > 0 then
        sTipo := FoDados.fpgTipoParticipacaoAutor;

      if Pos(CS_REU, oTelaSelecao.esajParte.FieldByName('nmPessoa').AsString) > 0 then
        sTipo := FoDados.fpgTipoParticipacaoReu;

      EnviarTeclas(oTelaSelecao.tlParticipacao, sTipo);
      EnviarTeclas(oTelaSelecao.tlParticipacao, '({ENTER})');

      if oTelaSelecao.esajParte.State in dsEditModes then
        oTelaSelecao.esajParte.Post;
    end;
    oTelaSelecao.esajParte.Next;
  end;
  oTelaSelecao.ccCadastro.Execute(acSelecionar);
end;

end.


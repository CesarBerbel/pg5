//28/04/2016 - Shirleano.Junior - Task: 43059
//Refatorado.
unit ufpgCadContatoTests;

interface

uses
  TestFramework, ufpgGUITestCase, ufpgCadContatoModelTests, ufpgCadContato, ufpgDataModelTests;

type
  TffpgCadContatoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadContato;
    FoDados: TffpgCadContatoModelTests;
    procedure PreencherCadastroBasicoContato;
    procedure PreencherDados;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarCadastroBasicoContato;
  end;

implementation

uses
  Forms, SysUtils, uspInterface, usajConstante, ufpgFuncoesGUITestes, Windows;

var
  nNuCPF: string;

procedure TffpgCadContatoTests.PreencherCadastroBasicoContato;
var
  bContatoCadastrado: boolean;
begin
  AbrirTela;
  FoTela := TffpgCadContato(spTela);
  FoDados := TffpgCadContatoModelTests(spDataModelTests);

  FoTela.ccPai.Execute(acNovo);

  PreencherDados;

  FoTela.ccPai.Execute(acSalvar);

  bContatoCadastrado := FoDados.RetornaContato(nNuCPF);
  checkTrue(bContatoCadastrado, 'Ocorreu erro na gravação do Cadastro');
end;

function TffpgCadContatoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadContatoModelTests;
end;

procedure TffpgCadContatoTests.TestarCadastroBasicoContato;
begin
  ExecutarRoteiroTestes(PreencherCadastroBasicoContato);
end;

procedure TffpgCadContatoTests.PreencherDados;
var
  nTentativas: integer;
begin
  FoDados.fpgNomePessoa := FoDados.fpgNomePessoa + ' ' + IntToStr(Random(High(integer)));
  EnterTextInto(FoTela.dfnmPessoa, FoDados.fpgNomePessoa);

  if FoDados.fpgTemCPF then
  begin
    nNuCPF := RetornaCPFValido;
    EnterTextInto(FoTela.dfCPF, nNuCPF);
  end;
  SelecionarAba(FoTela.pcDadosPessoa, FoTela.tsEnderecos);

  EnterTextInto(FoTela.sajEndereco.dfCEP, FoDados.fpgCEP);
  tab;

  nTentativas := 0;
  while (FoTela.sajEndereco.dfdeLogradouro.PegaTexto = STRING_INDEFINIDO) and (nTentativas < 10) do
  begin
    application.ProcessMessages;
    Inc(nTentativas);
    sleep(500);
  end;
end;


procedure TffpgCadContatoTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.


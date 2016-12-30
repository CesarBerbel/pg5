unit ufpgCadPessoaTests;

interface

uses
  ufpgCadPessoa, ufpgGUITestCase, ufpgCadPessoaModelTests, ufpgDataModelTests;

type
  TffpgCadPessoaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadPessoa;
    FoDados: TffpgCadPessoaModelTests;
    procedure PreencherCadastroBasicoPessoas;
    procedure AlterarDadosCadastroPessoa;
    procedure PreencherDadosPesquisa;
    procedure PreencherDadosAlteracaoCadastro;
    procedure ReverterAlteracoes;
    procedure VerificarAlteracaoDadosPessoa;
    procedure CadastrarPessoa;
    procedure GerarPessoa;
    procedure VerificarFuncSegAlteracao;
    function PreencheFormaPagamento(iTamanho: integer): string;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;

  published
    procedure TestarCadastrarPessoa;
    procedure TestarCadastroControlado;
    procedure TestarAlterarPessoa;
    procedure TestarPesquisarPessoa;
  end;

implementation

uses
  Windows, Forms, uspInterface, SysUtils, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgFuncoesGUITestes;

function TffpgCadPessoaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadPessoaModelTests;
end;

procedure TffpgCadPessoaTests.TestarCadastrarPessoa;
begin
  ExecutarRoteiroTestes(CadastrarPessoa);
end;

procedure TffpgCadPessoaTests.CadastrarPessoa;
begin
  FoDados := TffpgCadPessoaModelTests(spDataModelTests);

  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgCadPessoa');

  FoTela := TffpgCadPessoa(spTela);

  if FoDados.fpgCadastraPessoa then
    PreencherCadastroBasicoPessoas;

  if FoDados.fpgAlteraDadosPessoas then
    AlterarDadosCadastroPessoa;
end;

procedure TffpgCadPessoaTests.PreencherCadastroBasicoPessoas;
var
  sCPFPessoa: string;
begin

  FoTela.ccPai.Execute(acNovo);

  gsCdPessoa := FoTela.dfcdPessoa.AsString;

  if FoDados.fpgGerarPessoa then
  begin
    GerarPessoa;
    GravarVariavelExterna(CS_NOME_PARTE, FoDados.fpgNomePessoa);
  end;

  EnterTextInto(FoTela.dfnmPessoa, FoDados.fpgNomePessoa);

  if FoDados.fpgFormaPgto then
  begin
    gsTextoCadPessoaControlado := PreencheFormaPagamento(200);
    FoTela.dfdeInfoPgto.spMemo.DefineTexto(gsTextoCadPessoaControlado);
  end;

  if FoDados.fpgTemOAB then
    EnterTextInto(FoTela.sajOAB, FoDados.GerarNumeroOAB);

  if FoDados.fpgTemCPF then
  begin
    EnterTextInto(FoTela.dfCPF, FoDados.GerarNumeroCPF);
    sCPFPessoa := FoTela.dfCPF.AsString;
    GravarVariavelExterna(CS_CPF, sCPFPessoa);
  end;


  if FoDados.fpgTemCNPJ then
  begin
    EnterTextInto(FoTela.cbTipoPessoa, 'Jur�dica');
    tab;
    Sleep(2);
    Application.ProcessMessages;
    EnterTextInto(FoTela.dfCNPJ, RetornaCNPJValido);
  end;

  if FoDados.fpgTemEndereco then
  begin
    EnterTextInto(FoTela.sajEnderecoPrincipal.dfCEP, FoDados.fpgCEP);
    EnterTextInto(FoTela.sajEnderecoPrincipal.dfdeLogradouro, FoDados.fpgLogradouro);
    EnterTextInto(FoTela.sajEnderecoPrincipal.dfNumero, FoDados.fpgNumero);
    EnterTextInto(FoTela.sajEnderecoPrincipal.dfdeBairro, FoDados.fpgBairro);
  end;

  FoTela.ccPai.Execute(acSalvar);

  Check(FoDados.VerificaCadastroPessoa(FoDados.fpgNomePessoa, sCPFPessoa),
    'Cadastro Pessoa n�o persistiu no banco');
end;

{ Data de Cria��o:  02/07/2015  Respons�vel: Shirleano.Junior  Salt: 186660/6/5}
procedure TffpgCadPessoaTests.AlterarDadosCadastroPessoa;
begin

  PreencherDadosPesquisa;

  if FoDados.fpgVerificarFuncSegAlteracao then
  begin
    VerificarFuncSegAlteracao;
    exit;
  end;

  if FoDados.fpgSomentePesquisa then
  begin
    Check((FoTela.dfcdPessoa.AsString = gsCdPessoa), 'N�o foi poss�vel encontrar a pessoa: ' +
      gsCdPessoa);
    Exit;
  end;

  PreencherDadosAlteracaoCadastro;

  FoTela.ccPai.Execute(acSalvar);
  VerificarAlteracaoDadosPessoa;
  ReverterAlteracoes;
end;

procedure TffpgCadPessoaTests.PreencherDadosPesquisa;
begin
  if FoDados.fpgCdPessoa = STRING_INDEFINIDO then
    FoDados.fpgCdPessoa := gsCdPessoa;

  EnterTextInto(FoTela.dfCdPessoaCons, FoDados.fpgCdPessoa);
  Tab;
  FoTela.pbPesquisar.Click;
end;

procedure TffpgCadPessoaTests.PreencherDadosAlteracaoCadastro;
begin
  if FoDados.fpgNomePessoaAlterado <> '' then
    EnterTextInto(FoTela.dfnmPessoa, FoDados.fpgNomePessoaAlterado + ' ' +
      IntToStr(Random(999999)));
  if FoDados.fpgOrgaoExpedidor <> '' then
    EnterTextInto(FoTela.dfOrgaoExpedRG, FoDados.fpgOrgaoExpedidor);
  if FoDados.fpgForaUso then
  begin
    EnterTextCheckBox(FoTela.ckflForaUso, FoDados.fpgForaUso);
    GravarVariavelExterna(CS_CPF, FoTela.dfCPF.AsString);
  end;
  Application.ProcessMessages;
end;

procedure TffpgCadPessoaTests.ReverterAlteracoes;
begin
  PreencherDadosPesquisa;
  EnterTextInto(FoTela.dfnmPessoa, FoDados.fpgNomePessoa);
  EnterTextInto(FoTela.dfOrgaoExpedRG, '');
  FoTela.ccPai.Execute(acSalvar);
end;

procedure TffpgCadPessoaTests.VerificarAlteracaoDadosPessoa;
var
  sNomePessoa: string;
  sOrgaoExp: string;
begin
  if FoDados.fpgNomePessoaAlterado <> '' then
    sNomePessoa := FoTela.dfnmPessoa.Text;
  if FoDados.fpgOrgaoExpedidor <> '' then
    sOrgaoExp := FoTela.dfOrgaoExpedRG.Text;
  if (sNomePessoa <> '') and (sOrgaoExp <> '') then
    Check(FoDados.VerificaAlteracaoDadosPessoas(sNomePessoa, sOrgaoExp),
      'Os dados n�o foram alterados.');
  if FoDados.fpgForaUso then
    Check(FoTela.ckflForaUso.Checked, 'A altera��o de fora uso n�o foi realizada.');
end;


procedure TffpgCadPessoaTests.TestarAlterarPessoa;
begin
  ExecutarRoteiroTestes(CadastrarPessoa);
end;

procedure TffpgCadPessoaTests.TestarPesquisarPessoa;
begin
  ExecutarRoteiroTestes(CadastrarPessoa);
end;

procedure TffpgCadPessoaTests.GerarPessoa;
begin
  FoDados.fpgNomePessoa := FoDados.fpgNomePessoa + ' ' + IntToStr(Random(High(integer)));
end;

procedure TffpgCadPessoaTests.TestarCadastroControlado;
begin
  ExecutarRoteiroTestes(CadastrarPessoa);
end;

function TffpgCadPessoaTests.PreencheFormaPagamento(iTamanho: integer): string;
begin
  result := GerarTextoAleatorio(iTamanho, True, True, False);
end;

procedure TffpgCadPessoaTests.VerificarFuncSegAlteracao;
var
  bErro: boolean;
begin
  bErro := FoTela.ckFlForaUso.ReadOnly <> FoDados.UsuarioPossuiFuncSeg(spUsuario);

  Check(bErro, 'O sistema esta permitindo um usu�rio sem permiss�o alterar o cadastro');
end;

procedure TffpgCadPessoaTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.


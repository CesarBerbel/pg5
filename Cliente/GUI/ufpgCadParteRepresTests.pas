unit ufpgCadParteRepresTests;

interface

uses
  ufpgCadParteRepres, ufpgGUITestCase, ufpgCadParteRepresModelTests,
  ufpgDataModelTests, uspSendKeys;

type
  TffpgCadParteRepresTests = class(TfpgGUITestCase)
    procedure CadastroPartesRepresentantes;
    procedure PreencherDados;
    procedure VerificarParteProcesso;
    procedure ExcluirParte;
  public
    FoTela: TffpgCadParteRepres;
    FoDados: TffpgCadParteRepresModelTests;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadastroPartesRepresentantes;
  end;

implementation

uses
  TestFrameWork, uspInterface, Forms, ufpgFuncoesGUITestes, usajConstante, ufpgVariaveisTestesGUI;

{ TffpgCadParteRepresTests }

procedure TffpgCadParteRepresTests.CadastroPartesRepresentantes;
var
  sNuPessoa: string;
begin
  AbrirTela;
  FoTela := TffpgCadParteRepres(spTela);
  FoDados := TffpgCadParteRepresModelTests(spDataModelTests);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  if FoDados.fpgVerificarParteProcesso then
  begin
    VerificarParteProcesso;
    exit;
  end;

  FoTela.fpgProcessoParte.pbNovaParteAtiva.Click;

  PreencherDados;

  sNuPessoa := FoTela.fpgProcessoParte.dfcdPessoa.Text;

  FoTela.ccCadastro.Execute(acSalvar);

  check(FoDados.VerificarCadastroParte(FoDados.fpgNuProcesso, sNuPessoa),
    'A parte não foi cadastrada na tabela');

  if FoDados.fpgExcluirParte then
    ExcluirParte;

  FecharTela;
end;


function TffpgCadParteRepresTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadParteRepresModelTests;
end;

procedure TffpgCadParteRepresTests.PreencherDados;
var
  sNuCPF: string;
begin
  sNuCPF := RetornaCPFValido;
  EnterTextInto(FoTela.fpgProcessoParte.dfCPF, sNuCPF);
  EnterTextInto(FoTela.fpgProcessoParte.dfnmPessoa, FoDados.fpgNomeParte);
  EnterTextInto(FoTela.fpgProcessoParte.sajEndereco.dfCEP, FoDados.fpgCEP);
  EnterTextInto(FoTela.fpgProcessoParte.sajEndereco.dfNumero, FoDados.fpgNumero);
end;

procedure TffpgCadParteRepresTests.TestarCadastroPartesRepresentantes;
begin
  ExecutarRoteiroTestes(CadastroPartesRepresentantes);
end;

procedure TffpgCadParteRepresTests.VerificarParteProcesso;
begin
  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, gsProcessoDesmembrado);

  //  if FoTela.dfNuProcesso.FdfNumeroProcessoExterno.AsString <> '' then
  //    FoTela.ccCadastro.Execute(acLimpar);

  //  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, usarProcessoArray);

  check(gsNomeParte <> STRING_INDEFINIDO, 'Nome da pessoa não localizado');
  check((FoTela.fpgProcessoParte.dfnmPessoa.AsString = gsNomeParte), 'A parte ' +
    gsNomeParte + ' não correspende a desmembrada');
  FecharTela;
end;

procedure TffpgCadParteRepresTests.ExcluirParte;
var
  nParte: integer;
  nParteExcluida: integer;
begin
  spVerificadorTelas.RegistrarMensagem('Confirmar a exclusão da parte?*', 'Sim');
  nParte := FoTela.fpgProcessoParte.tvProcessoParte.Items.Count;

  // 12/09/2016 - RAPHAEL.WHITLOCK - Index inicializa em '0' tendo que subtrair do count.
  FoTela.fpgProcessoParte.tvProcessoParte.Items.Delete(
    FoTela.fpgProcessoParte.tvProcessoParte.Items[nParte - 1]);
  //  EnviarTeclas(FoTela.fpgProcessoParte.tvProcessoParte, '({end})');
  FoTela.fpgProcessoParte.pbExcluiParte.Click;
  FoTela.ccCadastro.Execute(acSalvar);
  nParteExcluida := FoTela.fpgProcessoParte.tvProcessoParte.Items.Count;
  check(nParte > nParteExcluida, 'A parte não foi excluida.');
end;

end.


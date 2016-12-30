unit ufpgVirtualizarProcessoTests;

interface

uses
  ufpgGUITestCase, ufpgVirtualizarProcessoModelTests, ufpgVirtualizarProcesso, ufpgDataModelTests;

type
  TffpgVirtualizarProcessoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgVirtualizarProcesso;
    FoDados: TffpgVirtualizarProcessoModelTests;
    procedure VirtualizarProcesso;
    procedure ConfirmarVirtualuizacao;
    procedure PreencherDados;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarVirtualizarProcesso;
  end;

implementation

uses
  TestFramework, uspInterface, ufpgConfirmacao, ufpgFuncoesGUITestes, usajConstante,
  ufpgVariaveisTestesGUI;

{ TffpgVirtualizarProcessoTests }

function TffpgVirtualizarProcessoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgVirtualizarProcessoModelTests;
end;

procedure TffpgVirtualizarProcessoTests.TestarVirtualizarProcesso;
begin
  ExecutarRoteiroTestes(VirtualizarProcesso);
end;

procedure TffpgVirtualizarProcessoTests.VirtualizarProcesso;
begin
  AbrirTela;
  FoTela := TffpgVirtualizarProcesso(spTela);
  FoDados := TffpgVirtualizarProcessoModelTests(spDataModelTests);

  spVerificadorTelas.RegistrarMensagem('Operação realizada com sucesso.', 'OK');

  PreencherDados;
  FoTela.ccCadastro.Execute(acSalvar);
  ConfirmarVirtualuizacao;

  FecharTela;
  check(FoDados.VerificarProcesso(gsCDProcesso), 'O Processo não foi virtualizado');
end;

procedure TffpgVirtualizarProcessoTests.ConfirmarVirtualuizacao;
var
  oTelaConfirmacao: TffpgConfirmacao;
begin
  oTelaConfirmacao := PegarTela('ffpgConfirmacao') as TffpgConfirmacao;
  EnterTextInto(oTelaConfirmacao.dfedSenha, spSenha);
  oTelaConfirmacao.ccCadastro.Execute(acSelecionar);
end;

procedure TffpgVirtualizarProcessoTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
end;

end.


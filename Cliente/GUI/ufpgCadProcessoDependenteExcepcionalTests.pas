unit ufpgCadProcessoDependenteExcepcionalTests;

interface

uses
  ufpgGUITestCase, ufpgDataModelTests, ufpgCadProcessoDependenteExcepcional,
  ufpgCadProcessoDependenteExcepcionalModelTests;

type
  TffpgCadProcessoDependenteExcepcionalTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadProcessoDependenteExcepcional;
    FoDados: TffpgCadProcessoDependenteExcepcionalModelTests;
    procedure CadastrarProcessoExcepcional;
    procedure PreencherDados;
  protected
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadProcessoDependenteExcepcional;
  end;

implementation

uses
  TestFrameWork, uspInterface, usajConstante, ufpgFuncoesGUITestes, ufpgVariaveisTestesGUI;

function TffpgCadProcessoDependenteExcepcionalTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadProcessoDependenteExcepcionalModelTests;
end;

procedure TffpgCadProcessoDependenteExcepcionalTests.TestarCadProcessoDependenteExcepcional;
begin
  ExecutarRoteiroTestes(CadastrarProcessoExcepcional);
end;

procedure TffpgCadProcessoDependenteExcepcionalTests.CadastrarProcessoExcepcional;
begin
  AbrirTela;
  FoTela := TffpgCadProcessoDependenteExcepcional(spTela);
  FoDados := TffpgCadProcessoDependenteExcepcionalModelTests(spDataModelTests);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado.');

  PreencherDados;
end;

procedure TffpgCadProcessoDependenteExcepcionalTests.PreencherDados;
begin
  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  FoTela.ccCadastro.Execute(acNovo);
  spVerificadorTelas.RegistrarMensagem('Este processo dependente*', 'Sim');
  EnterTextInto(FoTela.csClasse.dfCodigo, FoDados.fpgClasse);


  FoTela.ccCadastro.Execute(acSalvar);

  gsNumeroProc := SomenteNumeros(FoTela.tvProcDependente.Items.Item[0].Text);
  gsNumeroProcDependente := SomenteNumeros(FoTela.tvProcDependente.Items.Item[1].Text);

end;

end.


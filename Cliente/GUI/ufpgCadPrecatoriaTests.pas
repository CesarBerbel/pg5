unit ufpgCadPrecatoriaTests;

interface

uses
  ufpgGUITestCase, ufpgCadPrecatoria, ufpgCadPrecatoriaModelTests, ufpgDataModelTests;

type
  TffpgCadPrecatoriaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadPrecatoria;
    FoDados: TffpgCadPrecatoriaModelTests;
    procedure CadastrarCartaPrecatoria;
    procedure PreencherDados;
    procedure SelecionarJuizDeprecante;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadastroCartaPrecatoria;
  end;

implementation

uses
  Windows, TestFramework, uspInterface, usaj5CadJuizoDeprecante;

procedure TffpgCadPrecatoriaTests.CadastrarCartaPrecatoria;
var
  bDistribuir, bDigitalizar, bSalvar: boolean;
begin
  AbrirTela;
  FoTela := TffpgCadPrecatoria(spTela);
  FoDados := TffpgCadPrecatoriaModelTests(spDataModelTests);

  FoTela.ccCadastro.Execute(acNovo);

  PreencherDados;

  FoTela.ccCadastro.Execute(acSalvar);
  bDistribuir := FoTela.pbDistribuiProcesso.Enabled;
  bDigitalizar := FoTela.pbDigitalizar.Enabled;
  bSalvar := FoTela.bcBotoesCadastro.AcaoHabilitado(acSalvar);
  FecharTela;

  CheckTrue(bDistribuir, 'O botão Distribuir processo não foi habilitado corretamente');
  CheckTrue(bDigitalizar, 'O botão Digitalizar peças não foi habilitado corretamente');
  checkFalse(bSalvar, 'O botão Salvar foi habilitado incorretamente');
end;

function TffpgCadPrecatoriaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadPrecatoriaModelTests;
end;

procedure TffpgCadPrecatoriaTests.TestarCadastroCartaPrecatoria;
begin
  ExecutarRoteiroTestes(CadastrarCartaPrecatoria);
end;

procedure TffpgCadPrecatoriaTests.SelecionarJuizDeprecante;
var
  oTelaJuizoDeprec: Tfsaj5CadJuizoDeprecante;
begin
  oTelaJuizoDeprec := Tfsaj5CadJuizoDeprecante(PegarTela('fsaj5CadJuizoDeprecante'));
  Sleep(5000);
  oTelaJuizoDeprec.ccPai.Execute(acFecharForm);
end;

procedure TffpgCadPrecatoriaTests.PreencherDados;
begin
  CheckCampoPreenchido(FoTela.csClasse.dfCodigo);
  EnterTextInto(FoTela.csAssuntoForm.dfCodigo, FoDados.fpgAssuntoPrincipal);
  EnterTextInto(FoTela.csCompetencia.dfCdTipoCartorio, FoDados.fpgCompetencia);
  EnterTextInto(FoTela.csComarca.dfcdMunicipio, FoDados.fpgComarca);
  EnterTextInto(FoTela.dfNmJuizoDeprec, FoDados.fpgJuizo);

  SelecionarJuizDeprecante;

  CheckCampoPreenchido(FoTela.dfnmJuizoDeprec);
  EnterTextInto(FoTela.dfNuOrigemPrecatoria, FoDados.fpgNuOrigem);

  FoTela.dfdeClasseOrigemPrec.DefineTexto(FoDados.fpgClasseOrigem);
  tab;
  FoTela.csObjeto.dfCdObjetoPrecat.DefineTexto(FoDados.fpgObjetoPrecatoria);
  tab;
  EnterTextInto(FoTela.mmObjeto.spMemoInterno, FoDados.fpgComplementoObjeto);
  Sleep(5000);
end;

end.


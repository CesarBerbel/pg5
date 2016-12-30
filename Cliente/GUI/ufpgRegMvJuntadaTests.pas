unit ufpgRegMvJuntadaTests;

interface

uses
  ufpgGUITestCase, ufpgDataModelTests, ufpgRegMvJuntada,
  ufpgRegMvJuntadaModelTests;


type
  TffpgRegMvJuntadaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRegMvJuntada;
    FoDados: TffpgRegMvJuntadaModelTests;
    procedure RegMvJuntada;
    procedure PreencherDados;
    procedure ConfirmarGuiaPostagemEJuntada;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarRegMvJuntada;
  end;

implementation

uses
  TestFramework, ufpgVariaveisTestesGUI, uspInterface, usarConfirmacao, usajConstante;

{ TffpgRegMvJuntadaTests }

function TffpgRegMvJuntadaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRegMvJuntadaModelTests;
end;

procedure TffpgRegMvJuntadaTests.RegMvJuntada;
begin
  AbrirTela;
  FoTela := TffpgRegMvJuntada(spTela);
  FoDados := TffpgRegMvJuntadaModelTests(spDataModelTests);

  PreencherDados;

  FoTela.ccCadastro.Execute(acSalvar);
  ConfirmarGuiaPostagemEJuntada;
  FecharTela;
  Check(Fodados.VerificarJuntadaAR(FoDados.fpgnuar, Fodados.fpgCdEstadoAR),
    'A juntada da AR ' + FoDados.fpgnuar + ' não foi realizada.');
end;

procedure TffpgRegMvJuntadaTests.TestarRegMvJuntada;
begin
  ExecutarRoteiroTestes(RegMvJuntada);
end;

procedure TffpgRegMvJuntadaTests.ConfirmarGuiaPostagemEJuntada;
var
  oTelaConfirmacao: TfsarConfirmacao;
begin
  oTelaConfirmacao := PegarTela('fsarConfirmacao') as TfsarConfirmacao;
  EnterTextInto(oTelaConfirmacao.dfSenha, spSenha, False);
  oTelaConfirmacao.cbImprimir.Checked := FoDados.fpgImprimir;
  oTelaConfirmacao.ccCadastro.Execute(acSelecionar);
end;

procedure TffpgRegMvJuntadaTests.PreencherDados;
begin
  if FoDados.fpgNuAr = STRING_INDEFINIDO then
    FoDados.fpgNuAr := gsNuAR;
  checkTrue(FoDados.fpgNuAr <> STRING_INDEFINIDO, 'Número de AR não encontrado');

  EnterTextInto(FoTela.csAR.dfcdARTJ, FoDados.fpgNuAr, False);
end;

end.


unit ufpgRelPubProcDistribSPTests;

interface

uses
  TestFrameWork, ufpgRelPubProcDistribSP, ufpgGUITestCase, ufpgRelPubProcDistribSPModelTests,
  ufpgDataModelTests;

type
  TffpgRelPubProcDistribSPTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRelPubProcDistribSP;
    FoDados: TffpgRelPubProcDistribSPModelTests;
    procedure PreencherDados;
    procedure CheckResultado;
    procedure RelPubProcDistribSP;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarRelPubProcDistribSP;
  end;

implementation

{ TffpgRelPubProcDistribSPTests }

uses
  usajConstante, ufpgFuncoesGUITestes, SysUtils, ufpgVariaveisTestesGUI;

procedure TffpgRelPubProcDistribSPTests.TestarRelPubProcDistribSP;
begin
  ExecutarRoteiroTestes(RelPubProcDistribSP);
end;

procedure TffpgRelPubProcDistribSPTests.RelPubProcDistribSP;
begin
  spNomeMenuItem := 'imffpgRelPubProcDistrib';

  FoDados := TffpgRelPubProcDistribSPModelTests(spDataModelTests);

  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgRelPubProcDistribSP');

  FoTela := TffpgRelPubProcDistribSP(spTela);

  PreencherDados;

  spVerificadorTelas.RegistrarMensagem('O arquivo*', 'OK');

  FoTela.pbGerar.Click;

  CheckResultado;
end;

function TffpgRelPubProcDistribSPTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRelPubProcDistribSPModelTests;
end;

procedure TffpgRelPubProcDistribSPTests.PreencherDados;
begin
  if FoDados.fpgPeriodoInicial = STRING_INDEFINIDO then
    FoDados.fpgPeriodoInicial := FormatDateTime('dd/mm/yyyy', Now);
  FoTela.spPeriodoPesq.FdfDataInicial.DefineTexto(FoDados.fpgPeriodoInicial);

  if FoDados.fpgPeriodoFinal = STRING_INDEFINIDO then
    FoDados.fpgPeriodoFinal := FormatDateTime('dd/mm/yyyy', Now);
  FoTela.spPeriodoPesq.FdfDataFinal.DefineTexto(FoDados.fpgPeriodoFinal);

  if FoDados.fpgForo = STRING_INDEFINIDO then
    FoDados.fpgForo := gsForo;
  Check(FoDados.fpgForo <> STRING_INDEFINIDO, 'Informar Foro.');
  EnterTextInto(FoTela.csForo.dfCdForo, FoDados.fpgForo);

  EnterTextCheckBox(FoTela.cbProcCiveis, FoDados.fpgGeraProcCiveis);
  EnterTextCheckBox(FoTela.cbProcCrime, FoDados.fpgGeraProcCriminais);
  EnterTextCheckBox(FoTela.cbPrecCiveis, FoDados.fpgGeraPrecCiveis);
  EnterTextCheckBox(FoTela.cbPrecCrime, FoDados.fpgGeraPrecCriminais);
end;

procedure TffpgRelPubProcDistribSPTests.CheckResultado;
begin
  if FoDados.fpgGeraProcCiveis then
    Check(FileExists(FoTela.edArqProcCiveis.PegaTexto), 'Arquivo nao foi criado.');

  if FoDados.fpgGeraProcCriminais then
    Check(FileExists(FoTela.edArqProcCrime.PegaTexto), 'Arquivo nao foi criado.');

  if FoDados.fpgGeraPrecCiveis then
    Check(FileExists(FoTela.edArqPrecCiveis.PegaTexto), 'Arquivo nao foi criado.');

  if FoDados.fpgGeraPrecCriminais then
    Check(FileExists(FoTela.edArqPrecCrime.PegaTexto), 'Arquivo nao foi criado.');
end;

procedure TffpgRelPubProcDistribSPTests.TearDown;
begin
  if FoDados.fpgFecharTela then
    FecharTela;
  inherited;
end;

end.


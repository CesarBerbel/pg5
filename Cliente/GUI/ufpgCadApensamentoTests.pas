unit ufpgCadApensamentoTests;

interface

uses
  ufpgCadApensamento, ufpgcadApensamentoModelTests, ufpgGUITestCase, ufpgDataModelTests,
  FutureWindows, SysUtils;

type
  TffpgCadApensamentoTests = class(TfpgGUITestCase)
  private
    procedure PreencherDadosApensamento;
    procedure SelecionarDependente(const poWindow: IWindow);
    procedure SelecionarDependente2(const poWindow: IWindow);
    procedure DesapensarProcesso;
  public
    FoTela: TffpgCadApensamento;
    FoDados: TffpgCadApensamentoModelTests;
    procedure ApensarProcesso;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarApensarProcesso;
  end;

implementation

uses
  TestFramework, uspInterface, ufpgVariaveisTestesGUI, ufpgFuncoesGUITestes,
  usajSelecionaDependentes, Forms, usajConstante;

{ TffpgCadApensamentoTests }

procedure TffpgCadApensamentoTests.ApensarProcesso;
begin
  FoDados := TffpgCadApensamentoModelTests(spDataModelTests);
  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgCadApensamento');

  FoTela := TffpgCadApensamento(spTela);

  PreencherDadosApensamento;
  FoTela.ccCadastro.Execute(acSalvar);

  Check(FoDados.VerificaApensamento(gsCdProcesso, FoDados.fpgCdSituacaoProcesso),
    'Processo: ' + FoDados.fpgNuProcesso + ' não foi apensado');

  if FoDados.fpgDesapensar then
  begin
    DesapensarProcesso;
  end;

  FecharTela;
end;

function TffpgCadApensamentoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadApensamentoModelTests;
end;

procedure TffpgCadApensamentoTests.PreencherDadosApensamento;
begin
  if FoDados.fpgAbrirDoMenu then
  begin
    if (FoDados.fpgNuProcesso = STRING_INDEFINIDO) or
      (FoDados.fpgNuProcessoApenso = STRING_INDEFINIDO) then
    begin
      FoDados.fpgNuProcesso := usarProcessoArray;
      checkTrue(FoDados.fpgNuProcesso <> STRING_INDEFINIDO,
        'Número de Processo principal não encontrado');
      FoDados.fpgNuProcessoApenso := usarProcessoArray;
      checkTrue(FoDados.fpgNuProcessoApenso <> STRING_INDEFINIDO,
        'Número de Processo para apensamento não encontrado');
    end;

    EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
    FoTela.dfnuProcesso.FdfNumeroDependente.SetFocus;
    TFutureWindows.Expect('TfsajSelecionaDependentes').Execproc(SelecionarDependente);
    Tab;

    EnterTextInto(FoTela.dfNuProcessoApenso.FdfNumeroProcessoExterno,
      FoDados.fpgNuProcessoApenso, False);
    FoTela.dfNuProcessoApenso.FdfNumeroDependente.SetFocus;
    TFutureWindows.Expect('TfsajSelecionaDependentes').Execproc(SelecionarDependente2);
    Tab;
  end;

  EnterTextInto(FoTela.mmDeMotivo.spMemo, FoDados.fpgMotivo, False);
end;

procedure TffpgCadApensamentoTests.SelecionarDependente(const poWindow: IWindow);
var
  oTela: TfsajSelecionaDependentes;
begin
  oTela := poWindow.asControl as TfsajSelecionaDependentes;
  oTela.FlsajProcesso.edit;
  oTela.spControleCadastro.Execute(acSelecionar);
end;

procedure TffpgCadApensamentoTests.SelecionarDependente2(const poWindow: IWindow);
var
  oTela: TfsajSelecionaDependentes;
begin
  oTela := poWindow.asControl as TfsajSelecionaDependentes;
  oTela.tvDependentes.Items[1].Selected := True;
  application.ProcessMessages;
  oTela.spControleCadastro.Execute(acSelecionar);
end;

procedure TffpgCadApensamentoTests.TestarApensarProcesso;
begin
  ExecutarRoteiroTestes(ApensarProcesso);
end;

procedure TffpgCadApensamentoTests.DesapensarProcesso;
begin
  FoTela.pbDesapensar.Click;
  FoTela.ccCadastro.Execute(acSalvar);
  Check(DateToStr(FoTela.dfdtDesapensamento.Value) <> STRING_INDEFINIDO,
    'O processo: ' + FoDados.fpgNuProcesso + ' não foi desapensado');
end;

end.


unit ufpgCancelJuntadaPetTests;

interface

uses
  ufpgCancelJuntadaPet, ufpgGUITestCase, ufpgCancelJuntadaPetModelTests,
  FutureWindows, usajSelecionaDependentes, ufpgDataModelTests, usajConstante,
  ufpgFuncoesGUITestes, uspInterface, uspSendKeys;

type
  TffpgCancelJuntadaPetTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCancelJuntadaPet;
    FoDados: TffpgCancelJuntadaPetModelTests;
    procedure CancelarJuntada;
    procedure PreencherDados;
    procedure PegarTelaModal(const poWindow: IWindow);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCancelamentoJuntada;

  end;

implementation

{ TffpgCancelJuntadaPetTests }

function TffpgCancelJuntadaPetTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCancelJuntadaPetModelTests;
end;

procedure TffpgCancelJuntadaPetTests.CancelarJuntada;
begin
  AbrirTela;
  FoTela := TffpgCancelJuntadaPet(spTela);
  FoDados := TffpgCancelJuntadaPetModelTests(spDataModelTests);

  if FoDados.fpgUsaProcesso then
  begin
    if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
      FoDados.fpgNuProcesso := UsarProcessoArray;
    Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado.');
  end;
  TFutureWindows.Expect('TfsajSelecionaDependentes', 1000).ExecProc(PegarTelaModal);
  PreencherDados;

  spVerificadorTelas.RegistrarMensagem('Cancelamento de juntada foi concluído com sucesso.', 'OK');
  FoTela.ccCadastro.Execute(acSalvar);

  FecharTela;
end;

procedure TffpgCancelJuntadaPetTests.PreencherDados;
begin
  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  EnterTextInto(FoTela.mmMotivo, FoDados.fpgMotivo, False);
end;

procedure TffpgCancelJuntadaPetTests.PegarTelaModal(const poWindow: IWindow);
var
  oTela: TfsajSelecionaDependentes;
begin
  oTela := poWindow.asControl as TfsajSelecionaDependentes;
  EnviarTeclas(oTela.tvDependentes, '({END})');
  oTela.spControleCadastro.Execute(acSelecionar);
end;

procedure TffpgCancelJuntadaPetTests.TestarCancelamentoJuntada;
begin
  ExecutarRoteiroTestes(CancelarJuntada);
end;

end.


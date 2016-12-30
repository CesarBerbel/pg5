//27/04/2016 - Shirleano.Junior - Task: 43059
// Refatorado.
unit ufpgCadMovimentacaoLoteTests;

interface

uses
  TestFrameWork, ufpgCadMovimentacaoLote, ufpgGUITestCase, ufpgCadMovimentacaoLoteModelTests,
  ufpgDataModelTests;

type
  TffpgCadMovimentacaoLoteTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadMovimentacaoLote;
    FoDados: TffpgCadMovimentacaoLoteModelTests;
    procedure LancarMovimentacaoLote;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarLancarMovimentacaoLote;
  end;

implementation

uses
  uspInterface, usajConstante, Forms, FutureWindows, SysUtils, usajAssistente,
  ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgFuncoesGUITestes;

{ TffpgCadMovimentacaoLoteTests }

procedure TffpgCadMovimentacaoLoteTests.TestarLancarMovimentacaoLote;
begin
  ExecutarRoteiroTestes(LancarMovimentacaoLote);
end;

function TffpgCadMovimentacaoLoteTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadMovimentacaoLoteModelTests;
end;

procedure TffpgCadMovimentacaoLoteTests.LancarMovimentacaoLote;
var
  i: integer;
begin
  AbrirTela;
  FoTela := TffpgCadMovimentacaoLote(spTela);
  FoDados := TffpgCadMovimentacaoLoteModelTests(spDataModelTests);

  spVerificadorTelas.RegistrarMensagem('A operação foi concluída com sucesso.', 'OK');
  EnterTextInto(FoTela.csTipoMvProcesso.dfCodigo, FoDados.fpgTipoMovimentacao);
  EnterTextInto(FoTela.csLocalFisico.dfcdLocalFisico, FoDados.fpgLocalFisico);
  EnterTextInto(FoTela.csJuiz.dfcdAgente, FoDados.fpgMagistrado);

  if FoDados.fpgQtdProcesso = STRING_INDEFINIDO then
    FoDados.fpgQtdProcesso := IntToStr(Length(gsNuProcessosArray));


  for i := 0 to StrToInt(FoDados.fpgQtdProcesso) - 1 do
  begin
    TFutureWindows.Expect('TfsajAssistente').ExecProc(FecharJanelaModal);
    FoDados.fpgNuProcesso := usarProcessoArray;
    EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  end;

  FoTela.ccCadastro.Execute(acSalvar);

  Check(FoDados.ChecarMovLancadasLote(FoDados.fpgNuProcesso),
    'Movimentação em lote não foi cadastrado');
end;

procedure TffpgCadMovimentacaoLoteTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.


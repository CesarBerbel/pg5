//27/04/2016 - Shirleano.Junior - Task: 43059
// Refatorado.
unit ufpgRemessaTests;

interface

uses
  FutureWindows, ufpgDataModelTests, ufpgGUITestCase, ufpgRemessaModelTests, ufpgRemessa;

type
  TffpgRemessaTests = class(TfpgGUITestCase)
  private
    procedure RealizarRemessa;
    procedure PreencherDados;
    procedure ConfirmarRemessa;
//    procedure FinalizarPendencia(const poWindow: IWindow);
  public
    FoTela: TffpgRemessa;
    FoDados: TffpgRemessaModelTests;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarRemessaCarga;
  end;

implementation

uses
  ufpgConstanteGUITests, ucgoConfirmacao, ufpgVariaveisTestesGUI,
  Controls, usajConstante, uspInterface, TestFramework, SysUtils, ufpgFuncoesGUITestes;

{ TffpgRemessaTests }

function TffpgRemessaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRemessaModelTests;
end;

procedure TffpgRemessaTests.PreencherDados;
var
  i: integer;
begin
  FoTela.ccCadastro.Execute(acNovo);
  gsNulote := FoTela.csLote.dfnuLote.PegaTexto;
  EnterTextInto(FoTela.cgoLocalizacao.csTipoLocalOrigem.dfCdTipoLocal, FoDados.fpgTipoLocalOrigem);
  EnterTextInto(FoTela.cgoLocalizacao.csLocalOrigem.dfcdLocal, FoDados.fpgLocalOrigem);
  EnterTextInto(FoTela.cgoLocalizacao.csTipoLocalDestino.dfCdTipoLocal,
    FoDados.fpgTipoLocalDestino);

  if FoDados.fpgAdvogado then
    EnterTextInto(FoTela.cgoLocalizacao.csLocalDestino.dfdeLocal, FoDados.fpgLocalDestino)
  else
    EnterTextInto(FoTela.cgoLocalizacao.csLocalDestino.dfcdLocal, FoDados.fpgLocalDestino);

  EnterTextInto(FoTela.csTipoMvProcesso.dfCodigo, FoDados.fpgTipoMovimentacao);

  if FoDados.fpgMaisProcessos then
  begin
    for i := 0 to FoDados.fpgQtdProcessos - 1 do
    begin
      TFutureWindows.Expect('TfsajAssistente', 1000).ExecProc(FinalizarPendencia);
      EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, usarProcessoArray, False);
    end;
  end
  else
  begin

    if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
      FoDados.fpgNuProcesso := UsarProcessoArray;
    Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado.');

    FoDados.fpgQtdProcessos := 1;

    TFutureWindows.Expect('TfsajAssistente', 1000).ExecProc(FinalizarPendencia);
    EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  end;

  EnterTextInto(FoTela.dfnuprazo, FoDados.fpgPrazo);

  EnterTextCheckBox(FoTela.cbxRecebimentoAutomatico, FoDados.fpgReceberAutomatico);
  gsLocalOrigem := FoTela.cgoLocalizacao.csLocalOrigem.dfdeLocal.PegaTexto;
  gsLocalDestino := FoTela.cgoLocalizacao.csLocalDestino.dfdeLocal.PegaTexto;
end;

procedure TffpgRemessaTests.ConfirmarRemessa;
var
  oTelaConfirmacao: TfcgoConfirmacao;
begin
  oTelaConfirmacao := PegarTela('fcgoConfirmacao') as TfcgoConfirmacao;
  EnterTextInto(oTelaConfirmacao.dfedSenha, spSenha);
  oTelaConfirmacao.ccCadastro.Execute(acSelecionar);
end;


procedure TffpgRemessaTests.RealizarRemessa;
var
  bSucesso: boolean;
begin
  AbrirTela;
  FoTela := TffpgRemessa(spTela);
  FoDados := TffpgRemessaModelTests(spDataModelTests);
  PreencherDados;

  FoTela.pbRemeter.Click;
  ConfirmarRemessa;

  bSucesso := FoDados.VerificarLoteEmitido(gsNulote, FoDados.fpgForo,
    FoDados.fpgTipoLocalDestino, FoDados.fpgLocalDestino) = FoDados.fpgQtdProcessos;

  check(bSucesso, 'O lote ' + gsNuLote + ' não foi remetido');
end;

procedure TffpgRemessaTests.TestarRemessaCarga;
begin
  ExecutarRoteiroTestes(RealizarRemessa);
end;

end.


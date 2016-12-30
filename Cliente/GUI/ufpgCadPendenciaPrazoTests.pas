unit ufpgCadPendenciaPrazoTests;

interface

uses
  ufpgCadPendenciaPrazo, ufpgGUITestCase, ufpgCadPendenciaPrazoModelTests, ufpgDataModelTests;

type
  TffpgCadPendenciaPrazoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadPendenciaPrazo;
    FoDados: TffpgCadPendenciaPrazoModelTests;
    procedure CadastroPendenciaPrazo;
    procedure PreencherDados;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadastroPendenciaPrazo;
  end;

implementation

{ TffpgCadPendenciaPrazoTests }

uses
  TestFramework, usajConstante, usajAssistente, ufpgFuncoesGUITestes,
  ufpgVariaveisTestesGUI, uspInterface, SysUtils, ufpgConstanteGUITests;

procedure TffpgCadPendenciaPrazoTests.CadastroPendenciaPrazo;
begin
  AbrirTela;
  FoTela := TffpgCadPendenciaPrazo(spTela);
  FoDados := TffpgCadPendenciaPrazoModelTests(spDataModelTests);

  FoTela.ccDados.Execute(acNovo);

  PreencherDados;

  FoTela.ccDados.Execute(acSalvar);

  FecharTela;
  check(FoDados.ChecarPendencia(FoDados.fpgDePendencia, spUsuario),
    'Pendencia não foi salva no BD');
end;

function TffpgCadPendenciaPrazoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadPendenciaPrazoModelTests;
end;

procedure TffpgCadPendenciaPrazoTests.TestarCadastroPendenciaPrazo;
begin
  ExecutarRoteiroTestes(CadastroPendenciaPrazo);
end;

procedure TffpgCadPendenciaPrazoTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.sajNumeroProcessoC.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  FoTela.dfdePendencia.Lines.Add(FoDados.fpgDePendencia);

  EnterTextInto(FoTela.dfdtPublicCircul, FormatDateTime(CS_FORMATO_DATA, Now), False);
  FoTela.dfdtPublicCirculExit(FoTela);

  FoTela.esajPendenciaPrazo.FieldByName('DTPUBLICCIRCUL').AsDateTime := Now;

  EnterTextInto(FoTela.dfnuDiasPrazo, FoDados.fpgNuDias);
  FoTela.dfnuDiasPrazoExit(FoTela);
  gsPendencia := FoDados.fpgDePendencia + ' (' + FoTela.dfdtVenctoPrazo.PegaTexto + ')';
end;

end.


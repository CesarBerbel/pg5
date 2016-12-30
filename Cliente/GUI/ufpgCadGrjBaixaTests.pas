unit ufpgCadGrjBaixaTests;

interface

uses
  ufpgCadGrjBaixa, ufpgGUITestCase, ufpgCadGrjBaixaModelTests, ufpgDataModelTests;

type
  TffpgCadGrjBaixaTests = class(TfpgGUITestCase)
  private
    Fotela: TffpgCadGrjBaixa;
    FoDados: TffpgCadGrjBaixaModelTests;
    procedure BaixaDeGuias;
    procedure PreencherDados;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarBaixaDeGuias;
  end;

implementation

uses
  ufpgVariaveisTestesGUI, uspInterface, ufpgFuncoesGUITestes, ufpgConstanteGUITests, DB;

var
  sValor: string;

procedure TffpgCadGrjBaixaTests.BaixaDeGuias;
begin
  AbrirTela;
  Fotela := TffpgCadGrjBaixa(spTela);
  FoDados := TffpgCadGrjBaixaModelTests(spDataModelTests);

  PreencherDados;

  FoTela.bcBotoesCadastro.spControleCadastro.Execute(acSalvar);

  sValor := Copy(gsNuGuiaGRJ, 4, Length(gsNuGuiaGRJ));
  check(FoDados.VerificarGuia(gsForo, sValor, True), 'Falha - Validar Guia Emitida Baixada!');

  FecharTela;
end;

function TffpgCadGrjBaixaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadGrjBaixaModelTests;
end;

procedure TffpgCadGrjBaixaTests.TestarBaixaDeGuias;
begin
  ExecutarRoteiroTestes(BaixaDeGuias);
end;

procedure TffpgCadGrjBaixaTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.sajNumeroProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  FoTela.pbPesquisar.Click;

  sValor := SomenteNumeros(FoTela.eccpGrjEmitida.FieldByName(
    'nuGrjEmitidaFor').AsString);
  check(sValor = gsNuGuiaGRJ, 'Falha - Guia tela baixa!');

  FoTela.grDados.DataSource.DataSet.First;
  if not (FoTela.grDados.DataSource.DataSet.State in dsEditMOdes) then
    FoTela.grDados.DataSource.DataSet.Edit;
  EnterTextGrid(FoTela.grDados, 'S', 0);
end;

end.
  

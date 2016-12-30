unit uwflEncaminhaProcessoTests;

interface

uses
  TestFramework, ufpgGUITestCase, uwflEncaminhaProcesso, uwflEncaminhaProcessoModelTests,
  uspDataModelTests, FutureWindows, usajConstante, ufpgFuncoesTestes, SysUtils, uspInterface;

type
  TfwflEncaminhaProcessoTests = class(TfpgGUITestCase)
  private
    FoTela: TfwflEncaminhaProcesso;
    FoDados: TfwflEncaminhaProcessoModelTests;
    procedure EncaminharProcesso;
    procedure PreencherDados;
    procedure VerificarProcessoFila;
  public
    function PegarClasseModelTests: TspDataModelTestsClass; override;
  published
    procedure TestarEncaminharProcesso;
  end;

implementation

{ TwflEncaminhaProcessoTests }

procedure TfwflEncaminhaProcessoTests.EncaminharProcesso;
begin
  FoDados := TfwflEncaminhaProcessoModelTests(spDataModelTests);
  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('fwflEncaminhaProcesso');

  FoTela := TfwflEncaminhaProcesso(spTela);

  if foDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado.');

  PreencherDados;
  if FoDados.fpgFecharTela then
    FecharTela;
  VerificarProcessoFila;
end;

function TfwflEncaminhaProcessoTests.PegarClasseModelTests: TspDataModelTestsClass;
begin
  result := TfwflEncaminhaProcessoModelTests;
end;

procedure TfwflEncaminhaProcessoTests.PreencherDados;
begin
  TFutureWindows.Expect('TfwflDemoEvento').ExecProc(FecharJanelaModal);
  FoTela.grFila.DataSource.DataSet.Locate('CDFILA', FoDados.fpgCopiarFila, []);
  FoTela.grFila.DataSource.DataSet.Edit;
  FoTela.grFila.DataSource.DataSet.FieldByName('flSelecionado').AsString := FoDados.fpgSelecionado;
  if not FoDados.fpgVariosProcessos then
  begin
    EnterTextInto(FoTela.dfdePendencia, FoDados.fpgDescricao);
    EnterTextInto(FoTela.dfdtInicio, DateToStr(Now));
    EnterTextInto(FoTela.dfnuPrazo, FoDados.fpgDias);
  end;
  FoTela.ccCadastro.Execute(acSalvar);
end;

procedure TfwflEncaminhaProcessoTests.TestarEncaminharProcesso;
begin
  ExecutarRoteiroTestes(EncaminharProcesso);
end;

procedure TfwflEncaminhaProcessoTests.VerificarProcessoFila;
begin
  check(FoDados.VerificarFilaProcesso(FoDados.fpgCDFilaSQL, FoDados.fpgNuProcesso),
    'O processo ' + FoDados.fpgNuProcesso + 'não foi copiado para fila 15');
end;

end.

